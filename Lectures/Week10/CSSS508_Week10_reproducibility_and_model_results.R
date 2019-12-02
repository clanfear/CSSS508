library(tidyverse)
library(pander)
library(knitr)
`%!in%` <- Negate(`%in%`)
hook_output = knit_hooks$get('output')
knit_hooks$set(output = function(x, options) {
  if (!is.null(n <- options$out.lines)) {
    x = unlist(stringr::str_split(x, '\n'))
    if (length(x) > n) {
      # truncate the output
      x = c(head(x, n), '....\n')
    }
    x = paste(x, collapse = '\n') # paste first n lines together
  }
  hook_output(x, options)
})
opts_chunk$set(out.lines = 20)

ex_dat <- data.frame(num1 = rnorm(200, 1, 2), 
                     fac1 = sample(c(1, 2, 3), 200, TRUE),
                     num2 = rnorm(200, 0, 3),
                     fac2 = sample(c(1, 2))) %>%
  mutate(yn = num1*0.5 + fac1*1.1 + num2*0.7 + fac2-1.5  + rnorm(200, 0, 2)) %>% 
  mutate(yb = as.numeric(yn > mean(yn))) %>%
  mutate(fac1 = factor(fac1, labels=c("A", "B", "C")),
         fac2 = factor(fac2, labels=c("Yes", "No")))

library(broom)

lm_1 <- lm(yn ~ num1 + fac1, data = ex_dat)
summary(lm_1)

glm_1 <- glm(yb ~ num1 + fac1, data = ex_dat, family=binomial(link="logit"))
summary(glm_1)

lm_1 %>% tidy()

glm_1 %>% tidy()

glance(lm_1)

augment(lm_1) %>% head()

ex_dat %>% group_by(fac1) %>% do(tidy(lm(yn ~  num1 + fac2 + num2, data = .))) #<<

library(gapminder)

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, color = continent)) +
  geom_point(position = position_jitter(1,0), size = 0.5) +
  geom_smooth()

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, color = continent)) +
  geom_point(position = position_jitter(1,0), size = 0.5) +
  geom_smooth(method = "glm", formula = y ~ x) #<<

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, color = continent)) +
  geom_point(position = position_jitter(1,0), size = 0.5) +
  geom_smooth(method = "glm", formula = y ~ poly(x, 2)) #<<

library(ggeffects)

ex_dat <- data.frame(num1 = rnorm(200, 1, 2), 
                     fac1 = sample(c(1, 2, 3), 200, TRUE),
                     num2 = rnorm(200, 0, 3),
                     fac2 = sample(c(1, 2))) %>%
  mutate(yn = num1 * 0.5 + fac1 * 1.1 + num2 * 0.7 +
              fac2 - 1.5  + rnorm(200, 0, 2)) %>% 
  mutate(yb = as.numeric(yn > mean(yn))) %>%
  mutate(fac1 = factor(fac1, labels = c("A", "B", "C")),
         fac2 = factor(fac2, labels = c("Yes", "No")))

lm_1 <- lm(yn ~ num1 + fac1, data = ex_dat)
lm_1_est <- ggpredict(lm_1, terms = "num1")

lm_1_est

plot(lm_1_est)

glm(yb ~ num1 + fac1 + num2 + fac2, data = ex_dat, family=binomial(link = "logit")) %>%
  ggpredict(terms = c("num1", "fac1")) %>% plot()

glm(yb ~ num1 + fac1 + num2 + fac2, data = ex_dat, family = binomial(link = "logit")) %>%
  ggpredict(terms = c("num1", "fac1")) %>% plot(facet=TRUE)

glm(yb ~ num1 + fac1 + num2 + fac2, data=ex_dat, family=binomial(link="logit")) %>%
  ggpredict(terms = c("num1 [-1,0,1]", "fac1 [A,B]")) %>% plot(facet=TRUE)

glm(yb ~ num1 + fac1 + num2 + fac2, data = ex_dat, family = binomial(link = "logit")) %>%
  ggpredict(terms = c("num1 [meansd]", "num2 [minmax]")) %>% plot(facet=TRUE)

lm(yn ~ fac1 + fac2, data = ex_dat) %>% 
  ggpredict(terms=c("fac1", "fac2")) %>% plot()

library(pander)

panderOptions("table.style", "rmarkdown")

## pander(lm_1)

## pander(summary(lm_1))

library(sjPlot)

## model_1 <- lm(mpg ~ wt, data = mtcars)
## tab_model(model_1)

# If you're seeing this, you are looking in my presentation files.
# I actually have to call on a saved image here because sjPlot
# doesn't display properly in .Rpres slides for some reason.
knitr::include_graphics("img/sjPlot_table.PNG")

## model_2 <- lm(mpg ~ hp + wt, data = mtcars)
## model_3 <- lm(mpg ~ hp + wt + factor(am), data = mtcars)
## tab_model(model_1, model_2, model_3)

# If you're seeing this, you are looking in my presentation files.
# I actually have to call on a saved image here because sjPlot
# doesn't display properly in .Rpres slides for some reason.
knitr::include_graphics("img/sjPlot_mtable.PNG")

knitr::include_graphics("img/sjPlot_likert.PNG")

knitr::include_graphics("img/sjPlot_crosstab.PNG")

## library(corrplot)
## corrplot(
##   cor(mtcars),
##   addCoef.col = "white",
##   addCoefasPercent=T,
##   type="upper",
##   order="AOE")

library(corrplot)
corrplot(cor(mtcars), addCoef.col = "white", addCoefasPercent=T, type="upper", order="FPC")
