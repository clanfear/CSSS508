new.object <- 1:10 # Making vector of 1 to 10 

save(new.object, file="new_object.RData")

load("new_object.RData")

getwd()

## setwd("C:/Users/cclan/Documents")

library(gapminder)

str(gapminder)

library(dplyr)

log(mean(gapminder$pop))

gapminder$pop %>% mean() %>% log()

gapminder %>% filter(country == "Oman")

gapminder %>%
    filter(country == "Oman" & year > 1980)

## gapminder %>%
##   filter(country == "Oman" &
##          year > 1980)

## gapminder %>%
##   filter(country == "Oman" |
##          year > 1980)

China <- gapminder %>% filter(country == "China")
head(China, 4)

## plot(lifeExp ~ year,
##      data = China,
##      xlab = "Year",
##      ylab = "Life expectancy",
##      main = "Life expectancy in China",
##      col = "red",
##      cex.lab = 1.5,
##      cex.main= 1.5,
##      pch = 16)

plot(lifeExp ~ year, data = China, xlab = "Year", ylab = "Life expectancy",
     main = "Life expectancy in China", col = "red", cex = 1, pch = 16)

library(ggplot2)

## ggplot(data = China,
##        aes(x = year, y = lifeExp)) +
##     geom_point()

ggplot(data = China, aes(x = year, y = lifeExp)) +
    geom_point()

## ggplot(data = China,  #<<
##        aes(x = year, y = lifeExp)) #<<

ggplot(data = China,  
       aes(x = year, y = lifeExp)) 

## ggplot(data = China,
##        aes(x = year, y = lifeExp)) +
##   geom_point() #<<

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point() 

## ggplot(data = China,
##        aes(x = year, y = lifeExp)) +
##   geom_point(color = "red", size = 3) #<<

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) 

## ggplot(data = China,
##        aes(x = year, y = lifeExp)) +
##   geom_point(color = "red", size = 3) +
##   xlab("Year") #<<

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  xlab("Year") 

## ggplot(data = China,
##        aes(x = year, y = lifeExp)) +
##   geom_point(color = "red", size = 3) +
##   xlab("Year") +
##   ylab("Life expectancy") #<<

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  xlab("Year") + 
  ylab("Life expectancy")

## ggplot(data = China,
##        aes(x = year, y = lifeExp)) +
##   geom_point(color = "red", size = 3) +
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy in China") #<<

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy in China")

## ggplot(data = China,
##        aes(x = year, y = lifeExp)) +
##   geom_point(color = "red", size = 3) +
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy in China") +
##   theme_bw() #<<

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy in China") +
  theme_bw() #<<

## ggplot(data = China,
##        aes(x = year, y = lifeExp)) +
##   geom_point(color = "red", size = 3) +
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy in China") +
##   theme_bw(base_size=18) #<<

ggplot(data = China, 
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy in China") +
  theme_bw(base_size=18) #<<

## ggplot(data = gapminder,#<<
##        aes(x = year, y = lifeExp)) +
##   geom_point(color = "red", size = 3) +
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy over time") +
##   theme_bw(base_size=18)

ggplot(data = gapminder, #<<
       aes(x = year, y = lifeExp)) +
  geom_point(color = "red", size = 3) +
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy over time") +
  theme_bw(base_size=18)

## ggplot(data = gapminder,
##        aes(x = year, y = lifeExp)) +
##   geom_line(color = "red", size = 3) + #<<
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy over time") +
##   theme_bw(base_size=18)

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp)) +
  geom_line(color = "red", size = 3) + #<<
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy over time") +
  theme_bw(base_size=18)

## ggplot(data = gapminder,
##        aes(x = year, y = lifeExp,
##            group = country)) + #<<
##   geom_line(color = "red", size = 3) +
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy over time") +
##   theme_bw(base_size=18)

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country)) + #<<
  geom_line(color = "red", size = 3) +
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy over time") +
  theme_bw(base_size=18)

## ggplot(data = gapminder,
##        aes(x = year, y = lifeExp,
##            group = country)) +
##   geom_line(color = "red") + #<<
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy over time") +
##   theme_bw(base_size=18)

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country)) +
  geom_line(color = "red") + #<<
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy over time") +
  theme_bw(base_size=18)

## ggplot(data = gapminder,
##        aes(x = year, y = lifeExp,
##            group = country,
##            color = continent)) + #<<
##   geom_line() + #<<
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy over time") +
##   theme_bw(base_size=18)

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country, 
           color = continent)) + #<<
  geom_line() + #<<
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy over time") +
  theme_bw(base_size=18) #<<

