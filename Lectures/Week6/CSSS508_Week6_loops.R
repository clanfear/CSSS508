## mean1 <- mean(swiss$Fertility)
## mean2 <- mean(swiss$Agriculture)
## mean3 <- mean(swissExamination)
## mean4 <- mean(swiss$Fertility)
## mean5 <- mean(swiss$Catholic)
## mean5 <- mean(swiss$Infant.Mortality)
## c(mean1, mean2 mean3, mean4, mean5, man6)

options(digits = 3)

swiss_means <- setNames(numeric(ncol(swiss)), colnames(swiss)) #<<
for(i in seq_along(swiss)) {
    swiss_means[i] <- mean(swiss[[i]])
}
swiss_means

for(i in 1:10) {
    # inside for, output won't show up without print()
    print(i^2) 
}

for(i in 1:3) {
    print(i^2) 
}

i <- 1
print(i^2) 
i <- 2
print(i^2)
i <- 3
print(i^2)

some_letters <- letters[4:6] # Vector of letters d,e,f
for(i in some_letters) {
    print(i)
}
i # in R, this will exist outside of the loop!

for(a in seq_along(some_letters)) {
    print(paste0("Letter ", a, ": ", some_letters[a]))
}
a # The object `a` contains the number of the last iteration

iters <- 10 # Set number of interations
output <- numeric(iters) # Pre-allocate numeric vector 

for(i in 1:iters) { # Run code below iters times
    output[i] <- (i-1)^2 + (i-2)^2
}
output # Display output

(names_to_use <- paste0("iter ", letters[1:5]))
# without setNames:
a_vector <- numeric(5)
names(a_vector) <- names_to_use

# with setNames: first arg = values, second = names
(a_vector <- setNames(numeric(5), names_to_use))

set.seed(98115) # Making sure values always the same
n <- 300
x <- rnorm(n, mean = 5, sd = 4)
sim_data <- 
  data.frame(x = x,
             y = -0.5 * x + 0.05 * x^2 + rnorm(n, sd = 1))

ggplot(data = sim_data, aes(x = x, y = y)) +
  geom_point() + 
  ggtitle("Simulated Data")

models <- c("intercept only" = "y ~ 1", # Name on left, formula on right
            "linear"         = "y ~ x",
            "quadratic"      = "y ~ x + I(x^2)",
            "cubic"          = "y ~ x + I(x^2) + I(x^3)")

fitted_lms        <- vector("list", length(models)) # initialize list
names(fitted_lms) <- names(models) # give entries good names
fitted_lms # display the pre-allocated (empty) list

for(mod in names(models)) {
    fitted_lms[[mod]] <- lm(formula(models[mod]), data = sim_data)
}

# initialize data frame to hold predictions
predicted_data <- sim_data
for(mod in names(models)) {
    # make a new column in predicted_data for each model's predictions
    predicted_data[[mod]] <- predict(fitted_lms[[mod]],
                                newdata = predicted_data)
}

head(predicted_data, 10)

library(tidyr)
tidy_predicted_data <- predicted_data %>%
    pivot_longer(3:6, names_to="Model", values_to="Prediction") %>% #<<
    mutate(Model = factor(Model, levels = names(models))) #<<
head(tidy_predicted_data) # Displaying some rows

## ggplot(data = sim_data, # Original data!
##        aes(x = x,
##            y = y)) +
##     geom_point() + # Original data as points
##     geom_line(data = tidy_predicted_data, # Predicted data! #<<
##               aes(x     = x,
##                   y     = Prediction,
##                   group = Model,
##                   color = Model),
##               alpha = 0.5,
##               size  = 2) +
##     ggtitle("Predicted trends from regression") +
##     theme_bw()

ggplot(data = sim_data, aes(x = x, y = y)) +
    geom_point() +
    geom_line(data = tidy_predicted_data,
          aes(x = x, y = Prediction, group = Model, color = Model),
              alpha = 0.5, size = 2) +
    ggtitle("Predicted trends from regression") +
    theme_bw()

K <- 10
CV_predictions      <- sim_data
CV_predictions$fold <- sample(rep(1:K, length.out = nrow(CV_predictions)),
                              replace = FALSE)
CV_predictions[ , names(models)] <- NA
head(CV_predictions)

for(mod in names(models)) {
    for(k in 1:K) {
        # TRUE/FALSE vector of rows in the fold
        fold_rows <- (CV_predictions$fold == k)
        # fit model to data not in fold
        temp_mod <- lm(formula(models[mod]),
                       data = CV_predictions[!fold_rows, ]) #<<
        # predict on data in fold
        CV_predictions[fold_rows, mod] <- 
           predict(temp_mod, newdata = CV_predictions[fold_rows, ]) #<<
    }
}

CV_MSE <- setNames(numeric(length(models)), names(models))
for(mod in names(models)) {
    pred_sq_error <- (CV_predictions$y - CV_predictions[[mod]])^2
    CV_MSE[mod]   <- mean(pred_sq_error)
}
CV_MSE

## for(i in 1:10) {
##   if(i %% 2 == 0) { # %% gets remainder after division
##     print(paste0("The number ", i, " is even."))
##   } else if(i %% 3 == 0) {
##     print(paste0("The number ", i, " is divisible by 3."))
##   } else {
##     print(paste0("The number ", i, " is not divisible by 2 or 3."))
##   }
## }

for(i in 1:10) {
  if(i %% 2 == 0) {
    print(paste0("The number ", i, " is even."))
  } else if(i %% 3 == 0) {
    print(paste0("The number ", i, " is divisible by 3."))
  } else {
    print(paste0("The number ", i, " is not divisible by 2 or 3."))
  }
}

(file_list  <- list.files("./example_data/"))

data_list  <- vector("list", length(file_list))


(data_names <- stringr::str_remove(file_list, ".csv"))

names(data_list) <- data_names

library(readr) # readr to load the csv files
for (i in seq_along(file_list)){
  data_list[[ data_names[i] ]] <- 
    read_csv(paste0("./example_data/", file_list[i]))
}
head(data_list[[1]], 3)

names(data_list[[1]])
names(data_list[[2]])

complete_data <- bind_rows(data_list)
glimpse(complete_data)

num_heads <- 0
num_flips <- 0
while(num_heads < 4) {
  coin_flip <- rbinom(n = 1, size = 1, prob = 0.5)
  if (coin_flip == 1) { num_heads <- num_heads + 1 }
    num_flips <- num_flips + 1
}
num_flips # follows negative binomial distribution

my_vector <- rnorm(100000000) # Length 100 million random vector

for_start <- proc.time() # start the clock
new_vector <- rep(NA, length(my_vector))
for(position in 1:length(my_vector)) {
    new_vector[position] <- my_vector[position] + 1
}
(for_time <- proc.time() - for_start) # time elapsed

vec_start  <- proc.time()
new_vector <- my_vector + 1
(vec_time  <- proc.time() - vec_start)
for_time / vec_time

(a_matrix <- matrix(1:12, nrow = 3, ncol = 4))
rowSums(a_matrix)

cumsum(1:7)

pmax(c(0, 2, 4), c(1, 1, 1), c(2, 2, 2))
