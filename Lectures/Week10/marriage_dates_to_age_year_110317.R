rm(list=ls())
setwd("C:/Users/cclan/Dropbox/Ross Projects/Desistance")
#setwd("C:/Users/dkreager/My Documents/Lanfear work/Desistance Project/Sequences")
library(tidyverse); library(stringr); library(lubridate); library(foreign); library(reshape2)
`%!in%` <- Negate(`%in%`)
#-----------------------------------------------------------------------------------
load("./data/seqid_byr.Rdata")
load("./data/marriage_date_variables.RData")
load("./data/marriage_youth_variables.RData")
#-----------------------------------------------------------------------------------
mar_dates <- seqid_byr %>% left_join(marriage_date_variables, by="seqid")

mar_ages <- reshape(mar_dates, varying=list(
  marriage_date=c("first_mar_month_year", "second_mar_month_year", "third_mar_month_year"),
  divorce_date=c("first_div_month_year", "second_div_month_year", "third_div_month_year"),
  marriage_indicator=c("first_mar_indicator", "second_mar_indicator", "third_mar_indicator"),
  divorce_indicator=c("first_div_indicator", "second_div_indicator", "third_div_indicator")),
  timevar="marriage_n",  idvar="seqid",
  direction="long") %>% arrange(seqid) %>% 
  rename(mar_date=first_mar_month_year, div_date=first_div_month_year) %>%
  mutate_at(vars(byr, ends_with("date")), funs(year(parse_date_time(str_sub(., -2, -1), orders="y")))) %>%
  mutate(marriage_age=mar_date-byr, 
         divorce_age=div_date-byr, 
         censored_age=(1988+ever_mar_last_wave)-byr) %>% 
  select(seqid, byr, marriage_n, marriage_age, divorce_age, censored_age)


#Need censored waves! # Must determine last reported marriage date Indicators on
#marriage seem off; don't have good "never-married" indicators. # Crap: Problem is
#in use of indiv_mar for checking ever married; no one responds to this if not
#married, so it doesn't indicate non-marriage across all waves, looks like missing!
#Should have a third overall indicator for last reporting wave

#--- Once that is sorted out... Need a function that converts age_year SPANS of
#marriage and divorce into logicals for those age_years COuld this perhaps be done
#by generating a list, one element per person, each element being a vector of all
#ages with a known marriage? Or better, maybe just, for each person, check if the
#given age_year lies within those values!

# First need to make lists of all the age years married and known not married. This
# would involve making a seq from mar:div or mar:cens for every mar/div, then
# concatenating, assigning to list[[seqid]]

# These are separate so they can come from different places

# Calculating dates married
# If is.na(marriage_age)

married_years <- vector("list", nrow(mar_ages))
names(married_years) <- paste0(mar_ages$seqid, "-", mar_ages$marriage_n)
for (i in 1:nrow(mar_ages)){
  if (is.na(mar_ages$marriage_age[i])){
    married_years[[i]] <- NA
  } else if (!is.na(mar_ages$marriage_age[i]) & is.na(mar_ages$divorce_age[i])) {
      if (mar_ages$marriage_age[i]<=mar_ages$censored_age[i]){
         married_years[[i]] <- mar_ages$marriage_age[i]:mar_ages$censored_age[i]
      } else {
         married_years[[i]] <- mar_ages$marriage_age[i]
      }
  } else if (!is.na(mar_ages$marriage_age[i]) & !is.na(mar_ages$divorce_age[i])) {
    married_years[[i]] <- mar_ages$marriage_age[i]:mar_ages$divorce_age[i]
  } else {
    married_years[[i]] <- "ERROR"; print(paste0("Error on ", i))
  }
}

age_year_yes_list <- vector("list", 1526)
names(age_year_yes_list) <- paste0("seqid_",1:1526)
for (i in 1:1526){
  vals <- c(married_years[[(3*i)-2]], married_years[[(3*i)-1]], married_years[[(3*i)]])
  if (all(is.na(vals))) {
    age_year_yes_list[[i]] <- NA
  } else {
  age_year_yes_list[[i]] <- unique(vals[!is.na(vals)])
  }
}

unmarried_years <- vector("list", nrow(mar_ages))
names(unmarried_years) <- paste0(mar_ages$seqid, "-", mar_ages$marriage_n)
for (i in 1:nrow(mar_ages)){
  if (is.na(mar_ages$censored_age[i])) {
    unmarried_years[[i]] <- NA
  } else if (is.na(mar_ages$marriage_age[i])) {
    unmarried_years[[i]] <- 10:mar_ages$censored_age[i]
  } else if (!is.na(mar_ages$marriage_age[i]) & is.na(mar_ages$divorce_age[i])){
    unmarried_years[[i]] <- 10:mar_ages$marriage_age[i]
  } else if (!is.na(mar_ages$marriage_age[i]) & !is.na(mar_ages$divorce_age[i])) {
    unmarried_years[[i]] <- c(10:mar_ages$marriage_age[i], mar_ages$divorce_age[i]:mar_ages$censored_age[i])
  } else {
    unmarried_years[[i]] <- "ERROR"; print(paste0("Error on ", i))
  }
}

