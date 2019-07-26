# Sometimes important stuff is highlighted! #<<
7 * 49

## > (11-2
## +

123 + 456 + 789

sqrt(400)

## ?sqrt

new.object <- 144

new.object

new.object + 10
new.object + new.object
sqrt(new.object)

new.object <- c(4, 9, 16, 25, 36)
new.object

sqrt(new.object)

summary(cars)

library(knitr)

x <- sqrt(77) # <- is how we assign variables

head(cars, 5) # prints first 5 rows, see tail() too

str(cars) # str[ucture]

summary(cars)

hist(cars$speed) # Histogram

hist(cars$dist)

hist(cars$dist,
     xlab = "Distance (ft)", # X axis label
     main = "Observed stopping distances of cars") # Title

( dist_mean  <- mean(cars$dist) )
( speed_mean <- mean(cars$speed) )

plot(dist ~ speed, data = cars, #<<
     xlab = "Speed (mph)",
     ylab = "Stopping distance (ft)",
     main = "Speeds and stopping distances of cars",
     pch = 16) # Point size
abline(h = dist_mean, col = "firebrick")
abline(v = speed_mean, col = "cornflowerblue")

pairs(swiss, pch = 8, col = "violet", #<<
      main = "Pairwise comparisons of Swiss variables")

## library(pander) # loads pander, do once in your session
## pander(summary(swiss), style = "rmarkdown", split.tables = 120) #<<

library(pander) # loads pander, do once in your session
pander(summary(swiss), style = "rmarkdown", split.tables = 120)

## pander(head(swiss, 5), style = "rmarkdown", split.tables = 120)

pander(head(swiss, 5), style = "rmarkdown", split.tables = 120)
