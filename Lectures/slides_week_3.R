## ----set-options, echo=FALSE, cache=FALSE--------------------------------
options(width = 90)

## ------------------------------------------------------------------------
library(dplyr)
library(gapminder)

Canada <- gapminder %>%
    filter(country == "Canada")

## ------------------------------------------------------------------------
former_yugoslavia <- c("Bosnia and Herzegovina",
                       "Croatia",
                       "Macedonia",
                       "Montenegro",
                       "Serbia",
                       "Slovenia")
yugoslavia <- gapminder %>%
    filter(country %in% former_yugoslavia)
tail(yugoslavia, 2)

## ------------------------------------------------------------------------
gapminder %>%
    distinct(continent, year)

## ------------------------------------------------------------------------
gapminder %>%
    filter(country == "Canada") %>% head(2)


## ------------------------------------------------------------------------
set.seed(0413) # makes random numbers repeatable
yugoslavia %>%
    sample_n(size = 6, replace = FALSE)

## ------------------------------------------------------------------------
yugoslavia %>%
    arrange(year, desc(pop))

## ------------------------------------------------------------------------
yugoslavia %>%
    select(country, year, pop) %>%
    head(4)

## ------------------------------------------------------------------------
yugoslavia %>%
    select(-continent, -pop, -lifeExp) %>%
    head(4)

## ------------------------------------------------------------------------
yugoslavia %>%
    select(Life_Expectancy = lifeExp) %>%
    head(4)

## ------------------------------------------------------------------------
yugoslavia %>%
    select(country, year, lifeExp) %>%
    rename(Life_Expectancy = lifeExp) %>%
    head(4)

## ------------------------------------------------------------------------
library(pander)
yugoslavia %>%
    filter(country == "Serbia") %>%
    select(year, lifeExp) %>%
    rename(Year = year, `Life Expectancy` = lifeExp) %>%
    head(5) %>%
    pander(style = "rmarkdown", caption = "Serbian life expectancy")

## ------------------------------------------------------------------------
yugoslavia %>%
    filter(country == "Serbia") %>%
    select(year, pop, lifeExp) %>%
    mutate(pop_million = pop / 1000000,
           life_exp_past_40 = lifeExp - 40) %>%
    head(5)

## ------------------------------------------------------------------------
yugoslavia %>%
    mutate(short_country = ifelse(country == "Bosnia and Herzegovina",
                                  "B and H",
                                  as.character(country))) %>%
    select(short_country, year, pop) %>%
    arrange(year, short_country) %>%
    head(3)

## ------------------------------------------------------------------------
yugoslavia %>%
    filter(year == 1982) %>%
    summarize(n_obs = n(),
              total_pop = sum(pop),
              mean_life_exp = mean(lifeExp),
              range_life_exp = max(lifeExp) - min(lifeExp))

## ------------------------------------------------------------------------
yugoslavia %>%
    filter(year == 1982) %>%
    summarize_each(funs(mean, sd),
                   lifeExp, pop)

## ------------------------------------------------------------------------
yugoslavia %>%
    group_by(year) %>%
    summarize(num_countries = n_distinct(country),
              total_pop = sum(pop),
              total_gdp_per_cap = sum(pop * gdpPercap) / total_pop) %>%
    head(5)

## ------------------------------------------------------------------------
yugoslavia %>%
    select(country, year, pop) %>%
    filter(year >= 2002) %>%
    group_by(country) %>%
    mutate(lag_pop = lag(pop, order_by = year),
           pop_chg = pop - lag_pop) %>%
    head(4)

## ------------------------------------------------------------------------
# install.packages("nycflights13")
library(nycflights13)

## ------------------------------------------------------------------------
flights %>%
    filter(dest == "SEA") %>%
    select(tailnum) %>%
    left_join(planes %>%
                  select(tailnum, manufacturer),
              by = "tailnum") %>%
    distinct(manufacturer)

## ------------------------------------------------------------------------
flights %>%
    filter(dest == "SEA") %>%
    select(carrier) %>%
    left_join(airlines, by = "carrier") %>%
    group_by(name) %>%
    tally() %>%
    arrange(desc(n))


## ---- warning=FALSE, message=FALSE, echo=FALSE, cache=TRUE, fig.width = 10, fig.height = 5.5, dpi=300, out.width="1100px", out.height="600px"----
library(ggplot2)
flights %>%
    select(origin, year, month, day, hour, dep_delay) %>%
    inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
    select(dep_delay, wind_gust) %>%
    # removing rows with missing values
    filter(!is.na(dep_delay) & !is.na(wind_gust)) %>% 
    ggplot(aes(x = wind_gust, y = dep_delay)) +
    geom_point() + geom_smooth()


## ---- warning=FALSE, message=FALSE, echo=FALSE, cache=TRUE, fig.width = 10, fig.height = 5.5, dpi=300, out.width="1100px", out.height="600px"----
flights %>%
    select(origin, year, month, day, hour, dep_delay) %>%
    inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
    select(dep_delay, wind_gust) %>%
    filter(!is.na(dep_delay) & !is.na(wind_gust) & wind_gust < 250) %>% 
    ggplot(aes(x = wind_gust, y = dep_delay)) +
    geom_smooth() + theme_bw(base_size = 16) +
    xlab("Wind gusts in departure hour (mph)") +
    ylab("Average departure delay (minutes)")