age_year_no_list <- vector("list", 1526)
names(age_year_no_list) <- paste0("seqid_",1:1526)
for (i in 1:1526){
  vals <- c(unmarried_years[[(3*i)-2]], unmarried_years[[(3*i)-1]], unmarried_years[[(3*i)]])
  if (all(is.na(vals))) {
    age_year_no_list[[i]] <- NA
  } else {
    age_year_no_list[[i]] <- unique(vals[!is.na(vals)])
    age_year_no_list[[i]] <- age_year_no_list[[i]][age_year_no_list[[i]] %!in% age_year_yes_list[[i]]]
  }
}


ay_list_to_ay_mat <- function(age_year_yes_list, age_year_no_list){
  age_year_mat <- setNames(as.data.frame(matrix(as.numeric(NA), ncol=length(10:27), nrow=1526)),
                           paste0("age_", 10:27))
  for(i in 1:1526){
    if (any(!is.na(age_year_yes_list[[i]]))){
      age_year_mat[i, age_year_yes_list[[i]]-9 ] <- 1
    }
    if (any(!is.na(age_year_no_list[[i]]))){
      age_year_mat[i, age_year_no_list[[i]]-9 ] <- 0
    }
  }
  return(age_year_mat)
}

mar_age_year_mat <- ay_list_to_ay_mat(age_year_yes_list = age_year_yes_list, age_year_no_list = age_year_no_list)
mar_age_year_mat <- mar_age_year_mat %>% mutate(seqid=1:1526) %>% select(seqid, starts_with("age"), -age_27)

#-----------------------------------------------------------------------------------
mar_age_year_youth_mat <- marriage_youth_variables %>% select(-mar_age_07, -mar_age_08, -mar_age_09, -byr)

mar_age_year_mat_combined <- mar_age_year_mat
mar_age_year_mat_combined[, -1] <- NA

for(i in 1:1526){
  for(j in 2:18){
    if (mar_age_year_youth_mat[i,j] %!in% c(NA, 9991)){
      mar_age_year_mat_combined[i,j] <- mar_age_year_youth_mat[i,j]
    } else if (!is.na(mar_age_year_mat[i,j])) {
      mar_age_year_mat_combined[i,j] <- mar_age_year_mat[i,j]
    } else {
      mar_age_year_mat_combined[i,j] <- mar_age_year_youth_mat[i,j]
    }
  }
}




#------------------------------------------
# load("./data/marriage_variables.RData")
# mar_vars <- marriage_variables %>% select(-married07, -married08, -married09)
# mar_vars[mar_vars==9999] <- NA
# names(mar_vars) <- c("seqid", paste0("age_", 10:26))

# for (i in 1:1526){
#   if (all(is.na(mar_age_year_mat[i,-1]))) {
#    mar_age_year_mat[i,-1] <- mar_vars[i,-1]
#  }
#  for(j in (ncol(mar_age_year_mat)-1):2) {
#    if (is.na(mar_age_year_mat[i,j]) & mar_age_year_mat[i,j+1] %in% 0) {
#      mar_age_year_mat[i,j] <- 0
#    } else if (is.na(mar_age_year_mat[i,j]) & mar_age_year_mat[i,j+1] %in% 1) {
#      print(paste0("Error in row ", i, ": 1 preceded by NA."))
#    } 
#  }
#}

#head(mar_age_year_mat, n=50)

# Checking consistency between these
#match <- matrix(NA, nrow=1526, ncol=2)
#for (i in 1:1526){
#  match[i,1] <- all(which(mar_vars[i, -1] %in% 1) %in% which(mar_age_year_mat[i, -1] %in% 1))
#  match[i,2] <- all(which(mar_age_year_mat[i, -1] %in% 1) %in% which(mar_vars[i, -1] %in% 1))
#}
#colSums(match)
## So, about 1439 / 1418 match. The other 100 or so do not. These must be reconciled.
#head(mar_vars[match[,1]==FALSE,])
#head(mar_age_year_mat[match[,1]==FALSE,])
#head(mar_dates[match[,1]==FALSE,])

#--------------------------

marriage_variables_from_dates <- mar_age_year_mat_combined
names(marriage_variables_from_dates) <- c("seqid", paste0("married", str_sub(names(mar_age_year_mat_combined)[-1], -2, -1)))
marriage_variables_from_dates[is.na(marriage_variables_from_dates)] <- 9999
save(marriage_variables_from_dates, file="./data/marriage_variables_from_dates.RData")
