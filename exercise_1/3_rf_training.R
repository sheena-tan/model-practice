# L04 Judging Models ----
# Define and fit random forest model

## load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data



# load preporcessing/feature engineering/recipe



# model specifications
# don't worry about hyperparameters (mtry and trees) -- we will cover later
rf_spec <- 
  rand_forest(mtry = 3, trees = 500) %>%
  set_engine("ranger") %>% 
  set_mode("regression")

# define workflows


# fit workflows/models


# write out results (fitted/trained workflows)

