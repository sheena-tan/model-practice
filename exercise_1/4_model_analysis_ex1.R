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
load(here("data/aba_test.rds"))

# load models ----
load(here("exercise_1/results/lm_fit.rds"))
load(here("exercise_1/results/lasso_fit.rds"))
load(here("exercise_1/results/ridge_fit.rds"))
load(here("exercise_1/results/rf_fit.rds"))

# model analysis ----
aba_metric <- metric_set(rmse, rsq, mae) #create a metric set

aba_res <- function(fitted_model, .data, target_var){
  fitted_model |>
    predict(.data) |>
    bind_cols(.data |> select({{ target_var }}))
} #function to create a tibble of predicted values

# create table to display results
performance_metrics <- lm_fit |> #start with ordinary linear regression metrics
  aba_res(aba_test, "age") |>
  aba_metric(truth = age, estimate = .pred) |> #apply the metric set to the tibble
  select(-.estimator) |>
  mutate(model_type = "lm") |>
  bind_rows(
    lasso_fit |> #add lasso metrics
      aba_res(aba_test, "age") |>
      aba_metric(truth = age, estimate = .pred) |>
      select(-.estimator) |>
      mutate(model_type = "lasso")
  ) |>
  bind_rows(
    ridge_fit |> #add ridge metrics
      aba_res(aba_test, "age") |>
      aba_metric(truth = age, estimate = .pred) |>
      select(-.estimator) |>
      mutate(model_type = "ridge")
  ) |>
  bind_rows(
    rf_fit |> #add random forest metrics
      aba_res(aba_test, "age") |>
      aba_metric(truth = age, estimate = .pred) |>
      select(-.estimator) |>
      mutate(model_type = "rf")
  ) |>
  pivot_wider(
    names_from = .metric,
    values_from = .estimate
  ) |>
  arrange(desc(rsq)) |>
  kable("html")

# save metrics table ----
writeLines(as.character(performance_metrics), here("exercise_1/results/performance_metrics.html"))

# graphical examination
rf_fit |>
  aba_res(aba_test, "age") |>
  ggplot(aes(age, .pred)) +
  geom_point(shape = 21, size = 1, fill = "grey80", alpha = 0.4) +
  theme_minimal() +
  coord_obs_pred() +
  geom_abline(aes(slope = 1, intercept = 0), linetype = "dashed") +
  labs(
    title = "Random Forest Prediction Model",
    y = "Predicted Age",
    x = "Age"
  )

lm_fit |>
  aba_res(aba_test, "age") |>
  ggplot(aes(age, .pred)) +
  geom_point(shape = 21, size = 1, fill = "grey80", alpha = 0.4) +
  theme_minimal() +
  coord_obs_pred() +
  geom_abline(aes(slope = 1, intercept = 0), linetype = "dashed") +
  labs(
    title = "Ordinary Linear Regression Prediction Model",
    y = "Predicted Age",
    x = "Age"
  )

lasso_fit |>
  aba_res(aba_test, "age") |>
  ggplot(aes(age, .pred)) +
  geom_point(shape = 21, size = 1, fill = "grey80", alpha = 0.4) +
  theme_minimal() +
  coord_obs_pred() +
  geom_abline(aes(slope = 1, intercept = 0), linetype = "dashed") +
  labs(
    title = "Lasso Prediction Model",
    y = "Predicted Age",
    x = "Age"
  )

ridge_fit |>
  aba_res(aba_test, "age") |>
  ggplot(aes(age, .pred)) +
  geom_point(shape = 21, size = 1, fill = "grey80", alpha = 0.4) +
  theme_minimal() +
  coord_obs_pred() +
  geom_abline(aes(slope = 1, intercept = 0), linetype = "dashed") +
  labs(
    title = "Ridge Prediction Model",
    y = "Predicted Age",
    x = "Age"
  )
