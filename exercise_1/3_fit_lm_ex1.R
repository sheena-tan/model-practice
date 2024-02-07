# L04 Judging Models ----
# Define and fit ordinary linear regression

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
lm_spec <-
  linear_reg() |>
  set_engine("lm") |>
  set_mode("regression")

# define workflows ----
lm_wflow <- workflow()  |> #set up empty workflow
  add_model(lm_spec)  |> #add the model specification
  add_recipe(aba_recipe_lm) #add the recipe

# fit workflows/models ----
lm_fit <- lm_wflow |>
  fit(data = aba_train)

# write out results (fitted/trained workflows) ----
save(lm_fit, file = here("exercise_1/results/lm_fit.rds"))
