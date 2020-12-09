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

ex_dat %>% 
  nest_by(fac1) %>% #<<
  mutate(model = list(lm(yn ~  num1 + fac2, data = data))) %>%  
  summarize(tidy(model), .groups = "drop")

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

library(gt)
tes_chars <- starwars %>% 
  unnest(films) %>% 
  unnest(starships, keep_empty=TRUE) %>% 
  filter(films == "The Empire Strikes Back") %>% 
  select(name, species, starships, mass, height) %>%
  distinct(name, .keep_all = TRUE) %>%
  mutate(starships = ifelse(name == "Obi-Wan Kenobi" | is.na(starships), 
                            "No Ship", starships))
glimpse(tes_chars)

## tes_chars %>%
##   gt()
## 

tes_chars %>%
  gt() %>% 
  gtsave("img/sw_table_1.png")

## tes_chars %>%
##   group_by(starships) %>%
##   gt()

tes_chars %>% 
  group_by(starships) %>%
  gt() %>% gtsave("img/sw_table_2.png")

## tes_chars %>%
##   group_by(starships) %>%
##   gt(rowname_col = "name")

tes_chars %>% 
  group_by(starships) %>%
  gt(rowname_col = "name") %>%
  gtsave("img/sw_table_3.png")

## tes_chars %>%
##   group_by(starships) %>%
##   gt(rowname_col = "name") %>%
##   tab_header(
##     title = "Star Wars Characters",
##     subtitle = "The Empire Strikes Back"
##   )

tes_chars %>% 
  group_by(starships) %>%
  gt(rowname_col = "name") %>%
  tab_header(
    title = "Star Wars Characters", 
    subtitle = "The Empire Strikes Back"
  ) %>% gtsave("img/sw_table_4.png")

## tes_chars %>%
##   group_by(starships) %>%
##   gt(rowname_col = "name") %>%
##   tab_header(
##     title = "Star Wars Characters",
##     subtitle = "The Empire Strikes Back"
##   ) %>%
##   tab_spanner(
##     label = "Vitals",
##     columns = vars(mass, height)
##   )

tes_chars %>% 
  group_by(starships) %>%
  gt(rowname_col = "name") %>%
  tab_header(
    title = "Star Wars Characters", 
    subtitle = "The Empire Strikes Back"
  ) %>%
  tab_spanner(
    label = "Vitals",
    columns = vars(mass, height)
  ) %>% gtsave("img/sw_table_5.png")

## tes_chars %>%
##   group_by(starships) %>%
##   gt(rowname_col = "name") %>%
##   tab_header(
##     title = "Star Wars Characters",
##     subtitle = "The Empire Strikes Back"
##   ) %>%
##   tab_spanner(
##     label = "Vitals",
##     columns = vars(mass, height)
##   ) %>%
##   cols_label(
##     mass = "Mass (kg)",
##     height = "Height (cm)",
##     species = "Species"
##   )

tes_chars %>% 
  group_by(starships) %>%
  gt(rowname_col = "name") %>%
  tab_header(
    title = "Star Wars Characters", 
    subtitle = "The Empire Strikes Back"
  ) %>%
  tab_spanner(
    label = "Vitals",
    columns = vars(mass, height)
  ) %>%
  cols_label(
    mass = "Mass (kg)",
    height = "Height (cm)",
    species = "Species"
  ) %>% gtsave("img/sw_table_6.png")

## tes_chars %>%
##   group_by(starships) %>%
##   gt(rowname_col = "name") %>%
##   tab_header(
##     title = "Star Wars Characters",
##     subtitle = "The Empire Strikes Back"
##   ) %>%
##   tab_spanner(
##     label = "Vitals",
##     columns = vars(mass, height)
##   ) %>%
##   cols_label(
##     mass = "Mass (kg)",
##     height = "Height (cm)",
##     species = "Species"
##   ) %>%
##   fmt_number(
##     columns = vars(mass),
##     decimals = 0)

tes_chars %>% 
  group_by(starships) %>%
  gt(rowname_col = "name") %>%
  tab_header(
    title = "Star Wars Characters", 
    subtitle = "The Empire Strikes Back"
  ) %>%
  tab_spanner(
    label = "Vitals",
    columns = vars(mass, height)
  ) %>%
  cols_label(
    mass = "Mass (kg)",
    height = "Height (cm)",
    species = "Species"
  ) %>%
  fmt_number(
    columns = vars(mass),
    decimals = 0
  ) %>% gtsave("img/sw_table_7.png")

## tes_chars %>%
##   group_by(starships) %>%
##   gt(rowname_col = "name") %>%
##   tab_header(
##     title = "Star Wars Characters",
##     subtitle = "The Empire Strikes Back"
##   ) %>%
##   tab_spanner(
##     label = "Vitals",
##     columns = vars(mass, height)
##   ) %>%
##   cols_label(
##     mass = "Mass (kg)",
##     height = "Height (cm)",
##     species = "Species"
##   ) %>%
##   fmt_number(
##     columns = vars(mass),
##     decimals = 0
##   ) %>%
##   cols_align(
##     align = "center",
##     columns = vars(species, mass, height)
##   )

tes_chars %>% 
  group_by(starships) %>%
  gt(rowname_col = "name") %>%
  tab_header(
    title = "Star Wars Characters", 
    subtitle = "The Empire Strikes Back"
  ) %>%
  tab_spanner(
    label = "Vitals",
    columns = vars(mass, height)
  ) %>%
  cols_label(
    mass = "Mass (kg)",
    height = "Height (cm)",
    species = "Species"
  ) %>%
  fmt_number(
    columns = vars(mass),
    decimals = 0
  ) %>%
  cols_align(
    align = "center",
    columns = vars(species, mass, height)
  ) %>% gtsave("img/sw_table_8.png")

