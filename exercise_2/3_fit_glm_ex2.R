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
load(here("exercise_2/recipes/titanic_recipe_lm.rds"))

# model specifications ----
glm_spec <-
  logistic_reg() |>
  set_engine("glm") |> 
  set_mode("classification")

# define workflows ----
glm_wflow <- workflow()  |> #set up empty workflow
  add_model(glm_spec)  |> #add the model specification
  add_recipe(titanic_recipe_lm) #add the recipe

# fit workflows/models ----
glm_fit <- glm_wflow |>
  fit(data = titanic_train)

# write out results (fitted/trained workflows) ----
save(glm_fit, file = here("exercise_2/results/glm_fit.rds"))
