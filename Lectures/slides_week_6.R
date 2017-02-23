## ----goofus--------------------------------------------------
mean1 <- mean(swiss$Fertility)
mean2 <- mean(swiss$Agriculture)
mean3 <- mean(swissExamination)
mean4 <- mean(swiss$Fertility)
mean5 <- mean(swiss$Catholic)
mean5 <- mean(swiss$Infant.Mortality)
c(mean1, mean2 mean3, mean4, mean5, man6)


## ---gallant----------------------------------------------------------------
swiss_means <- setNames(numeric(ncol(swiss)), colnames(swiss))
for(i in seq_along(swiss)) {
    swiss_means[i] <- mean(swiss[[i]])
}
swiss_means

## ------------------------------------------------------------------------
for(i in 1:10) {
    # inside for, output won't show up w/o "print"
    print(i^2) 
}

## ------------------------------------------------------------------------
for(i in 1:3) {
    print(i^2) 
}

## ------------------------------------------------------------------------
i <- 1
print(i^2) 
i <- 2
print(i^2)
i <- 3
print(i^2)

## ------------------------------------------------------------------------
some_letters <- letters[4:6]
for(i in some_letters) {
    print(i)
}
i # in R, this will exist outside of the loop!

## ------------------------------------------------------------------------
for(a in seq_along(some_letters)) {
    print(paste0("Letter ", a, ": ", some_letters[a]))
}
a

## ------------------------------------------------------------------------
# preallocate numeric vector
iters <- 10
output <- numeric(iters)

for(i in 1:iters) {
    output[i] <- (i-1)^2 + (i-2)^2
}
output

## ------------------------------------------------------------------------
(names_to_use <- paste0("iter ", letters[1:5]))
# without setNames:
a_vector <- numeric(5)
names(a_vector) <- names_to_use

# with setNames: first arg = values, second = names
(a_vector <- setNames(numeric(5), names_to_use))

## ---- cache=TRUE---------------------------------------------------------
set.seed(98195)
# simulating example data:
n <- 300
x <- rnorm(n, mean = 5, sd = 4)
fake_data <- data.frame(x = x,
                        y = -0.5 * x + 0.05 * x^2 + rnorm(n, sd = 1))

## ---- fig.width = 10, fig.height = 3, dpi=300, out.width="1100px", out.height="330px"----
library(ggplot2)
ggplot(data = fake_data, aes(x = x, y = y)) +
    geom_point() +
    ggtitle("Our fake data")

## ------------------------------------------------------------------------
models <- c("intercept only" = "y ~ 1",
            "linear" = "y ~ x",
            "quadratic" = "y ~ x + I(x^2)",
            "cubic" = "y ~ x + I(x^2) + I(x^3)")

## ------------------------------------------------------------------------
fitted_lms <- vector("list", length(models)) # initialize list
names(fitted_lms) <- names(models) # give entries good names

## ------------------------------------------------------------------------
for(mod in names(models)) {
    fitted_lms[[mod]] <- lm(formula(models[mod]),
                            data = fake_data)
}

## ------------------------------------------------------------------------
# initialize data frame to hold predictions
predicted_data <- fake_data
for(mod in names(models)) {
    # make a new column in predicted data for each model's predictions
    predicted_data[[mod]] <- predict(fitted_lms[[mod]],
                                newdata = predicted_data)
}

## ---- warning=FALSE, message=FALSE---------------------------------------
library(tidyr)
library(dplyr)
tidy_predicted_data <- predicted_data %>%
    gather(Model, Prediction, -x, -y) %>%
    mutate(Model = factor(Model, levels = names(models)))

## ---- echo=FALSE, fig.width = 10, fig.height = 4.5, dpi=300, out.width="1100px", out.height="500px"----
ggplot(data = fake_data, aes(x = x, y = y)) +
    geom_point() +
    geom_line(data = tidy_predicted_data,
              aes(x = x,
                  y = Prediction,
                  group = Model,
                  color = Model),
              alpha = 0.5, size = 2) +
    ggtitle("Predicted trends from regression") +
    theme_bw()

## ------------------------------------------------------------------------
K <- 10
CV_predictions <- fake_data
CV_predictions$fold <- sample(rep(1:K, length.out = nrow(CV_predictions)),
                              replace = FALSE)
CV_predictions[, names(models)] <- NA
head(CV_predictions, 2)

## ------------------------------------------------------------------------
for(mod in names(models)) {
    for(k in 1:K) {
        # TRUE/FALSE vector of rows in the fold
        fold_rows <- (CV_predictions$fold == k)
        # fit model to data not in fold
        temp_mod <- lm(formula(models[mod]),
                       data = CV_predictions[!fold_rows, ])
        # predict on data in fold
        CV_predictions[fold_rows, mod] <- predict(temp_mod,
                                                  newdata = CV_predictions[fold_rows, ])
    }
}

## ------------------------------------------------------------------------
CV_MSE <- setNames(numeric(length(models)),
                   names(models))
for(mod in names(models)) {
    pred_sq_error <- (CV_predictions$y - CV_predictions[[mod]])^2
    CV_MSE[mod] <- mean(pred_sq_error)
}
CV_MSE

## -------------------------------------------------------------
for(i in 1:10) {
    if(i %% 2 == 0) {
        print(paste0("The number ", i, " is even"))
    } else if(i %% 3 == 0) {
        print(paste0("The number ", i, " is not even but divisible by 3"))
    } else {
        print(paste0("The number ", i, " is not divisible by 2 or 3"))
    }
}

## ------------------------------------------------------------------------
num_heads <- 0; num_flips <- 0
while(num_heads < 4) {
    coin_flip <- rbinom(n = 1, size = 1, prob = 0.5)
    if(coin_flip == 1) {
        num_heads <- num_heads + 1
    }
    num_flips <- num_flips + 1
}
num_flips # follows negative binomial distribution

## ------------------------------------------------------------------------
my_vector <- rnorm(100000)

## ------------------------------------------------------------------------
for_start <- proc.time() # start the clock
new_vector <- rep(NA, length(my_vector))
for(position in 1:length(my_vector)) {
    new_vector[position] <- my_vector[position] + 1
}
(for_time <- proc.time() - for_start) # time elapsed

## ------------------------------------------------------------------------
vec_start <- proc.time()
new_vector <- my_vector + 1
(vec_time <- proc.time() - vec_start)
for_time / vec_time

## ------------------------------------------------------------------------
(a_matrix <- matrix(1:12, nrow = 3, ncol = 4))
rowSums(a_matrix)

## ------------------------------------------------------------------------
cumsum(1:7)

## ------------------------------------------------------------------------
pmax(c(0, 2, 4), c(1, 1, 1), c(2, 2, 2))

