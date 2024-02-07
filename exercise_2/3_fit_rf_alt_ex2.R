# L04 Judging Models ----
# Define and fit ...

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data
load(here("data/titanic_train.rds"))

# load pre-processing/feature engineering/recipe
load(here("exercise_2/recipes/titanic_recipe_rf.rds"))

# model specifications ----
rf_alt_spec <-
  rand_forest(mtry = 3, trees = 1000, min_n = 2) |>
  set_engine("ranger") |> 
  set_mode("classification")

# define workflows ----
rf_alt_wflow <- workflow()  |> #set up empty workflow
  add_model(rf_alt_spec)  |> #add the model specification
  add_recipe(titanic_recipe_rf) #add the recipe

# fit workflows/models ----
rf_alt_fit <- rf_alt_wflow |>
  fit(data = titanic_train)

# write out results (fitted/trained workflows) ----
save(rf_alt_fit, file = here("exercise_2/results/rf_alt_fit.rds"))