## tes_chars %>%
##   group_by(starships) %>%
##   gt(rowname_col = "name") %>%
##   tab_header(
##     title = "Star Wars Characters",
##     subtitle = "The Empire Strikes Back"
##   ) %>%
##   tab_spanner(
##     label = "Vitals",
##     columns = vars(mass, height)
##   ) %>%
##   cols_label(
##     mass = "Mass (kg)",
##     height = "Height (cm)",
##     species = "Species"
##   ) %>%
##   fmt_number(
##     columns = vars(mass),
##     decimals = 0
##   ) %>%
##   cols_align(
##     align = "center",
##     columns = vars(species, mass, height)
##   ) %>%
##   row_group_order(
##     groups = c("X-wing",
##                "Millennium Falcon")
##   )

tes_chars %>% 
  group_by(starships) %>%
  gt(rowname_col = "name") %>%
  tab_header(
    title = "Star Wars Characters", 
    subtitle = "The Empire Strikes Back"
  ) %>%
  tab_spanner(
    label = "Vitals",
    columns = vars(mass, height)
  ) %>%
  cols_label(
    mass = "Mass (kg)",
    height = "Height (cm)",
    species = "Species"
  ) %>%
  fmt_number(
    columns = vars(mass),
    decimals = 0
  ) %>%
  cols_align(
    align = "center",
    columns = vars(species, mass, height)
  ) %>%
  row_group_order(
    groups = c("X-wing", 
               "Millennium Falcon")
  ) %>% gtsave("img/sw_table_9.png")

tes_chars %>%
  gt() %>% 
  gtsave("img/sw_table_1.png")

tes_chars %>% 
  group_by(starships) %>%
  gt(rowname_col = "name") %>%
  tab_header(
    title = "Star Wars Characters", 
    subtitle = "The Empire Strikes Back"
  ) %>%
  tab_spanner(
    label = "Vitals",
    columns = vars(mass, height)
  ) %>%
  cols_label(
    mass = "Mass (kg)",
    height = "Height (cm)",
    species = "Species"
  ) %>%
  fmt_number(
    columns = vars(mass),
    decimals = 0
  ) %>%
  cols_align(
    align = "center",
    columns = vars(species, mass, height)
  ) %>%
  row_group_order(
    groups = c("X-wing", 
               "Millennium Falcon")
  ) %>% gtsave("img/sw_table_9.png")

library(modelsummary)

## mod_1 <- lm(mpg ~ wt, data = mtcars)
## msummary(mod_1)

mod_1 <- lm(mpg ~ wt, data = mtcars)
msummary(mod_1)

## mod_1 <- lm(mpg ~ wt, data = mtcars)
## mod_2 <- lm(mpg ~ hp + wt, data = mtcars)
## mod_3 <- lm(mpg ~ hp + wt + factor(am),
##             data = mtcars)
## model_list <- list("Model 1" = mod_1,
##                    "Model 2" = mod_2,
##                    "Model 3" = mod_3)
## msummary(model_list)

mod_1 <- lm(mpg ~ wt, data = mtcars)
mod_2 <- lm(mpg ~ hp + wt, data = mtcars)
mod_3 <- lm(mpg ~ hp + wt + factor(am), 
            data = mtcars)
model_list <- list("Model 1" = mod_1, 
                   "Model 2" = mod_2, 
                   "Model 3" = mod_3)
msummary(model_list)

## msummary(model_list, output = "latex")

msummary(model_list, output = "ex_table.png")

## msummary(model_list, output = "gt") %>%
##   tab_header(
##     title = "Table 1. Linear Models",
##     subtitle = "DV: Miles per Gallon"
##   )

msummary(model_list, output = "gt") %>%
  tab_header(
    title = "Table 1. Linear Models", 
    subtitle = "DV: Miles per Gallon"
  ) %>%
  gtsave("img/gt_summary.png")

library(gtsummary)

## mtcars %>%
##   select(1:9) %>%
##   tbl_summary()

mtcars %>% 
  select(1:9) %>%
  tbl_summary()

## mtcars %>%
##   select(1:9) %>%
##   tbl_summary(by = "am")

mtcars %>% 
  select(1:9) %>%
  tbl_summary(by = "am")

## mtcars %>%
##   select(1:9) %>%
##   tbl_summary(by = "am") %>%
##   as_gt() %>%
##   tab_spanner(
##     label = "Transmission",
##     columns = starts_with("stat_")
##   ) %>%
##   tab_header(
##     title = "Motor Trend Cars",
##     subtitle = "Descriptive Statistics"
##   )

mtcars %>% 
  select(1:9) %>%
  tbl_summary(by = "am") %>%
  as_gt() %>%
  tab_spanner(label = "Transmission", 
              columns = starts_with("stat_")) %>%
  tab_header("Motor Trend Cars", 
             subtitle = "Descriptive Statistics") %>%
  gtsave("img/gtsummary.png")

## library(corrplot)
## corrplot(
##   cor(mtcars),
##   addCoef.col = "white",
##   addCoefasPercent=T,
##   type="upper",
##   order="AOE")

library(corrplot)
corrplot(cor(mtcars), addCoef.col = "white", addCoefasPercent=T, type="upper", order="FPC")

library(sjPlot)

model_1 <- lm(mpg ~ wt, data = mtcars)
tab_model(model_1)

model_2 <- lm(mpg ~ hp + wt, data = mtcars)
model_3 <- lm(mpg ~ hp + wt + factor(am), data = mtcars)
tab_model(model_1, model_2, model_3)

knitr::include_graphics("img/sjPlot_likert.PNG")

knitr::include_graphics("img/sjPlot_crosstab.PNG")
