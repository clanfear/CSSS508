## ----download_restaurant_data, cache=TRUE--------------------------------
getwd() # maybe change this on your computer?
library(readr)
download.file(url = "https://www.dropbox.com/s/ptm1xe43fatpl28/seattle_restaurant_inspections.Rds?raw=1",
              destfile = "seattle_restaurant_inspections.Rds")
restaurants <- read_rds("seattle_restaurant_inspections.Rds")

## ----warning=FALSE, message=FALSE----------------------------------------
library(dplyr)

## ----nchar_zip, cache=TRUE-----------------------------------------------
restaurants %>% mutate(ZIP_length = nchar(ZIP)) %>%
    group_by(ZIP_length) %>% tally()

## ---- cache=TRUE---------------------------------------------------------
restaurants <- restaurants %>%
    mutate(ZIP_5 = substr(ZIP, 1, 5))
head(unique(restaurants$ZIP_5))

## ----mailing_address, cache=TRUE-----------------------------------------
restaurants <- restaurants %>%
    mutate(mailing_address = paste(Address,
                                   ", ",
                                   City,
                                   ", WA ",
                                   ZIP_5,
                                   sep = ""))
head(unique(restaurants$mailing_address))

## ----readr_types_example-------------------------------------------------
# use the class function to get the type of data
column_types <- sapply(restaurants, class)
# extract 1st character
column_types_1 <- substr(column_types, 1, 1)
# use paste with collapse to get one string
(column_types_collapse <- paste(column_types_1, collapse = ""))

## ----function_to_get_types-----------------------------------------------
readr_input_types <- function(data) {
    column_types_1 <- substr(sapply(data, class), 1, 1)
    return(paste(column_types_1, collapse = ""))
}
readr_input_types(swiss)
readr_input_types(restaurants)

## ----paste0--------------------------------------------------------------
paste(1:5, letters[1:5]) # sep is a space by default
paste(1:5, letters[1:5], sep ="")
paste0(1:5, letters[1:5])

## ----paste_practice, eval=FALSE------------------------------------------
## paste(letters[1:5], collapse = "!")
## paste(1:5, letters[1:5], sep = "+")
## paste0(1:5, letters[1:5], collapse = "???")
## paste(1:5, "Z", sep = "*")
## paste(1:5, "Z", sep = "*", collapse = " ~ ")

## ----load_stringr--------------------------------------------------------
library(stringr)

## ----str_sub_example-----------------------------------------------------
str_sub("Washington", 1, -3)

## ----str_c_example-------------------------------------------------------
str_c(letters[1:5], 1:5)

## ----nchar_v_str_length--------------------------------------------------
nchar(NA)
str_length(NA)

## ----make_seattle_uppercase, cache=TRUE----------------------------------
head(restaurants$City)
restaurants <- restaurants %>%
    mutate_each(funs(str_to_upper),
                Name, Address, City)
head(unique(restaurants$City))

## ----show_whitespace-----------------------------------------------------
head(restaurants$Name, 6)

## ----get_char_columns----------------------------------------------------
column_types <- sapply(restaurants, class)
char_columns <- names(column_types)[column_types == "character"]

## ----clean_whitespace, cache=TRUE----------------------------------------
# use mutate_each_ to trim all the character columns
restaurants <- restaurants %>%
    mutate_each_(funs(str_trim),
                 char_columns)
head(unique(restaurants$Name), 10)

## ----coffee_check, cache=TRUE--------------------------------------------
coffee <- restaurants %>%
    filter(str_detect(Name,
                      "COFFEE|ESPRESSO|ROASTER"))
head(unique(coffee$Name))

## ----coffee_histogram, fig.width = 10, fig.height = 3, dpi=300, out.width="1100px", out.height="330px"----
recent_coffee_scores <- coffee %>%
    select(Business_ID, Name, Score, Date) %>%
    group_by(Business_ID) %>%
    filter(Date == max(Date)) %>%
    distinct()
hist(recent_coffee_scores$Score,
     xlab = "Most recent inspection score",
     main = "Most recent inspection scores\nfor Seattle coffee shops")

## ----look_for_206--------------------------------------------------------
area_code_206_pattern <- "^\\(?206"
phone_test_examples <- c("2061234567",
                         "(206)1234567",
                         "(206) 123-4567",
                         "555-206-1234")
str_detect(phone_test_examples, area_code_206_pattern)

## ----look_for_206_rest, cache=TRUE---------------------------------------
restaurants %>%
    mutate(has_206_number = str_detect(Phone,
                                       area_code_206_pattern)) %>%
    group_by(has_206_number) %>%
    tally()

## ----test_direction------------------------------------------------------
direction_pattern <- " (N|NW|NE|S|SW|SE|W|E)( |$)"
direction_test_examples <- c("2812 THORNDYKE AVE W",
                             "512 NW 65TH ST",
                             "407 CEDAR ST",
                             "15 NICKERSON ST")
str_extract(direction_test_examples, direction_pattern)

## ----extract_directions, cache=TRUE--------------------------------------
restaurants %>%
    distinct(Address) %>%
    mutate(city_region = str_trim(str_extract(Address,
                                              direction_pattern))) %>%
    group_by(city_region) %>%
    tally() %>%
    arrange(desc(n))

## ----test_address_numbers------------------------------------------------
address_number_pattern <- "^[0-9]*-?[A-Z]? (1/2 )?"
address_number_test_examples <- c("2812 THORNDYKE AVE W",
                                  "1ST AVE",
                                  "10A 1ST AVE",
                                  "10-A 1ST AVE",
                                  "5201-B UNIVERSITY WAY NE", "7040 1/2 15TH AVE NW")
str_replace(address_number_test_examples,
            address_number_pattern,
            replacement = "")

## ----replace_numbers-----------------------------------------------------
restaurants <- restaurants %>%
    mutate(street_only = str_replace(Address,
                                     address_number_pattern,
                                     replacement = ""))
head(unique(restaurants$street_only), 12)

## ----test_unit_numbers---------------------------------------------------
address_unit_pattern <- " (#|STE|SUITE|SHOP|UNIT).*$"
address_unit_test_examples <- c("1ST AVE",
                                "RAINIER AVE S #A",
                                "FAUNTLEROY WAY SW STE 108",
                                "4TH AVE #100C",
                                "NW 54TH ST")
str_replace(address_unit_test_examples,
            address_unit_pattern,
            replacement = "")

## ----replace_units-------------------------------------------------------
restaurants <- restaurants %>%
    mutate(street_only = str_trim(str_replace(street_only,
                                              address_unit_pattern,
                                              replacement = "")))
head(unique(restaurants$street_only), 15)

## ----failed_inspections--------------------------------------------------
restaurants %>%
    select(Business_ID, Name, Date, Score, street_only) %>%
    distinct() %>%
    filter(Score > 45) %>%
    group_by(street_only) %>%
    tally() %>%
    arrange(desc(n))

## ----str_split_violation-------------------------------------------------
head(str_split_fixed(restaurants$Violation_description, " - ", n = 2))