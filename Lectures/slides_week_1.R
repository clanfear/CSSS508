## ------------------------------------------------------------------------
123 + 456 + 789

## ------------------------------------------------------------------------
sqrt(400)

## ------------------------------------------------------------------------
?sqrt

## ------------------------------------------------------------------------
summary(cars)

## ---- echo=FALSE---------------------------------------------------------
library(knitr)

## ------------------------------------------------------------------------
x <- sqrt(77) # <- is how we assign variables

## ------------------------------------------------------------------------
head(cars) # prints first 6 rows, see tail() too

## ------------------------------------------------------------------------
str(cars) # str[ucture]
summary(cars)

## ------------------------------------------------------------------------
hist(cars$speed)

## ------------------------------------------------------------------------
hist(cars$dist)


## -------------------------------------------------------------
hist(cars$dist,
     xlab = "Distance (ft)",
     main = "Observed stopping distances of cars")

## ------------------------------------------------------------------------
( dist_mean <- mean(cars$dist) )
( speed_mean <- mean(cars$speed) )

## -------------------------------------------------------------
plot(dist ~ speed, data = cars,
     xlab = "Speed (mph)",
     ylab = "Stopping distance (ft)",
     main = "Speeds and stopping distances of cars",
     pch = 16)
abline(h = dist_mean, col = "firebrick")
abline(v = speed_mean, col = "cornflowerblue")

## ---- fig.width=16-------------------------------------------------------
pairs(swiss, pch = 8, col = "violet", main = "Pairwise comparisons of Swiss variables")

## ------------------------------------------------------------------------
( f_ae_reg <- lm(Fertility ~ Agriculture + Education, data = swiss) )

## ------------------------------------------------------------------------
library(pander) # loads pander, do once in your session
pander(summary(swiss), style = "rmarkdown", split.tables = 120)

## ------------------------------------------------------------------------
pander(head(swiss, 5), style = "rmarkdown", split.tables = 120)

