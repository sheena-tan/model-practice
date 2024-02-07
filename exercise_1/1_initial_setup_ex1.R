# L04 Judging Models ----
# Initial data checks & data splitting

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data ----
aba_data <- read_csv(here("data/abalone.csv"))

# Task 1 ----
# Add `age`, the target variable, to the data set.
aba_data <- aba_data |>
  mutate(age = rings + 1.5)

# Describe the distribution of `age`.
ggplot(aba_data, aes(age)) +
  geom_bar()

summary(aba_data$age)

# Task 2 ----
# Set a seed so work is reproducible.
set.seed(1104)

# Split the abalone data into a training set and a testing set. Use stratified sampling.
aba_split <- aba_data |> initial_split(prop = 0.8, strata = age)
aba_train <- training(aba_split)
aba_test <- testing(aba_split)

# write out data ----
save(aba_split, file = here("data/aba_split.rds"))
save(aba_train, file = here("data/aba_train.rds"))
save(aba_test, file = here("data/aba_test.rds"))


