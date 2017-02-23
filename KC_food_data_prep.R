#### "clean up" the King County restaurant inspection data ###
library(readr)
library(dplyr)
library(stringr)
library(lubridate)

# initial read in
rest_raw <- read_csv("Food_Establishment_Inspection_Data.csv")
# get the types
init_types <- substr(sapply(rest_raw, class), 1, 1)
# fix zip code
init_types["Zip Code"] <- "c"
# collapse and re-read in
rest_raw <- read_csv("Food_Establishment_Inspection_Data.csv",
                     col_types = paste(init_types, collapse = ""))

# fix the date
rest_raw <- rest_raw %>%
    mutate(`Inspection Date` = as.Date(mdy(`Inspection Date`)))

rest_seattle <- rest_raw %>%
    # subset to just Seattle
    filter(trimws(toupper(City)) == "SEATTLE") %>%
    # remove missing dates
    filter(!is.na(`Inspection Date`))

# add random whitespace to like 10% of business names
rest_seattle_whitespace <- rest_seattle %>%
    arrange(Business_ID, `Inspection Date`, `Violation Description`) %>%
    mutate(Name = str_pad(Name,
                          width = rbinom(nrow(rest_seattle),
                                         size = 5, prob = 0.05) +
                              nchar(Name),
                          side = "left")) %>%
    mutate(Name = str_pad(Name,
                          width = rbinom(nrow(rest_seattle),
                                         size = 5, prob = 0.05) +
                              nchar(Name),
                          side = "right"))

# get rid of some extra columns
seattle_restaurant_inspections <- rest_seattle_whitespace %>%
    select(Name, Date = `Inspection Date`, Description,
           Address, City, ZIP = `Zip Code`, Phone,
           Longitude, Latitude,
           Type = `Inspection Type`,
           Score = `Inspection Score`, Result = `Inspection Result`,
           Closure = `Inspection Closed Business`,
           Violation_type = `Violation Type`,
           Violation_description = `Violation Description`,
           Violation_points = `Violation Points`,
           Business_ID) %>%
    # keep 2012 forward
    filter(Date >= as.Date("2012-01-01")) %>%
    mutate(Closure = as.logical(Closure)) %>%
    mutate_each(funs(as.factor),
                Type, Result, Violation_type)

write_rds(seattle_restaurant_inspections,
          "seattle_restaurant_inspections.Rds")
write_csv(seattle_restaurant_inspections,
          "seattle_restaurant_inspections.csv")

# test dropbox link
download.file(url = "https://www.dropbox.com/s/ptm1xe43fatpl28/seattle_restaurant_inspections.Rds?raw=1",
              destfile = "TEST.Rds")
restaurants <- read_rds("TEST.Rds")