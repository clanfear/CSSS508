<style>
code {
   background-color: #efefef;
   font-weight:bold;
}
</style>

CSSS508, Week 3: dplyr
====================================================================================
author: Charles Lanfear
date: April 11, 2018
transition: linear
width: 1600
height: 900
font-family: helvetica

Death to Spreadsheets
====================================================================================


Today we'll talk more about `dplyr`: a package that does in R just about any calculation you've tried to do in Excel, but more *transparently*, *reproducibly*, and *safely*. Don't be the sad research assistant who made this mistake ([Reinhart and Rogoff](http://www.bloomberg.com/news/articles/2013-04-18/faq-reinhart-rogoff-and-the-excel-error-that-changed-history)):

![Reinhart and Rogoff's spreadsheet error](http://rooseveltinstitute.org/wp-content/uploads/styles/large/public/content_images/reinhart_rogoff_coding_error_0.png)


Modifying Data Frames with dplyr
====================================================================================
type: section


But First, Pipes (%>%)
====================================================================================

`dplyr` uses the [`magrittr`](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html) forward pipe operator, usually called simply a **pipe**. We write pipes like `%>%` (`Ctrl+Shift+M`).

Pipes take the object on the *left* and apply the function on the *right*: `x %>% f(y) = f(x, y)`. Read out loud: "and then..."


```r
library(dplyr)
library(gapminder)
gapminder %>% filter(country == "Canada") %>% head(2)
```

```
# A tibble: 2 x 6
  country continent  year lifeExp      pop gdpPercap
  <fct>   <fct>     <int>   <dbl>    <int>     <dbl>
1 Canada  Americas   1952    68.8 14785584     11367
2 Canada  Americas   1957    70.0 17010154     12490
```

Pipes save us typing, make code readable, and allow chaining like above, so we use them *all the time* when manipulating data frames.


Using Pipes
====================================================================================
incremental: true

Pipes are clearer to read when you have each function on a separate line (inconsistent in these slides because of space constraints).

```r
take_this_data %>%
    do_first_thing(with = this_value) %>%
    do_next_thing(using = that_value) %>% ...
```

Stuff to the left of the pipe is passed to the *first argument* of the function on the right. Other arguments go on the right in the function. 

If you ever find yourself piping a function where data are not the first argument, use `.` in the data argument instead.

```r
yugoslavia %>% lm(pop ~ year, data = .)
```


Filtering Rows (subsetting)
====================================================================================

Recall last week we used the `filter()` command to subset data like so:

```r
Canada <- gapminder %>%
    filter(country == "Canada")
```

Excel analogue: Filter!

![Excel's filter](http://content.gcflearnfree.org/topics/143/ex07_filter.gif)


Another Operator: %in%
====================================================================================

Common use case: Filter rows to things in some *set*. The `c()` function is how we make **vectors** in R, which are an important data type. We can use `%in%` like `==` but for matching *any element* in the vector on its right.


```r
former_yugoslavia <- c("Bosnia and Herzegovina", "Croatia", "Macedonia",
                       "Montenegro", "Serbia", "Slovenia")
yugoslavia <- gapminder %>%
    filter(country %in% former_yugoslavia)
tail(yugoslavia, 2)
```

```
# A tibble: 2 x 6
  country  continent  year lifeExp     pop gdpPercap
  <fct>    <fct>     <int>   <dbl>   <int>     <dbl>
1 Slovenia Europe     2002    76.7 2011497     20660
2 Slovenia Europe     2007    77.9 2009245     25768
```


What Values are Out There? Use distinct()
====================================================================================

You can see all the unique values in your data for combinations of columns using `distinct()`:


```r
gapminder %>% distinct(continent, year)
```

```
# A tibble: 60 x 2
   continent  year
   <fct>     <int>
 1 Asia       1952
 2 Asia       1957
 3 Asia       1962
 4 Asia       1967
 5 Asia       1972
 6 Asia       1977
 7 Asia       1982
 8 Asia       1987
 9 Asia       1992
10 Asia       1997
# ... with 50 more rows
```


Note: distinct() drops unused variables!
====================================================================================

Note that the default behavior of `distinct()` is to drop all unspecified columns. If you want to get distinct rows by certain variables without dropping the others, use `distinct(.keep_all=TRUE)`:


```r
gapminder %>% distinct(continent, year, .keep_all=TRUE)
```

```
# A tibble: 60 x 6
   country     continent  year lifeExp      pop gdpPercap
   <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
 1 Afghanistan Asia       1952    28.8  8425333       779
 2 Afghanistan Asia       1957    30.3  9240934       821
 3 Afghanistan Asia       1962    32.0 10267083       853
 4 Afghanistan Asia       1967    34.0 11537966       836
 5 Afghanistan Asia       1972    36.1 13079460       740
 6 Afghanistan Asia       1977    38.4 14880372       786
 7 Afghanistan Asia       1982    39.9 12881816       978
 8 Afghanistan Asia       1987    40.8 13867957       852
 9 Afghanistan Asia       1992    41.7 16317921       649
10 Afghanistan Asia       1997    41.8 22227415       635
# ... with 50 more rows
```


Sampling Rows: sample_n()
====================================================================================

We can also filter *at random* to work with a smaller dataset using `sample_n()` or `sample_frac()`.


```r
set.seed(413) # makes random numbers repeatable
yugoslavia %>% sample_n(size = 6, replace = FALSE)
```

```
# A tibble: 6 x 6
  country    continent  year lifeExp     pop gdpPercap
  <fct>      <fct>     <int>   <dbl>   <int>     <dbl>
1 Montenegro Europe     1962    63.7  474528      4650
2 Montenegro Europe     1982    74.1  562548     11223
3 Serbia     Europe     1962    64.5 7616060      6290
4 Slovenia   Europe     1952    65.6 1489518      4215
5 Serbia     Europe     1952    58.0 6860147      3581
6 Croatia    Europe     1997    73.7 4444595      9876
```


Sorting: arrange()
====================================================================================

Along with filtering the data to see certain rows, we might want to sort it:


```r
yugoslavia %>% arrange(year, desc(pop)) # ascending by year, descending by pop
```

```
# A tibble: 60 x 6
   country                continent  year lifeExp     pop gdpPercap
   <fct>                  <fct>     <int>   <dbl>   <int>     <dbl>
 1 Serbia                 Europe     1952    58.0 6860147      3581
 2 Croatia                Europe     1952    61.2 3882229      3119
 3 Bosnia and Herzegovina Europe     1952    53.8 2791000       974
 4 Slovenia               Europe     1952    65.6 1489518      4215
 5 Montenegro             Europe     1952    59.2  413834      2648
 6 Serbia                 Europe     1957    61.7 7271135      4981
 7 Croatia                Europe     1957    64.8 3991242      4338
 8 Bosnia and Herzegovina Europe     1957    58.4 3076000      1354
 9 Slovenia               Europe     1957    67.8 1533070      5862
10 Montenegro             Europe     1957    61.4  442829      3682
# ... with 50 more rows
```


Keeping Columns: select()
====================================================================================

Not only can we limit rows, but we can include specific columns (and put them in the order listed) using `select()`. 


```r
yugoslavia %>% select(country, year, pop) %>% head(4)
```

```
# A tibble: 4 x 3
  country                 year     pop
  <fct>                  <int>   <int>
1 Bosnia and Herzegovina  1952 2791000
2 Bosnia and Herzegovina  1957 3076000
3 Bosnia and Herzegovina  1962 3349000
4 Bosnia and Herzegovina  1967 3585000
```


Dropping Columns: select()
====================================================================================

We can instead drop only specific columns with `select()` using `-` signs:


```r
yugoslavia %>% select(-continent, -pop, -lifeExp) %>% head(4)
```

```
# A tibble: 4 x 3
  country                 year gdpPercap
  <fct>                  <int>     <dbl>
1 Bosnia and Herzegovina  1952       974
2 Bosnia and Herzegovina  1957      1354
3 Bosnia and Herzegovina  1962      1710
4 Bosnia and Herzegovina  1967      2172
```


Helper Functions for select()
====================================================================================

`select()` has a variety of helper functions like `starts_with()`, `ends_with()`, and `contains()`, or giving a range of continguous columns `startvar:endvar`. These are very useful if you have a "wide" data frame with column names following a pattern or ordering. See `?select`.

![DYS Data Example](http://clanfear.github.io/CSSS508/Lectures/Week3/CSSS508_Week3_dplyr-figure/dys_vars.PNG)


```r
DYS %>% select(starts_with("married"))
DYS %>% select(ends_with("18"))
```


Renaming Columns with select()
====================================================================================

We can rename columns using `select()`, but that drops everything that isn't mentioned:


```r
yugoslavia %>%
    select(Life_Expectancy = lifeExp) %>%
    head(4)
```

```
# A tibble: 4 x 1
  Life_Expectancy
            <dbl>
1            53.8
2            58.4
3            61.9
4            64.8
```


Safer: Rename Columns with rename()
====================================================================================

`rename()` renames variables using the same syntax as `select()` without dropping unmentioned variables.


```r
yugoslavia %>%
    select(country, year, lifeExp) %>%
    rename(Life_Expectancy = lifeExp) %>%
    head(4)
```

```
# A tibble: 4 x 3
  country                 year Life_Expectancy
  <fct>                  <int>           <dbl>
1 Bosnia and Herzegovina  1952            53.8
2 Bosnia and Herzegovina  1957            58.4
3 Bosnia and Herzegovina  1962            61.9
4 Bosnia and Herzegovina  1967            64.8
```


Column Naming Practices
====================================================================================
incremental: true

* *Good* column names will be self-describing. Don't use inscrutable abbreviations to save typing. RStudio's autocompleting functions take away the pain of long variable names: Hit tab while writing code to autocomplete.
* *Valid* "naked" column names can contain upper or lowercase letters, numbers, periods, and underscores. They must start with a letter or period and not be a special reserved word (e.g. `TRUE`, `if`).
* Names are case-sensitive: `Year` and `year` are not the same thing!
* You can include spaces or use reserved words if you put backticks around the name. Spaces can be worth including when preparing data for `ggplot2` or `pander` since you don't have to rename axes or table headings.


Column Name with Space Example
====================================================================================


```r
library(pander)
yugoslavia %>% filter(country == "Serbia") %>%
    select(year, lifeExp) %>%
    rename(Year = year, `Life Expectancy` = lifeExp) %>%
    head(5) %>%
    pander(style = "rmarkdown", caption = "Serbian life expectancy")
```



| Year | Life Expectancy |
|:----:|:---------------:|
| 1952 |       58        |
| 1957 |      61.69      |
| 1962 |      64.53      |
| 1967 |      66.91      |
| 1972 |      68.7       |

Table: Serbian life expectancy


Create New Columns: mutate() and transmute()
====================================================================================

In `dplyr`, you can add new columns to a data frame using `mutate()`. 

You can also add new columns and *drop old ones* using `transmute()`.


mutate() Example
====================================================================================


```r
yugoslavia %>% filter(country == "Serbia") %>%
    select(year, pop, lifeExp) %>%
    mutate(pop_million = pop / 1000000,
           life_exp_past_40 = lifeExp - 40) %>%
    head(5)
```

```
# A tibble: 5 x 5
   year     pop lifeExp pop_million life_exp_past_40
  <int>   <int>   <dbl>       <dbl>            <dbl>
1  1952 6860147    58.0        6.86             18.0
2  1957 7271135    61.7        7.27             21.7
3  1962 7616060    64.5        7.62             24.5
4  1967 7971222    66.9        7.97             26.9
5  1972 8313288    68.7        8.31             28.7
```

Note you can create multiple variables in a single `mutate()` call by separating the formulae with commas.

ifelse()
====================================================================================

A common function used in `mutate()` (and in general in R programming) is `ifelse()`. This returns a value depending on logical tests.


```r
ifelse(test= x==y, yes=if_true, no=if_false)
```

Output from `ifelse()`:
* `ifelse()` returns the value assigned to `if_true` if `x==y` is `TRUE`.

* `ifelse()` returns `if_false` if `x==y` is `FALSE`.

* `ifelse()` returns `NA` if `x==y` is neither `TRUE` nor `FALSE`.

ifelse() Example
====================================================================================


```r
yugoslavia %>%
    mutate(short_country = ifelse(country == "Bosnia and Herzegovina", 
                                  "B and H", as.character(country))) %>%
    select(short_country, year, pop) %>%
    arrange(year, short_country) %>%
    head(3)
```

```
# A tibble: 3 x 3
  short_country  year     pop
  <chr>         <int>   <int>
1 B and H        1952 2791000
2 Croatia        1952 3882229
3 Montenegro     1952  413834
```

Read this as "For each row, if country equals 'Bosnia and Herzegovina, make `short_country` equal to 'B and H', otherwise make it equal to that row's value of `country`."

recode()
====================================================================================

`recode()` is another useful function to use inside `mutate()`. Use `recode()` to change specific values to other values. You can change multiple values at the same time using `recode()`. Note if a value has spaces in it, you'll need to put it in backticks!


```r
yugoslavia %>% 
  mutate(country = recode(country, 
                        `Bosnia and Herzegovina`="B and H",
                        Montenegro="M")) %>% 
  distinct(country)
```

```
# A tibble: 5 x 1
  country 
  <fct>   
1 B and H 
2 Croatia 
3 M       
4 Serbia  
5 Slovenia
```


case_when()
====================================================================================

`case_when()` performs multiple `ifelse()` operations at the same time. `case_when()` allows you to create a new variable with values based on multiple logical statements. This is useful for making categorical variables or variables from combinations of other variables.


```r
gapminder %>% mutate(gdpPercap_ordinal = case_when(
    gdpPercap < 700 ~ "low",
    gdpPercap >= 700 & gdpPercap < 800 ~ "moderate",
    TRUE ~ "high" )) # Assign this value when all other statements are FALSE
```

```
# A tibble: 1,704 x 7
   country     continent  year lifeExp      pop gdpPercap gdpPercap_ordinal
   <fct>       <fct>     <int>   <dbl>    <int>     <dbl> <chr>            
 1 Afghanistan Asia       1952    28.8  8425333       779 moderate         
 2 Afghanistan Asia       1957    30.3  9240934       821 high             
 3 Afghanistan Asia       1962    32.0 10267083       853 high             
 4 Afghanistan Asia       1967    34.0 11537966       836 high             
 5 Afghanistan Asia       1972    36.1 13079460       740 moderate         
 6 Afghanistan Asia       1977    38.4 14880372       786 moderate         
 7 Afghanistan Asia       1982    39.9 12881816       978 high             
 8 Afghanistan Asia       1987    40.8 13867957       852 high             
 9 Afghanistan Asia       1992    41.7 16317921       649 low              
10 Afghanistan Asia       1997    41.8 22227415       635 low              
# ... with 1,694 more rows
```
 

Summarizing with dplyr
====================================================================================
type: section


General Aggregation: summarize()
====================================================================================

`summarize()` takes your rows of data and computes something across them: count how many rows there are, calculate the mean or total, etc. You can use any function that aggregates multiple values into a single one (like `sd()`).

In a spreadsheet:

![Excel equivalent of summing a column](https://osiprodeusodcspstoa01.blob.core.windows.net/en-us/media/5feb1ba8-a0fb-49d1-8188-dcf1ba878a42.jpg)


summarize() Example
====================================================================================


```r
yugoslavia %>%
    filter(year == 1982) %>%
    summarize(n_obs = n(),
              total_pop = sum(pop),
              mean_life_exp = mean(lifeExp),
              range_life_exp = max(lifeExp) - min(lifeExp))
```

```
# A tibble: 1 x 4
  n_obs total_pop mean_life_exp range_life_exp
  <int>     <int>         <dbl>          <dbl>
1     5  20042685          71.3           3.94
```

These new variables are calculated using *all of the rows* in `yugoslavia`

Avoiding Repetition: summarize_at()
====================================================================================

Maybe you need to calculate the mean and standard deviation of a bunch of columns. With `summarize_at()`, put the variables to compute over first in `vars()` (like `select()` syntax) and put the functions to use in a `funs()` after.


```r
yugoslavia %>%
    filter(year == 1982) %>%
    summarize_at(vars(lifeExp, pop), funs(mean, sd))
```

```
# A tibble: 1 x 4
  lifeExp_mean pop_mean lifeExp_sd  pop_sd
         <dbl>    <dbl>      <dbl>   <dbl>
1         71.3  4008537       1.60 3237282
```

Note it automatically names the summarized variables based on the functions used to summarize.

Avoiding Repetition: Other functions
====================================================================================

There are additional `dplyr` functions similar to `summarize_at()`:

* `summarize_all()` and `mutate_all()` summarize / mutate *all* variables sent to them in the same way. For instance, getting the mean and standard deviation of an entire dataframe:

```
dataframe %>% summarize_all(funs(mean, sd))
```

* `summarize_if()` and `mutate_if()` summarize / mutate all variables that satisfy some logical condition. For instance, summarizing every numeric column in a dataframe at once:

```
dataframe %>% summarize_if(is.numeric, funs(mean, sd))
```

You can use all of these to avoid typing out the same code repeatedly!


Splitting Data into Groups: group_by()
====================================================================================

The special function `group_by()` changes how functions operate on the data, most importantly `summarize()`.

Functions after `group_by()` are computed *within each group* as defined by variables given, rather than over all rows at once. Typically the variables you group by will be integers, factors, or characters, and not continuous real values.

Excel analogue: pivot tables

![Pivot table](http://www.excel-easy.com/data-analysis/images/pivot-tables/two-dimensional-pivot-table.png)


group_by() example
====================================================================================



```r
yugoslavia %>% group_by(year) %>%
    summarize(num_countries = n_distinct(country),
              total_pop = sum(pop),
              total_gdp_per_cap = sum(pop * gdpPercap) / total_pop) %>%
    head(5)
```

```
# A tibble: 5 x 4
   year num_countries total_pop total_gdp_per_cap
  <int>         <int>     <int>             <dbl>
1  1952             5  15436728              3030
2  1957             5  16314276              4187
3  1962             5  17099107              5257
4  1967             5  17878535              6656
5  1972             5  18579786              8730
```

Because we did `group_by()` with `year` then used `summarize()`, we get *one row per year*!

Window Functions
====================================================================================

Grouping can also be used with `mutate()` or `filter()` to give rank orders within a group, lagged values, and cumulative sums. You can read more about window functions in this [vignette](https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html).


```r
yugoslavia %>% select(country, year, pop) %>%
    filter(year >= 2002) %>% group_by(country) %>%
    mutate(lag_pop = lag(pop, order_by = year),
           pop_chg = pop - lag_pop) %>% head(4)
```

```
# A tibble: 4 x 5
# Groups:   country [2]
  country                 year     pop lag_pop pop_chg
  <fct>                  <int>   <int>   <int>   <int>
1 Bosnia and Herzegovina  2002 4165416      NA      NA
2 Bosnia and Herzegovina  2007 4552198 4165416  386782
3 Croatia                 2002 4481020      NA      NA
4 Croatia                 2007 4493312 4481020   12292
```


Joining (Merging) Data Frames
====================================================================================
type: section


When Do We Need to Join Tables?
====================================================================================

* Want to make columns using criteria too complicated for `ifelse()` or `case_when()`
* Combine data stored in separate places: e.g. UW registrar information with student homework grades

Excel equivalents: `VLOOKUP`, `MATCH`

![VLOOKUP example](https://cdn.ablebits.com/_img-blog/excel-vlookup/excel-vlookup.png)


Joining: Conceptually
====================================================================================

We need to think about the following when we want to merge data frames `A` and `B`:

* Which *rows* are we keeping from each data frame?
* Which *columns* are we keeping from each data frame?
* Which variables determine whether rows *match*?


Types of Joins: Rows and columns to keep
====================================================================================

There are many types of joins...

* `A %>% left_join(B)`: keep all rows from `A`, matched with `B` wherever possible (`NA` when not), columns from both `A` and `B`
* `A %>% right_join(B)`: keep all rows from `B`, matched with `A` wherever possible (`NA` when not), columns from both `A` and `B`
* `A %>% inner_join(B)`: keep rows from `A` that match rows in `B`, columns from both `A` and `B`
* `A %>% full_join(B)`: keep all rows from either `A` or `B`, matched wherever possible (`NA` when not), columns from both `A` and `B`
* `A %>% semi_join(B)`: keep rows from `A` that match rows in `B`, columns from just `A`
* `A %>% anti_join(B)`: keep rows from `A` that *don't* match a row in `B`, columns from just `A`

... but usually `left_join()` does the job.

Matching Criteria
====================================================================================

We say rows should *match* because they have some columns containing the same value. We list these in a `by = ` argument to the join.

Matching Behavior:

* No `by`: Match using all variables in `A` and `B` that have identical names
* `by = c("var1", "var2", "var3")`: Match on identical values of `var1`, `,var2`, `var3` in both `A` and `B`
* `by = c("Avar1" = "Bvar1", "Avar2" = "Bvar2")`: Match identical values of `Avar1` variable in `A` to `Bvar1` variable in `B`, and `Avar2` variable in `A` to `Bvar2` variable in `B`

Note: If there are multiple matches, you'll get *one row for each possible combo* (except with `semi_join()` and `anti_join()`).

Need to get more complicated? You may want to learn SQL or break it into multiple operations.


nycflights13 Data
====================================================================================

We'll use data in the [`nycflights13` package](https://cran.r-project.org/web/packages/nycflights13/nycflights13.pdf). Install and load it:

```r
# install.packages("nycflights13") # Uncomment to run
library(nycflights13)
```

It includes five dataframes, some of which contain missing data (`NA`):

* `flights`: flights leaving JFK, LGA, or EWR in 2013
* `airlines`: airline abbreviations
* `airports`: airport metadata
* `planes`: airplane metadata
* `weather`: hourly weather data for JFK, LGA, and EWR

Note these are separate data frames, each needing to be loaded separately (e.g. `data(planes)`).

Join Example #1
====================================================================================

Who manufactures the planes that flew to Seattle?

```r
flights %>% filter(dest == "SEA") %>% 
    select(tailnum) %>%
    left_join(planes %>% select(tailnum, manufacturer), by = "tailnum") %>%
    distinct(manufacturer, .keep_all=T)
```

```
# A tibble: 6 x 2
  tailnum manufacturer      
  <chr>   <chr>             
1 N594AS  BOEING            
2 N503JB  AIRBUS INDUSTRIE  
3 N3ETAA  <NA>              
4 N712JB  AIRBUS            
5 N508JB  CIRRUS DESIGN CORP
6 N531JB  BARKER JACK L     
```

Note you can perform operations on the data inside functions such as `left_join()` and the *result* will be used by the function.

Join Example #2
====================================================================================

Which airlines had the most flights to Seattle from NYC?

```r
flights %>% filter(dest == "SEA") %>% 
    select(carrier) %>%
    left_join(airlines, by = "carrier") %>%
    group_by(name) %>% 
    tally() %>% 
    arrange(desc(n))
```

```
# A tibble: 5 x 2
  name                       n
  <chr>                  <int>
1 Delta Air Lines Inc.    1213
2 United Air Lines Inc.   1117
3 Alaska Airlines Inc.     714
4 JetBlue Airways          514
5 American Airlines Inc.   365
```


Join Example #3
====================================================================================

Is there a relationship between departure delays and wind gusts?


```r
library(ggplot2)
flights %>% 
    select(origin, year, month, day, hour, dep_delay) %>%
    inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
    select(dep_delay, wind_gust) %>%
    # removing rows with missing values
    filter(!is.na(dep_delay) & !is.na(wind_gust)) %>% 
    ggplot(aes(x = wind_gust, y = dep_delay)) +
    geom_point() + geom_smooth()
```

Wind Gusts and Delays
====================================================================================

<img src="CSSS508_Week3_dplyr-figure/unnamed-chunk-29-1.png" title="plot of chunk unnamed-chunk-29" alt="plot of chunk unnamed-chunk-29" width="1100px" height="600px" />

Check out those 1200 mph winds!

Redo After Removing Extreme Outliers, Just Trend
====================================================================================


```r
flights %>% 
    select(origin, year, month, day, hour, dep_delay) %>%
    inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
    select(dep_delay, wind_gust) %>%
    filter(!is.na(dep_delay) & !is.na(wind_gust) & wind_gust < 250) %>% 
    ggplot(aes(x = wind_gust, y = dep_delay)) +
    geom_smooth() + 
    theme_bw(base_size = 16) +
    xlab("Wind gusts in departure hour (mph)") +
    ylab("Average departure delay (minutes)")
```


Wind Gusts and Delays: Mean Trend
====================================================================================

<img src="CSSS508_Week3_dplyr-figure/unnamed-chunk-31-1.png" title="plot of chunk unnamed-chunk-31" alt="plot of chunk unnamed-chunk-31" width="1100px" height="600px" />


Tinkering Suggestions
====================================================================================

Some possible questions to investigate:

* What are the names of the most common destination airports?
* Which airlines fly from NYC to your home city?
* Is there a relationship between departure delays and precipitation?
* Use the time zone data in `airports` to convert flight arrival times to NYC local time.
    + What is the distribution of arrival times for flights leaving NYC over a 24 hour period?
    + Are especially late or early arrivals particular to some regions or airlines?

**Warning:** `flights` has 336776 rows, so if you do a sloppy join, you can end up with **many** matches per observation and have the data *explode* in size.


Homework 3
====================================================================================
type: section

Pick something to look at in the `nycflights13` data and write up a .Rmd file showing your investigation. Upload both the .Rmd file and the .html file to Canvas. You must use at least once: `mutate()`, `summarize()`, `group_by()`, and any join. *Include at least one nicely formatted plot (`ggplot2`) and one table (`pander`)*. In plots and tables, use "nice" variable names (try out spaces!) and rounded values (<= 3 digits).

This time, *include all your code in your output document* (`echo=TRUE`), using comments and line breaks separating commands so that it is clear to a peer what you are doing (or trying to do!). You must write up your observations briefly in words as well.  Note: If you want to see the `nycflights13` dataframes in the environment, you will need to load *each one* individually (`airlines`, `airports`, `flights`, `planes`, and `weather`) using `data(dataframe_name)` (e.g. `data(flights)`).

DUE: 11:59 PM, April 17th

