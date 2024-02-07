# L04 Judging Models ----
# Setup pre-processing/recipes

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data
load(here("data/titanic_train.rds"))

# linear models recipe
titanic_recipe_lm <- 
  recipe(survived ~ pclass + sex + age + sib_sp + parch + fare, titanic_train) |> 
  step_impute_linear(age) |> 
  step_dummy(pclass, sex)  |>   
  step_interact(~ starts_with("sex_"):fare)  |> 
  step_interact(~ age:fare)

# random forest recipe
titanic_recipe_rf <- 
  recipe(survived ~ pclass + sex + age + sib_sp + parch + fare, titanic_train) |> 
  step_impute_linear(age) |> 
  step_dummy(pclass, sex, one_hot = TRUE) 

# check recipes
titanic_recipe_lm |>
  prep() |>
  bake(new_data = NULL) |>
  glimpse()

titanic_recipe_rf |>
  prep() |>
  bake(new_data = NULL) |>
  glimpse()

# write out recipes
save(titanic_recipe_lm, file = here("exercise_2/recipes/titanic_recipe_lm.rds"))
save(titanic_recipe_rf, file = here("exercise_2/recipes/titanic_recipe_rf.rds"))




