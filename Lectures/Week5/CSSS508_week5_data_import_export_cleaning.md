CSSS 508, Week 5:   Importing, Exporting, and Cleaning
====================================================================================
author: Charles Lanfear
date: April 26, 2017
transition: linear
width: 1100
height: 750


Today's Theme: "Data Janitor Work"
====================================================================================
incremental: true

Issues around getting data *in* and *out* of R and making it analytically *ready*:

- Working directories and projects
- Importing and exporting data: `readr` and `haven`
- Cleaning and reshaping data: `tidyr`
- Dates and times: `lubridate`
- Controlling factor variables
 


Directories
====================================================================================
type: section

Working Directory
====================================================================================

You may recall that the **working directory** is where R will look for and save things by default.
You can find out what it is using the function `getwd()`. On my computer when I knitted this, it happens to be:

```r
getwd()
```

```
[1] "C:/Users/cclan/OneDrive/GitHub/CSSS508/Lectures/Week5"
```


Changing Your Working Directory
====================================================================================

You can use `setwd(dir = "C:/path/to/new/working/directory")` to change the working directory.

Comments:
* Windows users: make sure to change back slashes (`\`) to forward slashes (`/`) for the filepaths
* Recommendation is to put `setwd()` at the very beginning of your `.R` or `.Rmd` code so that someone using a different computer knows they need to modify it

In-class Example

Projects in RStudio
====================================================================================

Better way to deal with working directories: RStudio's **project** feature in the top-right dropdown. This has lots of advantages:

* Sets your working directory to be the project directory
* Can remember objects in your workspace, command history, etc. next time you re-open that project
* Reduce risk of intermingling different work using the same variable names (e.g. `n`) by using separate RStudio instances for each project
* Easy to integrate with version control systems (e.g. `git`)


Relative Paths
====================================================================================

Once you've set the working directory, you can refer to folders and files within using relative paths.


```r
library(ggplot2)
a_plot <- ggplot(data = cars, aes(x = speed, y = dist)) +
    geom_point()
ggsave("Graphics/cars_plot.png", plot = a_plot)
```

The above would save an image called "cars_plot.png" inside an existing folder called "Graphics" within my working directory.

Relative paths are nice, because all  locations of loaded and saved files can be changed just by altering the working directory. 

Importing and Exporting Data
====================================================================================
type: section


Special Data Access Packages
====================================================================================

Are you working with a popular data source? Try Googling to see if it has a devoted R package on CRAN or on Github (use `devtools::install_github` for these). Examples:

* `WDI`: World Development Indicators (World Bank)
* `WHO`: World Health Organization API
* `censusapi`: Census API
* `acs`: American Community Survey
* `quantmod`: financial data from Yahoo, FRED, Google


Delimited Text Files
====================================================================================

Besides a package, the easiest way to work with external data is for it to be stored in a *delimited* text file, e.g. comma-separated values (**csv**) or tab-separated values (**tsv**).

```
"Subject","Depression","Sex","Week","HamD","Imipramine"
101,"Non-endogenous","Male",0,26,NA
101,"Non-endogenous","Male",1,22,NA
101,"Non-endogenous","Male",2,18,4.04305
101,"Non-endogenous","Male",3,7,3.93183
101,"Non-endogenous","Male",4,4,4.33073
101,"Non-endogenous","Male",5,3,4.36945
103,"Non-endogenous","Female",0,33,NA
103,"Non-endogenous","Female",1,24,NA
103,"Non-endogenous","Female",2,15,2.77259
```

readr
====================================================================================

R has a variety of built-in functions for importing data stored in text files, like `read.table()` and `read.csv()`. I recommend using the versions in the `readr` package instead: `read_csv()`, `read_tsv()`, and `read_delim()`:

- Faster!
- Better defaults (e.g. doesn't automatically convert character data to factors)
- A little smarter about dates and times
- Handy function `problems()` you can run if there are errors


readr Importing Example
====================================================================================

```r
library(readr)
```
Let's import some data about song ranks on the Billboard Hot 100 back in 2000:

```r
billboard_2000_raw <- read_csv(file = "https://raw.githubusercontent.com/hadley/tidyr/master/vignettes/billboard.csv")
```

The data URL with a line break for readability:
```
https://raw.githubusercontent.com/hadley/tidyr/master/
vignettes/billboard.csv
```

Did It Load?
====================================================================================
incremental: true

Look at the data types for the last few columns:


```r
# str(billboard_2000_raw)
str(billboard_2000_raw[, 65:ncol(billboard_2000_raw)])
```

```
Classes 'tbl_df', 'tbl' and 'data.frame':	317 obs. of  17 variables:
 $ wk60: int  NA NA NA NA NA NA NA NA NA NA ...
 $ wk61: int  NA NA NA NA NA NA NA NA NA NA ...
 $ wk62: int  NA NA NA NA NA NA NA NA NA NA ...
 $ wk63: int  NA NA NA NA NA NA NA NA NA NA ...
 $ wk64: int  NA NA NA NA NA NA NA NA NA NA ...
 $ wk65: int  NA NA NA NA NA NA NA NA NA NA ...
 $ wk66: chr  NA NA NA NA ...
 $ wk67: chr  NA NA NA NA ...
 $ wk68: chr  NA NA NA NA ...
 $ wk69: chr  NA NA NA NA ...
 $ wk70: chr  NA NA NA NA ...
 $ wk71: chr  NA NA NA NA ...
 $ wk72: chr  NA NA NA NA ...
 $ wk73: chr  NA NA NA NA ...
 $ wk74: chr  NA NA NA NA ...
 $ wk75: chr  NA NA NA NA ...
 $ wk76: chr  NA NA NA NA ...
```


What Went Wrong?
====================================================================================
incremental: true

`readr` uses the values in the first 1000 rows to guess the type of the column (integer, logical, numeric, character). There are not many songs in the data that charted for 60+ weeks --- and none in the first 1000 that charted for 66+ weeks! 

To be safe, `readr` assumed the `wk66`-`wk76` columns were character. Use the `col_types` argument to fix this:


```r
# paste is a concatenation function
# i = integer, c = character, D = date
# rep("i", 76) does the 76 weeks of integer ranks
bb_types <- paste(c("icccD", rep("i", 76)), collapse="")

billboard_2000_raw <- read_csv(file = "https://raw.githubusercontent.com/hadley/tidyr/master/vignettes/billboard.csv", col_types = bb_types)
```


Excel Files
====================================================================================

The simplest thing to do with Excel files (`.xls` or `.xlsx`) is open them up, export to CSV, then import in R --- and compare carefully to make sure everything worked!

For Excel files that might get updated and you want the changes to flow to your analysis, I recommend using an R package such as `readxl` or `openxlsx`. For Google Docs Spreadsheets, there's the `googlesheets` package.

You won't keep text formatting, color, comments, or merged cells so if these mean something in your data (*bad*!), you'll need to get creative.


write_csv, write_tsv, write_delim
====================================================================================

Getting data out of R into a delimited file is very similar to getting it into R:


```r
write_csv(billboard_2000_raw, path = "billboard_data.csv")
```

This saved the data we pulled off the web in a file called "billboard_data.csv" in my working directory.


Saving in R Formats
====================================================================================

Exporting to a CSV drops R metadata, such as whether a variable is a character or factor. You can save objects (data frames, lists, etc.) in R formats to preserve this.

* `.Rds` format:
    + Used for single objects, doesn't save original the object name
    + Save: `write_rds(old_object_name, "path.Rds")`
    + Load: `new_object_name <- read_rds("path.Rds")`
* `.Rdata` or `.Rda` format:
    + Used for saving multiple files where the original object names are preserved
    + Save: `save(object1, object2, ... , file = "path.Rdata")`
    + Load: `load("path.Rdata")` with no assignment

dput
====================================================================================
incremental: true

For asking for help, it is useful to prepare a snippet of your data with `dput()`:


```r
dput(head(cars, 8))
```

```
structure(list(speed = c(4, 4, 7, 7, 8, 9, 10, 10), dist = c(2, 
10, 4, 22, 16, 10, 18, 26)), .Names = c("speed", "dist"), row.names = c(NA, 
8L), class = "data.frame")
```

The output of `dput()` can be copied and assigned to an object in R:

```r
temp <- structure(list(speed = c(4, 4, 7, 7, 8, 9, 10, 10), dist = c(2, 
10, 4, 22, 16, 10, 18, 26)), .Names = c("speed", "dist"), row.names = c(NA, 8L), class = "data.frame")
```


Reading in Data from Other Software
====================================================================================

Working with Stata or SPSS users? You can use a package to bring in their saved data files:

* `haven` for Stata, SPSS, and SAS. 
    + Part of the `tidyverse` family
* `foreign` for Stata, SPSS, Minitab
    + Part of base R

For less common formats, Google it. I've yet to encounter a data format without an 
R package to handle it (or at least a clever hack).


Cleaning Data
====================================================================================
type: section


Initial Spot Checks
====================================================================================
incremental: true

* Did the last rows/columns from the original file make it in?
    + May need to use different package or manually specify range
* Are the column names in good shape?
    + Modify a `col_names` argument or fix with `rename`
* Are there "decorative" blank rows or columns to remove?
    + `filter` or `select` out those rows/columns
* How are missing values represented: `NA`, blank, period, `999`?
    + Use `mutate` with `ifelse` to fix these (perhaps *en masse* with looping)
* Are there character data (e.g. ZIP codes with leading zeroes) being incorrectly represented as numeric or vice versa?
    + Modify `col_types` argument, or use `mutate` and `as.numeric`


"Pretty-Messy" Data
====================================================================================
incremental: true

| **Program**       | **Female** | **Male** |
|---------------|-------:|-----:|
| Evans School  |     10 |    6 |
| Arts & Sciences |    5 |    6 |
| Public Health |      2 |    3 |
| Other         |      5 |    1 |

* What is an observation?
    + A group of students from a program of a given gender
* What are the variables?
    + Program, gender
* What are the values?
    + Program: Evans School, Arts & Sciences, Public Health, Other
    + Gender: Female, Male -- **in the column headings, not its own column!**
    + Count: **spread over two columns!**


Billboard is Just "Ugly-Messy"
====================================================================================
incremental: true


```r
View(billboard_2000_raw)
```

* What are the **observations** in the data?
    + Week since entering the Billboard Hot 100 per song
* What are the **variables** in the data?
    + Year, artist, track, song length, date entered Hot 100, week since first entered Hot 100 (**spread over many columns**), rank during week (**spread over many columns**)
* What are the **values** in the data?
    + e.g. 2000; 3 Doors Down; Kryptonite; 3 minutes 53 seconds; April 8, 2000; Week 3 (**stuck in column headings**); rank 68 (**spread over many columns**)


tidy Data
====================================================================================
incremental: true

**Tidy data** (aka "long data") are such that:

1. The values for a single observation are in their own row.
2. The values for a single variable are in their own column.
3. The observations are all of the same nature.

Why do we want tidy data?

* Required for plotting in `ggplot2`
* Required for many types of statistical procedures (e.g. hierarchical or mixed effects models)
* Fewer confusing variable names
* Fewer issues with missing values and "imbalanced" repeated measures data


tidyr
====================================================================================
incremental: true

The `tidyr` package provides functions to tidy up data, similar to `reshape` in Stata or `varstocases` in SPSS. Key functions:

* `gather()`: takes a set of columns and rotates them down to make two new columns: one storing the original column names (`key`), and one with the values in those columns (`value`)
* `spread()`: inverts `gather()` by taking two columns and rotating them up
* `separate()`: pulls apart one column into multiple (common with freshly `gather`ed data where values had been embedded in column names)
    + `extract_numeric()` does a simple version of this for the common case when you just want grab the number part
* `unite()`: inverts `separate()` by gluing together multiple columns into one character column (less common)

gather()
====================================================================================
incremental: true

Let's use `gather()` to get the week and rank variables out of their current layout into two columns (big increase in rows, big drop in columns):

```r
library(dplyr)
library(tidyr)
billboard_2000 <- billboard_2000_raw %>%
    gather(key = week, value = rank, starts_with("wk"))
dim(billboard_2000)
```

```
[1] 24092     7
```
`starts_with()` and other helper functions from `dplyr::select()` work here too. Could instead use: `gather(key = week, value = rank, wk1:wk76)` to pull out these contiguous columns.


Gathering Better?
====================================================================================
incremental: true


```r
summary(billboard_2000$rank)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   1.00   26.00   51.00   51.05   76.00  100.00   18785 
```

* We don't want to keep the 18785 rows with missing ranks (i.e. observations for weeks since entering the Hot 100 that the song was no longer on the Hot 100).


Gathering Better: na.rm
====================================================================================
incremental: true

The argument `na.rm` to `gather()` will remove rows with missing ranks.

```r
billboard_2000 <- billboard_2000_raw %>%
    gather(key = week, value = rank, starts_with("wk"),
           na.rm = TRUE)
summary(billboard_2000$rank)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   1.00   26.00   51.00   51.05   76.00  100.00 
```


separate()
====================================================================================
incremental: true

The track length column isn't analytically friendly. Let's convert it to a number rather than the character (minutes:seconds) format:

```r
billboard_2000 <- billboard_2000 %>%
    separate(time, into = c("minutes", "seconds"),
             sep = ":", convert = TRUE) %>%
    mutate(length = minutes + seconds / 60) %>%
    select(-minutes, -seconds)
summary(billboard_2000$length)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  2.600   3.667   3.933   4.031   4.283   7.833 
```

parse_number()
====================================================================================
incremental: true

`tidyr` provides a convenience function to grab just the numeric information from a column that mixes text and numbers:


```r
billboard_2000 <- billboard_2000 %>%
    mutate(week = parse_number(week))
summary(billboard_2000$week)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   1.00    5.00   10.00   11.47   16.00   65.00 
```

For more sophisticated conversion or pattern checking, you'll need to use string parsing (to be covered later).


spread() Motivation
====================================================================================

`spread()` is the opposite of `gather()`, which you use if you have data for the same observation taking up multiple rows.

Example of data that we probably want to spread (unless we want to plot each statistic in its own facet):

| **Group** | **Statistic** | **Value** |
|-------|-----------|------:|
| A     | Mean      |  1.28 |
| A     | Median    |   1.0 |
| A     | SD        |  0.72 |
| B     | Mean      |  2.81 |
| B     | Median    |     2 |
| B     | SD        |  1.33 |

A common cue to use `spread` is you have measurements of different quantities in the same column. 


spread() Illustration: Before
====================================================================================
incremental: true


```r
(too_long_data <- data.frame(Group = c(rep("A", 3), rep("B", 3)), Statistic = rep(c("Mean", "Median", "SD"), 2), Value = c(1.28, 1.0, 0.72, 2.81, 2, 1.33)))
```

```
  Group Statistic Value
1     A      Mean  1.28
2     A    Median  1.00
3     A        SD  0.72
4     B      Mean  2.81
5     B    Median  2.00
6     B        SD  1.33
```

spread() Illustration: After
====================================================================================
incremental: true


```r
(just_right_data <- too_long_data %>%
    spread(key = Statistic, value = Value))
```

```
  Group Mean Median   SD
1     A 1.28      1 0.72
2     B 2.81      2 1.33
```

Charting the Charts of 2000: Data Prep
====================================================================================

Let's look at songs that hit #1 at some point and look how they got there vs. the songs that didn't:


```r
# find best rank for each song
best_rank <- billboard_2000 %>%
    group_by(artist, track) %>%
    summarize(min_rank = min(rank),
              weeks_at_1 = sum(rank == 1)) %>%
    mutate(`Peak rank` = ifelse(min_rank == 1, "Hit #1", "Didn't #1"))

# merge onto original data
billboard_2000 <- billboard_2000 %>%
    left_join(best_rank, by = c("artist", "track"))
```

Charting the Charts of 2000: ggplot2
====================================================================================


```r
library(ggplot2)
billboard_trajectories <- ggplot(
    data = billboard_2000,
    aes(x = week, y = rank,
        group = track, color = `Peak rank`)
    ) +
    geom_line(aes(size = `Peak rank`), alpha = 0.4) +
    # rescale time: early weeks more important
    scale_x_log10(breaks = seq(0, 70, 10)) +
    # want rank 1 on top, not bottom
    scale_y_reverse() + theme_classic() +
    scale_color_manual(values = c("black", "red")) +
    scale_size_manual(values = c(0.25, 1)) +
    theme(legend.position = c(0.90, 0.25),
          legend.background = element_rect(fill="transparent"))
```


Charting the Charts of 2000: Beauty!
====================================================================================
<img src="CSSS508_week5_data_import_export_cleaning-figure/unnamed-chunk-20-1.png" title="plot of chunk unnamed-chunk-20" alt="plot of chunk unnamed-chunk-20" width="1100px" height="500px" />

Observation: There appears to be censoring around week 20 for songs falling out of the top 50 that I'd want to follow up on.


Which Songs Were #1 the Most Weeks?
====================================================================================
incremental: true


```r
billboard_2000 %>%
    select(artist, track, weeks_at_1) %>%
    distinct(artist, track, weeks_at_1) %>%
    arrange(desc(weeks_at_1)) %>%
    head(7)
```

```
# A tibble: 7 × 3
               artist                   track weeks_at_1
                <chr>                   <chr>      <int>
1     Destiny's Child Independent Women Pa...         11
2             Santana            Maria, Maria         10
3 Aguilera, Christina Come On Over Baby (A...          4
4             Madonna                   Music          4
5       Savage Garden      I Knew I Loved You          4
6     Destiny's Child             Say My Name          3
7   Iglesias, Enrique             Be With You          3
```

Dates and Times
====================================================================================
type: section


Getting Usable Dates from Billboard
====================================================================================
incremental: true

We have the date the songs first charted, but not the dates for later weeks. We can calculate these now that the data is tidy:


```r
billboard_2000 <- billboard_2000 %>%
    mutate(date = date.entered + (week - 1) * 7)
billboard_2000 %>% arrange(artist, track, week) %>%
    select(artist, date.entered, week, date, rank) %>% head(4)
```

```
# A tibble: 4 × 5
  artist date.entered  week       date  rank
   <chr>       <date> <dbl>     <date> <int>
1  2 Pac   2000-02-26     1 2000-02-26    87
2  2 Pac   2000-02-26     2 2000-03-04    82
3  2 Pac   2000-02-26     3 2000-03-11    72
4  2 Pac   2000-02-26     4 2000-03-18    77
```


Preparing to Plot Over Calendar Time
====================================================================================


```r
plot_by_day <- ggplot(billboard_2000,
                      aes(x = date, y = rank, group = track)) +
    geom_line(size = 0.25, alpha = 0.4) +
    # just show the month abbreviation label (%b)
    scale_x_date(date_breaks = "1 month", date_labels = "%b") +
    scale_y_reverse() + theme_bw() +
    # add lines for start and end of year:
    # input as dates, then make numeric for plotting
    geom_vline(xintercept = as.numeric(as.Date("2000-01-01", "%Y-%m-%d")), col = "red") +
    geom_vline(xintercept = as.numeric(as.Date("2000-12-31", "%Y-%m-%d")), col = "red")
```


Calendar Time Plot!
====================================================================================

<img src="CSSS508_week5_data_import_export_cleaning-figure/unnamed-chunk-24-1.png" title="plot of chunk unnamed-chunk-24" alt="plot of chunk unnamed-chunk-24" width="1100px" height="500px" />

We see some of the entry dates are before 2000 --- presumably songs still charting during 2000 that came out earlier. 


Dates and Times
====================================================================================

To practice working with finer-grained temporal information, let's look at one day of Seattle Police response data Rebecca Ferrell obtained from [data.seattle.gov](http://data.seattle.gov):


```r
spd_raw <- read_csv("https://raw.githubusercontent.com/clanfear/CSSS508/master/Seattle_Police_Department_911_Incident_Response.csv")
```

The URL for the above:
```
https://raw.githubusercontent.com/clanfear/CSSS508/master/
Seattle_Police_Department_911_Incident_Response.csv
```
**Your turn**: inspect `spd_raw`. Do the types of all the variables make sense?


lubridate
====================================================================================


```r
str(spd_raw$`Event Clearance Date`)
```

```
 chr [1:706] "03/25/2016 11:58:30 PM" "03/25/2016 11:57:22 PM" ...
```

We want this to be in a date/time format ("POSIXct"), not character. We will work with dates 
using the `lubridate` package.


```r
# install.packages("lubridate")
library(lubridate)
spd <- spd_raw %>% mutate(`Event Clearance Date` = mdy_hms(`Event Clearance Date`, tz = "America/Los_Angeles"))
str(spd$`Event Clearance Date`)
```

```
 POSIXct[1:706], format: "2016-03-25 23:58:30" "2016-03-25 23:57:22" ...
```


Useful Date/Time Functions
====================================================================================
incremental: true


```r
demo_dts <- spd$`Event Clearance Date`[1:2]
(date_only <- as.Date(demo_dts, tz = "America/Los_Angeles"))
```

```
[1] "2016-03-25" "2016-03-25"
```

```r
(day_of_week_only <- weekdays(demo_dts))
```

```
[1] "Friday" "Friday"
```

```r
(one_hour_later <- demo_dts + dhours(1))
```

```
[1] "2016-03-26 00:58:30 PDT" "2016-03-26 00:57:22 PDT"
```


What Time of Day were Incidents Cleared?
====================================================================================


```r
spd_times <- spd %>%
    select(`Initial Type Group`, `Event Clearance Date`) %>%
    mutate(hour = hour(`Event Clearance Date`))

time_spd_plot <- ggplot(spd_times, aes(x = hour)) +
    geom_histogram(binwidth = 2) +
    facet_wrap( ~ `Initial Type Group`) +
    theme_minimal() +
    theme(strip.text.x = element_text(size = rel(0.6)))
```


Histogram of SPD Event Clearances, March 25
====================================================================================

<img src="CSSS508_week5_data_import_export_cleaning-figure/unnamed-chunk-30-1.png" title="plot of chunk unnamed-chunk-30" alt="plot of chunk unnamed-chunk-30" width="1100px" height="600px" />


Managing Factor Variables
====================================================================================
type: section


Factor Variables
====================================================================================
incremental: true

Factors are such a common (and fussy) vector type in R that we need to get to know them a little better when preparing data:

* Order of factor levels controls order of categories in tables, on axes, in legends, and in facets in `ggplot2`
    + Often want to plot in interpretable/aesthetically pleasing order, e.g. from highest to lowest values -- not **"Alabama first"**
* Lowest level of a factor is treated as a reference for regression, and the other levels get their own coefficients
    + Reference levels are by default alphabetical, which doesn't necessarily coincide with the easiest to understand baseline category


SPD Incident Types: Character to Factor
====================================================================================
incremental: true


```r
library(forcats)
str(spd_times$`Initial Type Group`)
```

```
 chr [1:706] "THEFT" "THEFT" "TRESPASS" "CRISIS CALL" ...
```

```r
spd_times$`Initial Type Group` <- parse_factor(spd_times$`Initial Type Group`, levels=NULL)
str(spd_times$`Initial Type Group`)
```

```
 Factor w/ 30 levels "THEFT","TRESPASS",..: 1 1 2 3 4 5 6 7 8 5 ...
```

```r
head(as.numeric(spd_times$`Initial Type Group`))
```

```
[1] 1 1 2 3 4 5
```

SPD Incident Types: Releveling by frequency
====================================================================================


```r
spd_vol <- spd_times %>% group_by(`Initial Type Group`) %>%
    summarize(n_events = n()) %>% arrange(desc(n_events))

# set levels using order from sorted frequency table
spd_times_2 <- spd_times %>% mutate(`Initial Type Group` = parse_factor(`Initial Type Group`, levels = spd_vol$`Initial Type Group`))

# replot
time_spd_plot_2 <- ggplot(spd_times_2, aes(x = hour)) +
    geom_histogram(binwidth = 2) +
    facet_wrap( ~ `Initial Type Group`) +
    theme_minimal() +
    theme(strip.text.x = element_text(size = rel(0.6)))
```

SPD Incident Types: Better ordered plot
====================================================================================

<img src="CSSS508_week5_data_import_export_cleaning-figure/unnamed-chunk-33-1.png" title="plot of chunk unnamed-chunk-33" alt="plot of chunk unnamed-chunk-33" width="1100px" height="600px" />

Other Ways to Reorder
====================================================================================

* Another way is through the `reorder()` function:

```
reorder(factor_vector,
        quantity_to_order_by,
        function_to_apply_to_quantities_by_factor)
```

This is especially useful for making legends go from highest to lowest value visually using `max()` as your function, or making axis labels go from lowest to highest value using `mean()`. 
* Use `relevel()` and use the `ref` argument to change the reference category
    + Good when fitting regressions where you don't care about the overall ordering, just which level is the reference


Reorder Legend Example: Jay-Z
====================================================================================


```r
jayz <- billboard_2000 %>% filter(artist == "Jay-Z") %>%
    mutate(track = factor(track))

jayz_bad_legend <- ggplot(jayz, aes(x = week, y = rank, group = track, color = track)) +
    geom_line() + theme_bw() +
    scale_y_reverse(limits = c(100, 0)) + 
    theme(legend.position = c(0.80, 0.25),
          legend.background = element_rect(fill="transparent"))
```

Jay-Z with Bad Legend Order
====================================================================================
<img src="CSSS508_week5_data_import_export_cleaning-figure/unnamed-chunk-35-1.png" title="plot of chunk unnamed-chunk-35" alt="plot of chunk unnamed-chunk-35" width="1100px" height="600px" />


Better Ordering for Jay-Z
====================================================================================


```r
jayz <- jayz %>% mutate(track = fct_reorder(track, rank, min)) # same as reorder()

jayz_good_legend <- ggplot(jayz, aes(x = week, y = rank, group = track, color = track)) +
    geom_line() + theme_bw() +
    scale_y_reverse(limits = c(100, 0)) + 
    theme(legend.position = c(0.80, 0.25),
          legend.background = element_rect(fill="transparent"))
```


Jay-Z with Good Legend Order
====================================================================================
<img src="CSSS508_week5_data_import_export_cleaning-figure/unnamed-chunk-37-1.png" title="plot of chunk unnamed-chunk-37" alt="plot of chunk unnamed-chunk-37" width="1100px" height="600px" />


Dropping Unused Levels
====================================================================================
incremental: true

After subsetting you can end up with fewer *realized* levels than before, but old levels remain linked and can cause problems for regressions. Drop unused levels from variables or your whole data using `droplevels()`.
 



```
processing file: CSSS508_week5_data_import_export_cleaning.Rpres

Attaching package: 'dplyr'

The following objects are masked from 'package:stats':

    filter, lag

The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union


Attaching package: 'lubridate'

The following object is masked from 'package:base':

    date

Quitting from lines 726-730 (CSSS508_week5_data_import_export_cleaning.Rpres) 
Error: `f` must be a factor (or character vector).
Execution halted
```
