# L04 Judging Models ----
# Initial data checks & data splitting

# Random process below. Seed set before.

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data ----
titanic_data <- read_csv(here("data/titanic.csv"))

# change to factors and reorder ----
titanic_data <- titanic_data |>
  mutate(survived = factor(survived, levels = c("Yes", "No"), ordered = TRUE)) |> 
  mutate(pclass = factor(pclass))

# explore target variable distribution ----
ggplot(titanic_data, aes(survived)) +
  geom_bar()

summary(titanic_data$survived)

# set seed ----
set.seed(1104)

# data split with stratified sampling
titanic_split <- titanic_data |> initial_split(prop = 0.8, strata = age)
titanic_train <- training(titanic_split)
titanic_test <- testing(titanic_split)

# check split
count(titanic_train) / count(titanic_data)
count(titanic_test) / count(titanic_data)

# skim training data
skimr::skim(titanic_train)

# write out data ----
save(titanic_split, file = here("data/titanic_split.rds"))
save(titanic_train, file = here("data/titanic_train.rds"))
save(titanic_test, file = here("data/titanic_test.rds"))


