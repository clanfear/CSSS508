# Script to generate example .csv files for Lecture 6
library(dplyr)
library(readr)
library(purrr)

N <- 10000
synthetic_data <- tibble(id = 1:N, x = rnorm(N, 1, 1), z = runif(N, 0, 1), split = round(runif(N, 1, 10)))

synthetic_data %>%
  group_by(split) %>% 
  group_walk(~ write_csv(.x, path = file.path(paste0("./Lectures/Week6/example_data/ex_dat_", .y$split, ".csv"))))
