# CSSS508, Week 8
# Download restaurant inspection data and save in R format for use in lecture.
library(tidyverse)

restaurants <- read_csv("C:/Users/cclan/Downloads/Food_Establishment_Inspection_Data.csv",
                        col_types="ccccccccddccicccciccci")
# Adding an extra space here for an example; shhhhh, tell no one the data were clean to begin with.
restaurants$Name[1] <- paste0(restaurants$Name[1], " ")
names(restaurants) <- str_replace_all(names(restaurants), " ", "_")
restaurants <- restaurants %>% mutate(Date=parse_date(Inspection_Date, "%m/%d/%Y"))
save(restaurants, file="C:/Users/cclan/OneDrive/GitHub/CSSS508/Lectures/Week8/restaurants.Rdata")
