## Exercise 2

The R scripts included in this folder are as follows:

- `1_initial_setup_ex2.R`: Initial data checks & data splitting
- `2_recipes_ex2.R`: Setup pre-processing/recipes
- `3_fit_glm_ex2.R`: Define and fit logistic regression (glm)
- `3_fit_rf_ex2.R`: Define and fit random forest model with default parameters
- `3_fit_rf_alt_ex2.R`: Define and fit random forest model with custom parameters
- `4_model_analysis_ex2.R`: Analysis of trained models 

The `recipes` folder contains all recipes used for model fitting:

- `titanic_recipe_lm`: recipe use to fit logistic regression model
- `titanic_recipe_rf`: recipe use to fit random forest models

The `results` folder contains a table of model performance metrics `performance_metrics.html` and all fitted/trained models:

- `glm_fit`: fitted logistic regression model
- `rf_fit`: fitted random forest model (default)
- `rf_alt_fit`: fitted random forest model (custom)
- `accuracy_table.html`: table with model performance metrics (accuracy)
- `prob_table.html`: table of predicted class probabilities

