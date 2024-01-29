# L04 Judging Models ----
# Define and fit ordinary linear regression

## load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data
kc_train <- read_rds(here("data/kc_train.rds"))

# load preporcessing/feature engineering/recipe

# model specifications
lm_spec <- 
  linear_reg() |> 
  set_engine("lm") |> 
  set_mode("regression") 

# define workflows
lm_wflow <- 
  workflow() |> 
  add_model(lm_spec) |> 
  add_recipe(kc_recipe)

# fit workflows/models
lm_fit <- fit(lm_wflow, kc_train)

# write out results (fitted/trained workflows)
save(lm_fit, file = here("results/lm_fit.rda"))