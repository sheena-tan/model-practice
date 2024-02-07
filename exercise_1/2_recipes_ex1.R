# L04 Judging Models ----
# Setup pre-processing/recipes

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data
load(here("data/aba_train.rds"))

# Create a recipe appropriate for fitting linear models.
aba_recipe_lm <- recipe(age ~ ., data = aba_train) |> #predict age with all predictor variables
  step_rm(rings) |> #exclude rings
  step_dummy(type)  |>   #dummy code categorical predictors
  step_interact(~ starts_with("type_"):shucked_weight)  |> #create interactions
  step_interact(~ longest_shell:diameter)  |>
  step_interact(~ shucked_weight:shell_weight) |>
  step_normalize(all_numeric_predictors()) #center and scale all predictors

# Create a recipe for the random forest model.
aba_recipe_rf <- recipe(age ~ ., data = aba_train) |> #predict age with all predictor variables
  step_rm(rings) |> #exclude rings
  step_dummy(all_nominal_predictors(), one_hot = TRUE)  |>   #one-hot encode categorical predictors
  step_normalize(all_numeric_predictors()) #center and scale all predictors

# check recipes
aba_recipe_lm |>
  prep() |>
  bake(new_data = NULL) |>
  glimpse()

aba_recipe_rf |>
  prep() |>
  bake(new_data = NULL) |>
  glimpse()

# write out recipes
save(aba_recipe_lm, file = here("exercise_1/recipes/aba_recipe_lm.rds"))
save(aba_recipe_rf, file = here("exercise_1/recipes/aba_recipe_rf.rds"))

