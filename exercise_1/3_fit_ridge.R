# L04 Judging Models ----
# Define and fit penalized regression (lasso)

## load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data


# load preporcessing/feature engineering/recipe


# model specifications ----
# set penalty = 0.03
# mixture = 1 specifies lasso; mixture = 0 for ridge
ridge_spec <- 
  linear_reg(penalty = 0.03, mixture = 0) %>% 
  set_engine("glmnet") %>% 
  set_mode("regression")

# define workflows ----


# fit workflows/models ----


# write out results (fitted/trained workflows) ----

