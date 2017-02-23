## ------------------------------------------------------------------------
library(gapminder)

## ------------------------------------------------------------------------
str(gapminder)

## ---- message=TRUE-------------------------------------------------------
library(dplyr)

## ------------------------------------------------------------------------
gapminder %>% filter(country == "Oman")

## ------------------------------------------------------------------------
gapminder %>%
    filter( (country == "Oman") &
                (year > 1980) & (year <= 2000) )

## ------------------------------------------------------------------------
China <- gapminder %>%
    filter(country == "China")
head(China, 4)

## ---- fig.width=20-------------------------------------------------------
plot(lifeExp ~ year, data = China,
     xlab = "Year", ylab = "Life expectancy",
     main = "Life expectancy in China",
     col = "red", cex = 3, pch = 16)

## ------------------------------------------------------------------------
library(ggplot2)

## ---- fig.width = 10, fig.height = 4.1, dpi=300, out.width="1100px", out.height="450px"----
ggplot(data = China, aes(x = year, y = lifeExp)) +
    geom_point()

## ---- fig.width = 10, fig.height = 3.6, dpi=300, out.width="1100px", out.height="400px"----
ggplot(data = China, aes(x = year, y = lifeExp)) +
    geom_point(color = "red", size = 5) +
    xlab("Year") + ylab("Life expectancy") +
    ggtitle("Life expectancy in China") +
    theme_bw()

## ---- fig.width = 10, fig.height = 3.6, dpi=300, out.width="1100px", out.height="400px"----
ggplot(data = gapminder, aes(x = year, y = lifeExp, color = continent)) +
    geom_point() +
    xlab("Year") + ylab("Life expectancy") +
    ggtitle("Life expectancy over time") +
    theme_bw()

## ---- fig.width = 10, fig.height = 3.2, dpi=300, out.width="1100px", out.height="350px"----
ggplot(data = gapminder, aes(x = year, y = lifeExp,
                             group = country, color = continent)) +
    geom_line(alpha = 0.5) +
    facet_wrap( ~ continent) +
    xlab("Year") +
    ylab("Life expectancy") +
    ggtitle("Life expectancy over time") +
    theme_bw()

## ------------------------------------------------------------------------
lifeExp_by_year <- ggplot(data = gapminder,
       aes(x = year, y = lifeExp, color = continent)) +
    geom_point() +
    xlab("Year") +
    ylab("Life expectancy") +
    ggtitle("Life expectancy over time") +
    theme_bw()

## ---- fig.width = 10, fig.height = 4.5, dpi=300, out.width="1100px", out.height="500px"----
lifeExp_by_year

## ---- fig.width = 10, fig.height = 5, dpi=300, out.width="1100px", out.height="550px"----
lifeExp_by_year +
    geom_line(aes(group = country))

## ---- fig.width = 10, fig.height = 4.5, dpi=300, out.width="1100px", out.height="500px"----
ggplot(data = gapminder, aes(x = continent, y = year, color = continent)) +
    geom_point()

## ---- fig.width = 10, fig.height = 4.1, dpi=300, out.width="1100px", out.height="450px"----
ggplot(data = gapminder, aes(x = continent, y = year, color = continent)) +
    geom_point(position = position_jitter(width = 0.5, height = 2))

## ---- fig.width = 10, fig.height = 3.2, dpi=300, out.width="1100px", out.height="350px"----
ggplot(data = China, aes(x = year, y = gdpPercap)) +
    geom_line() +
    scale_y_log10(breaks = c(1000, 2000, 3000, 4000, 5000)) +
    xlim(1940, 2010) +
    ggtitle("Chinese GDP per capita")

## ---- fig.width = 10, fig.height = 4.1, dpi=300, out.width="1100px", out.height="450px"----
ggplot(data = China, aes(x = year, y = lifeExp)) +
    geom_line() +
    ggtitle("Chinese life expectancy") +
    theme_gray(base_size = 30)

## ---- fig.width = 10, fig.height = 4.1, dpi=300, out.width="1100px", out.height="450px"----
lifeExp_by_year +
    scale_color_manual(name = "Which\ncontinent\nare we\nlooking at?",
                       values = c("Africa" = "seagreen",
                                  "Americas" = "turquoise1",
                                  "Asia" = "royalblue",
                                  "Europe" = "violetred1",
                                  "Oceania" = "yellow"))

## ---- fig.width = 10, fig.height = 4.5, dpi=300, out.width="1100px", out.height="500px"----
ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
    geom_line(alpha = 0.5, aes(color = "Country", size = "Country")) +
    geom_line(stat = "smooth", method = "loess",
              aes(group = continent, color = "Continent", size = "Continent"),
              alpha = 0.5) +
    facet_wrap(~ continent, nrow = 2) +
    scale_color_manual(name = "Unit",
                       values = c("Country" = "black",
                                  "Continent" = "dodgerblue1")) +
    scale_size_manual(name = "Unit",
                      values = c("Country" = 1,
                                 "Continent" = 3)) +
    theme_minimal(base_size = 16) + 
    theme(legend.position=c(0.75, 0.2))

## ------------------------------------------------------------------------
ggsave("I_saved_a_file.pdf", plot = lifeExp_by_year,
       height = 3, width = 5, units = "in")

## stuff below should only be run on personal computers
## with ImageMagick pre-installed
## ------------------------------------------------------------------------
# install.packages("devtools")
# devtools::install_github("dgrtwo/gganimate")
# library(gganimate)

## ---- eval=FALSE---------------------------------------------------------
## gdp_vs_life <- ggplot(gapminder,
##                       aes(x = gdpPercap,
##                           y = lifeExp,
##                           size = pop,
##                           color = continent,
##                           frame = year)) +
##     geom_point() +
##     scale_x_log10() +
##     theme_bw()
## gg_animate(gdp_vs_life, "Lectures/animated.gif",
##            ani.height = 600, ani.width = 900)