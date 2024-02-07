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
rf_spec <-
  rand_forest() |>
  set_engine("ranger") |> 
  set_mode("classification")

# define workflows ----
rf_wflow <- workflow()  |> #set up empty workflow
  add_model(rf_spec)  |> #add the model specification
  add_recipe(titanic_recipe_rf) #add the recipe

# fit workflows/models ----
rf_fit <- rf_wflow |>
  fit(data = titanic_train)

# write out results (fitted/trained workflows) ----
save(rf_fit, file = here("exercise_2/results/rf_fit.rds"))
