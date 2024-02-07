# L04 Judging Models ----
# Define and fit penalized regression (lasso)

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data
load(here("data/aba_train.rds"))

# load pre-processing/feature engineering/recipe
load(here("exercise_1/recipes/aba_recipe_lm.rds"))

# model specifications ----
# set penalty = 0.03
# mixture = 1 specifies lasso; mixture = 0 for ridge
lasso_spec <-
  linear_reg(penalty = 0.03, mixture = 1) %>%
  set_engine("glmnet") %>%
  set_mode("regression")

# define workflows ----
lasso_wflow <-
  workflow() |>
  add_model(lasso_spec) |>
  add_recipe(aba_recipe_lm)

# fit workflows/models ----
lasso_fit <-
  lasso_wflow |>
  fit(aba_train)

# write out results (fitted/trained workflows) ----
save(lasso_fit, file = here("exercise_1/results/lasso_fit.rds"))
