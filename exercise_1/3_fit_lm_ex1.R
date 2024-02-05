# L04 Judging Models ----
# Define and fit ordinary linear regression

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data


# load pre-processing/feature engineering/recipe


# model specifications ----
lm_spec <- 
  linear_reg() |> 
  set_engine("lm") |> 
  set_mode("regression") 

# define workflows ----


# fit workflows/models ----


# write out results (fitted/trained workflows) ----
