options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(comment = "##")
library(dplyr)

library(xaringanthemer)
source("../csss508css.R")

c(1, 3, 7, -0.5)

length(c(1, 3, 7, -0.5))

c(1, 2, 3) + c(4, 5, 6)
c(1, 2, 3, 4)^3 # exponentiation with ^

c(0.5, 3) * c(1, 2, 3, 4)
c(0.5, 3, 0.5, 3) * c(1, 2, 3, 4) # same thing

3 * c(-1, 0, 1, 2) + 1

c(1, 2, 3, 4) + c(0.5, 1.5, 2.5)

sum(c(1, 2, 3, 4))
max(c(1, 2, 3, 4))

x <- c(97, 68, 75, 77, 69, 81, 80, 92, 50, 34, 66, 83, 62)
z <- (x - mean(x)) / sd(x)
round(z, 2)

seq(-3, 6, by = 1.75) # Sequence from -3 to 6, increments of 1.75
rep(c(-1, 0, 1), times = 3) # Repeat c(-1,0,1) 3 times
rep(c(-1, 0, 1), each = 3) # Repeat each element 3 times

n <- 12
1:n
n:4

class(9L)

first_names <- c("Andre", "Beth", "Carly", "Dan")
class(first_names)

sex <- factor(c("M", "F", "F", "M"))
sex

as.numeric(sex)

name_lengths <- nchar(first_names) # number of characters
name_lengths
name_lengths >= 4

name_lengths >= 4
mean(name_lengths >= 4)

even_length <- (name_lengths %% 2 == 0)
# %% is the modulo operator: gives remainder when dividing
even_length

second_letter_a <- (substr(first_names, start=2, stop=2) == "a")
# substr: substring (portion) of a char vector
second_letter_a

even_length & second_letter_a

even_length | second_letter_a

!(even_length | second_letter_a)

first_names[c(1, 4)]


first_names[-c(1, 4)]

first_names[even_length | second_letter_a]
first_names[sex != "F"] # != is "not equal to"

first_names %in% c("Andre", "Carly", "Dan")

which(first_names %in% c("Andre", "Carly", "Dan"))

vector_w_missing <- c(1, 2, NA, 4, 5, 6, NA)

mean(vector_w_missing)
mean(vector_w_missing, na.rm=TRUE)

vector_w_missing == NA

is.na(vector_w_missing)
mean(vector_w_missing[!is.na(vector_w_missing)])

vector_w_missing == 5

vector_w_missing %in% 5
vector_w_missing %in% NA

c(-2, -1, 0, 1, 2) / 0

is.finite(c(-2, -1, 0, 1, 2) / 0)
is.nan(c(-2, -1, 0, 1, 2) / 0)

head(letters) # letters is a built-in vector
head(letters, 10)
tail(letters)

a_vector <- 1:26
names(a_vector) <- LETTERS # capital version of letters #<<
head(a_vector)
a_vector[c("R", "S", "T", "U", "D", "I", "O")]

(a_matrix <- matrix(letters[1:6], nrow=2, ncol=3))
(b_matrix <- matrix(letters[1:6], nrow=2, ncol=3, byrow=TRUE))

(c_matrix <- cbind(c(1, 2), c(3, 4), c(5, 6)))
(d_matrix <- rbind(c(1, 2, 3), c(4, 5, 6)))

a_matrix[1, 2] # row 1, column 2
a_matrix[1, c(2, 3)] # row 1, columns 2 and 3

dim(a_matrix)

a_matrix[, 1] # all rows, column 1, becomes a vector
a_matrix[, 1, drop=FALSE] # all rows, column 1, stays a matrix

(bad_matrix <- cbind(1:2, LETTERS[c(6,1)]))
typeof(bad_matrix)

rownames(bad_matrix) <- c("Wedge", "Biggs")
colnames(bad_matrix) <- c("Pilot grade", "Mustache grade")
bad_matrix
bad_matrix["Biggs", , drop=FALSE]

cbind(c_matrix, d_matrix) # look at side by side
3 * c_matrix / d_matrix

(e_matrix <- t(c_matrix))

(f_matrix <- d_matrix %*% e_matrix)

(g_matrix <- solve(f_matrix))
f_matrix %*% g_matrix

diag(2)
diag(g_matrix)

(my_list <- list("first_thing"  = 1:5,
                 "second_thing" = matrix(8:11, nrow = 2),
                 "third_thing"  = lm(dist ~ speed, data = cars)))

my_list[["first_thing"]]
my_list$first_thing
my_list[[1]]

str(my_list[1])
str(my_list[[1]])

length(my_list[c(1, 2)])
str(my_list[c(1, 2)])

str(my_list[[3]], list.len=7) # Displaying on first 7 elements

names(my_list[[3]])

str(cars)
length(cars)
length(cars$dist) # should be same as nrow(cars)

cars[1, ]
cars[1:5, "speed", drop = FALSE]

## mean(swiss[swiss$Education > mean(swiss$Education), "Education"])

## library(dplyr)
## swiss %>%
##     filter(Education > mean(Education)) %>%
##     summarize(mean = mean(Education))

swiss %>% select(2:3) %>% head()

swiss %>% select(2:3) %>% 
  as_tibble(rownames="Name") %>% head()

my_list[[3]][["coefficients"]]
(speed_beta <- my_list[[3]][["coefficients"]]["speed"])

summary(my_list[[3]]) # this prints output

summary(my_list[[3]])[["coefficients"]] # a matrix
(speed_SE <- summary(my_list[[3]])[["coefficients"]]["speed", "Std. Error"])

speed_CI <- speed_beta + c(-qnorm(0.975), qnorm(0.975)) * speed_SE #<<
names(speed_CI) <- c("lower", "upper")

## A 1 mph increase in speed is associated with a `r
## round(speed_beta, 1)` ft increase in stopping distance
## (95% CI: (`r round(speed_CI["lower"],1)`,
##           `r round(speed_CI["upper"],1)`)).
