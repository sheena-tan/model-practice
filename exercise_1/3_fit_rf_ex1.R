# L04 Judging Models ----
# Define and fit random forest model

# Random process in script. Seed set right before.

## load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data
load(here("data/aba_train.rds"))

# load pre-processing/feature engineering/recipe
load(here("exercise_1/recipes/aba_recipe_rf.rds"))

# model specifications ----
# don't worry about hyperparameters (mtry and trees) -- we will cover later
rf_spec <-
  rand_forest(mtry = 3, trees = 1000) %>%
  set_engine("ranger") %>%
  set_mode("regression")

# define workflows ----
rf_wflow <-
  workflow() |>
  add_model(rf_spec) |>
  add_recipe(aba_recipe_rf)

# fit workflows/models ----
set.seed(1104)
rf_fit <-
  rf_wflow |>
  fit(aba_train)

# write out results (fitted/trained workflows) ----
save(rf_fit, file = here("exercise_1/results/rf_fit.rds"))
