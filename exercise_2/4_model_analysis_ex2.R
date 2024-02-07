# L04 Judging Models ----
# Analysis of trained models 

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(kableExtra)

# handle common conflicts
tidymodels_prefer()

# load data ----
load(here("data/titanic_test.rds"))

# load models ----
load(here("exercise_2/results/glm_fit.rds"))
load(here("exercise_2/results/rf_fit.rds"))
load(here("exercise_2/results/rf_alt_fit.rds"))

# function to create tibble of performance values
titanic_res <- function(fitted_model, .data, target_var){
  fitted_model |>
    predict(.data) |>
    bind_cols(.data |> select({{ target_var }}))
} 

titanic_res(glm_fit, titanic_test, "survived")

# create table to display results
accuracy_table <- glm_fit |>
  titanic_res(titanic_test, "survived") |>
  accuracy(truth = survived, estimate = .pred_class) |> 
  select(-.estimator) |>
  mutate(model_type = "glm") |>
  bind_rows(
    rf_fit |> 
      titanic_res(titanic_test, "survived") |>
      accuracy(truth = survived, estimate = .pred_class) |>
      select(-.estimator) |>
      mutate(model_type = "rf")
  ) |>
  bind_rows(
    rf_alt_fit |> 
      titanic_res(titanic_test, "survived") |>
      accuracy(truth = survived, estimate = .pred_class) |>
      select(-.estimator) |>
      mutate(model_type = "rf_alt")
  )  |> 
  pivot_wider(
    names_from = .metric,
    values_from = .estimate
  ) |> 
  arrange(accuracy) |>
  kable("html")

# save accuracy table
writeLines(as.character(accuracy_table), here("exercise_2/results/accuracy_table.html"))

# create confusion matrix ----
conf_matrix <- predict(rf_alt_fit, titanic_test) |> 
  bind_cols(titanic_test) |> 
  conf_mat(truth = survived, estimate = .pred_class) 

conf_matrix

# create table of predicted/actual class probabilities ----
prob_table <- predict(rf_alt_fit, titanic_test, type = "prob") |> 
  bind_cols(titanic_test) |>
  select(.pred_Yes, .pred_No, survived, passenger_id) |> 
  kable("html") |> 
  kable_styling()

# save probability table
writeLines(as.character(prob_table), here("exercise_2/results/prob_table.html"))

# create ROC curve  ----
predicted_probs <- rf_alt_fit |> 
  predict(titanic_test, type = "prob") |> 
  bind_cols(titanic_test |> select(survived))

roc_curve <- roc_curve(predicted_probs, truth = survived, .pred_Yes)

roc_plot <- autoplot(roc_curve, main = "ROC Curve") +
  labs(x = "False Positive Rate", y = "True Positive Rate") +
  theme_minimal()

# save ROC plot
ggsave("images/roc_plot.png", plot = roc_plot, width = 6, height = 4)

# calculate AUC ----
roc_auc(predicted_probs, .pred_Yes, truth = survived)