## ggplot(data = gapminder,
##        aes(x = year, y = lifeExp,
##            group = country,
##            color = continent)) +
##   geom_line() +
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy over time") +
##   theme_bw(base_size=18) +
##   facet_wrap(~ continent) #<<

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() +
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy over time") +
  theme_bw(base_size=18) +
  facet_wrap(~ continent) #<<

## ggplot(data = gapminder,
##        aes(x = year, y = lifeExp,
##            group = country,
##            color = continent)) +
##   geom_line() +
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy over time") +
##   theme_bw() +  #<<
##   facet_wrap(~ continent)

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() +
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy over time") +
  theme_bw() + #<<
  facet_wrap(~ continent)

## ggplot(data = gapminder,
##        aes(x = year, y = lifeExp,
##            group = country,
##            color = continent)) +
##   geom_line() +
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy over time") +
##   theme_bw() +
##   facet_wrap(~ continent) +
##   theme(legend.position = c(0.8, 0.25)) #<<

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() +
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy over time") +
  theme_bw() + 
  facet_wrap(~ continent) +
  theme(legend.position = c(0.8, 0.25)) #<<

## ggplot(data = gapminder,
##        aes(x = year, y = lifeExp,
##            group = country,
##            color = continent)) +
##   geom_line() +
##   xlab("Year") +
##   ylab("Life expectancy") +
##   ggtitle("Life expectancy over time") +
##   theme_bw() +
##   facet_wrap(~ continent) +
##   theme(legend.position = "none") #<<

ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() +
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy over time") +
  theme_bw() + 
  facet_wrap(~ continent) +
  theme(legend.position = "none") #<<

lifeExp_by_year <- 
  ggplot(data = gapminder, 
       aes(x = year, y = lifeExp, 
           group = country, 
           color = continent)) +
  geom_line() +
  xlab("Year") + 
  ylab("Life expectancy") +
  ggtitle("Life expectancy over time") +
  theme_bw() + 
  facet_wrap(~ continent) +
  theme(legend.position = "none")

lifeExp_by_year

lifeExp_by_year +
    theme(legend.position = "bottom")

ggplot(data = gapminder, aes(x = continent, y = year, color = continent)) +
    geom_point()

ggplot(data = gapminder, aes(x = continent, y = year, color = continent)) +
    geom_point(position = position_jitter(width = 0.5, height = 2)) #<<

ggplot(data = China, aes(x = year, y = gdpPercap)) +
    geom_line() +
    scale_y_log10(breaks = c(1000, 2000, 3000, 4000, 5000), #<<
                  labels = scales::dollar) + #<<
    xlim(1940, 2010) + ggtitle("Chinese GDP per capita")

ggplot(data = China, aes(x = year, y = lifeExp)) +
    geom_line() +
    ggtitle("Chinese life expectancy") +
    theme_gray(base_size = 20) #<<

lifeExp_by_year +
  theme(legend.position = c(0.8, 0.2)) +
  scale_color_manual(
    name = "Which continent are\nwe looking at?", # \n adds a line break #<<
    values = c("Africa" = "seagreen", "Americas" = "turquoise1", 
               "Asia" = "royalblue", "Europe" = "violetred1", "Oceania" = "yellow"))

## ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
##     geom_line(alpha = 0.5, aes(color = "Country", size = "Country")) +
##     geom_line(stat = "smooth", method = "loess", #<<
##           aes(group = continent, color = "Continent", size = "Continent"), alpha = 0.5) +
##     facet_wrap(~ continent, nrow = 2) + #<<
##     scale_color_manual(name = "Life Exp. for:", #<<
##                        values = c("Country" = "black", "Continent" = "blue")) + #<<
##     scale_size_manual(name = "Life Exp. for:",
##                       values = c("Country" = 0.25, "Continent" = 3)) +
##     theme_minimal(base_size = 14) +
##     ylab("Years") + xlab("") +
##     ggtitle("Life Expectancy, 1952-2007", subtitle = "By continent and country") +
##     theme(legend.position=c(0.75, 0.2), axis.text.x = element_text(angle = 45)) #<<

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) #<<
  #
  #
  #  
  #
  #
  #
  #
  #
  #

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line() #<<
  #
  #  
  #
  #
  #
  #
  #
  #

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line() +
  geom_line(stat = "smooth", method = "loess", #<<
            aes(group = continent)) #<<
  #
  #
  #
  #
  #
  #

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line() +
  geom_line(stat = "smooth", method = "loess", 
            aes(group = continent)) +
  facet_wrap(~ continent, nrow = 2) #<<
  #
  #
  #
  #
  #

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line(aes(color = "Country")) + #<<
  geom_line(stat = "smooth", method = "loess", 
            aes(group = continent, color = "Continent")) + #<<
  facet_wrap(~ continent, nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", values = c("Country" = "black", "Continent" = "blue")) #<<
  #
  #
  #
  #

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line(aes(color = "Country", size = "Country")) + #<<
  geom_line(stat = "smooth", method = "loess", 
            aes(group = continent, color = "Continent", size = "Continent")) + #<<
  facet_wrap(~ continent, nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", values = c("Country" = 0.25, "Continent" = 3)) #<<
  #
  #
  #

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.5, aes(color = "Country", size = "Country")) + #<<
  geom_line(stat = "smooth", method = "loess", 
            aes(group = continent, color = "Continent", size = "Continent"), alpha = 0.5) + #<<
  facet_wrap(~ continent, nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", values = c("Country" = 0.25, "Continent" = 3))
  #
  #
  #

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.5, aes(color = "Country", size = "Country")) +
  geom_line(stat = "smooth", method = "loess", 
            aes(group = continent, color = "Continent", size = "Continent"), alpha = 0.5) +
  facet_wrap(~ continent, nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", values = c("Country" = 0.25, "Continent" = 3)) +
  theme_minimal(base_size = 14) + ylab("Years") + xlab("") #<<
  #
  #

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.5, aes(color = "Country", size = "Country")) +
  geom_line(stat = "smooth", method = "loess", 
            aes(group = continent, color = "Continent", size = "Continent"), alpha = 0.5) +
  facet_wrap(~ continent, nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", values = c("Country" = 0.25, "Continent" = 3)) +
  theme_minimal(base_size = 14) + ylab("Years") + xlab("") + 
  ggtitle("Life Expectancy, 1952-2007", subtitle = "By continent and country") #<<
  #

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.5, aes(color = "Country", size = "Country")) +
  geom_line(stat = "smooth", method = "loess", 
            aes(group = continent, color = "Continent", size = "Continent"), alpha = 0.5) +
  facet_wrap(~ continent, nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", values = c("Country" = 0.25, "Continent" = 3)) +
  theme_minimal(base_size = 14) + ylab("Years") + xlab("") + 
  ggtitle("Life Expectancy, 1952-2007", subtitle = "By continent and country") +
  theme(axis.text.x = element_text(angle = 45)) #<<

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
  geom_line(alpha = 0.5, aes(color = "Country", size = "Country")) +
  geom_line(stat = "smooth", method = "loess", 
            aes(group = continent, color = "Continent", size = "Continent"), alpha = 0.5) +
  facet_wrap(~ continent, nrow = 2) +
  scale_color_manual(name = "Life Exp. for:", values = c("Country" = "black", "Continent" = "blue")) +
  scale_size_manual(name = "Life Exp. for:", values = c("Country" = 0.25, "Continent" = 3)) +
  theme_minimal(base_size = 14) + ylab("Years") + xlab("") + 
  ggtitle("Life Expectancy, 1952-2007", subtitle = "By continent and country") +
  theme(legend.position=c(0.82, 0.15), axis.text.x = element_text(angle = 45)) #<<

ggplot(data = gapminder, aes(x = year, y = lifeExp, group = country)) +
    geom_line(alpha = 0.5, aes(color = "Country", size = "Country")) +
    geom_line(stat = "smooth", method = "loess", aes(group = continent, color = "Continent", size = "Continent"), alpha = 0.5) +
    facet_wrap(~ continent, nrow = 2) +
    scale_color_manual(name = "Life Exp. for:", values = c("Country" = "black", "Continent" = "blue")) +
    scale_size_manual(name = "Life Exp. for:", values = c("Country" = 0.25, "Continent" = 3)) +
    theme_minimal(base_size = 14) + ylab("Years") + xlab("") + ggtitle("Life Expectancy, 1952-2007", subtitle = "By continent and country") +
    theme(legend.position=c(0.82, 0.15), axis.text.x = element_text(angle = 45))

## ggsave("I_saved_a_file.pdf", plot = lifeExp_by_year,
##        height = 3, width = 5, units = "in")

## ggplot(estimated_pes, aes(x = Target, y = PE, group = Reporter)) +
##   facet_grid(`Crime Type` ~ Neighborhood) +
##   geom_errorbar(aes(ymin = LB, ymax = UB),
##                 position = position_dodge(width = .4), size = 0.75, width = 0.15) +
##   geom_point(shape = 21, position = position_dodge(width = .4),
##              size = 2, aes(fill = Reporter)) +
##   scale_fill_manual("Reporter",
##                     values = c("Any White" = "white", "All Black" = "black")) +
##   ggtitle("Figure 3. Probability of Arrest",
##           subtitle = "by Reporter and Target Race, Neighborhood and Crime Type") +
##   xlab("Race of Target") + ylab("Estimated Probability") +
##   theme_bw() + theme(legend.position = c(0.86, 0.15),
##                      legend.background = element_rect(color = 1))
