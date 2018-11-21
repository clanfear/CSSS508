---
layout: default
---

# CSSS 508
## Introduction to R for Social Scientists
### University of Washington

## Important links

* [Canvas Page (enrolled students only)](https://canvas.uw.edu/courses/1219583)
* [Syllabus](https://clanfear.github.io/CSSS508/docs/syllabus.html)
* [Homework Instructions](https://clanfear.github.io/CSSS508/docs/homework.html) and grading rubric.
* [Peer Review Instructions](https://clanfear.github.io/CSSS508/docs/peer_review.html) and suggestions for reading code.
* [Class Mailing List](mailto:csss508a_au18@uw.edu)
* [Class Slack Channel](https://uwcsss508au18.slack.com/)
* [R and RStudio Installation Instructions](https://clanfear.github.io/CSSS508/docs/installation.html)
* [Function Lecture Reference](https://clanfear.github.io/CSSS508/docs/functions.html)

## Helpful resources:

* [R for Data Science online](http://r4ds.had.co.nz/) textbook by Garrett Grolemund and Hadley Wickham. One of many good R texts available, but importantly it is free and focuses on the [`tidyverse`](http://tidyverse.org/) collection of R packages which form the backbone of this course.
* [Advanced R](http://adv-r.had.co.nz/) online textbook by Hadley Wickham. A great source for more in-depth and advanced R programming.
* [DataCamp for CSSS508 AU18](https://www.datacamp.com/enterprise/csss508-autumn-2018): Interactive R tutorials provided free of charge for six months to registered CSSS508 students courtesy of [DataCamp](https://www.datacamp.com/).

## Weekly lecture notes and links:

### 1. RStudio and R Markdown
   * [Slides for Lecture 1: Course logistics, R/RStudio, and R Markdown](https://clanfear.github.io/CSSS508/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.html)
       + [Rmd for Lecture 1 slides](https://clanfear.github.io/CSSS508/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.Rmd)
   * [Lecture Video for Lecture 1](https://youtu.be/u6_uhABKia4), recorded September 26, 2018
   * Homework 1: Due at 11:59PM on October 2nd
       + [Homework 1 Instructions](https://clanfear.github.io/CSSS508/Homework/HW1/homework_1.html)
       + Homework 1 Key #1: [HTML](https://clanfear.github.io/CSSS508/Homework/HW1/HW1_Keys/homework_1_key_1.html), [RMD](https://clanfear.github.io/CSSS508/Homework/HW1/HW1_Keys/homework_1_key_1.Rmd)
       + Homework 1 Key #2: [HTML](https://clanfear.github.io/CSSS508/Homework/HW1/HW1_Keys/homework_1_key_2.html), [RMD](https://clanfear.github.io/CSSS508/Homework/HW1/HW1_Keys/homework_1_key_2.Rmd)
   * [Get R](https://cran.r-project.org/)
   * [Get RStudio](https://www.rstudio.com/)
   * [R Markdown Installation](https://bookdown.org/yihui/rmarkdown/installation.html#installation) - Also has LaTeX installation instructions
   * [Introduction to R Markdown](https://rmarkdown.rstudio.com/lesson-1.html)
   * [RMarkdown documentation](http://rmarkdown.rstudio.com/)
       + [HTML document options](http://rmarkdown.rstudio.com/html_document_format.html) (global formatting, etc.)
       + [PDF document options](http://rmarkdown.rstudio.com/pdf_document_format.html) (requires LaTeX installation to output PDFs)
       + [Word document options](http://rmarkdown.rstudio.com/word_document_format.html) (but please do not use Word output for this class!)
   * [R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/) by Xie, Allaire, and Grolemund, a comprehensive textbook on R Markdown.
   * [Useful RStudio cheatsheets](https://www.rstudio.com/resources/cheatsheets/) on R Markdown, RStudio shortcuts, etc.
   * [Information on the `prettydoc` package](https://yixuan.cos.name/prettydoc/cayman.html) for nicer looking RMarkdown themes
   * [Presentations in RStudio](https://support.rstudio.com/hc/en-us/articles/200486468-Authoring-R-Presentations) for simple presentations
   * [Xaringan](https://github.com/yihui/xaringan) for advanced presentations
   * [`pander` documentation](http://rapporter.github.io/pander/) for making tables, etc.
   * [Shapes and line types](http://www.cookbook-r.com/Graphs/Shapes_and_line_types/) in base R
   * [Color names (PDF)](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf) in base R
   
### 2. Visualizing Data
   * [Slides for Lecture 2: Plotting with `ggplot2`](https://clanfear.github.io/CSSS508/Lectures/Week2/CSSS508_Week2_GGPlot2.html)
       + [Rmd for Lecture 2 slides](https://clanfear.github.io/CSSS508/Lectures/Week2/CSSS508_Week2_GGPlot2.Rmd)
   * [Lecture Video for Lecture 2](https://youtu.be/1vxyNzcuswk), recorded October 3, 2018
   * Homework 2: Due at 11:59PM on October 9th
       + [Homework 2 Instructions](https://clanfear.github.io/CSSS508/Homework/HW2/homework_2.html)
   * Reading: **[Visualization chapter in R for Data Science](http://r4ds.had.co.nz/data-visualisation.html)**
   * [`ggplot2` documentation](http://docs.ggplot2.org/current/)
   * [`ggplot2` Cheat Sheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf)
   * [Cookbook for R graph reference](http://www.cookbook-r.com/Graphs/)
   * [R graph catalog at UBC](http://shiny.stat.ubc.ca/r-graph-catalog/)
   * `ggplot2` add-ons
       + [`ggthemes` package](https://github.com/jrnold/ggthemes)
       + [`cowplot` package](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html) for publication ready graphs, multiple plots in single image, etc.
       + [`gganimate` package](https://github.com/dgrtwo/gganimate) for easy animations (saving GIFs requires [ImageMagick](https://www.imagemagick.org/script/index.php) or [GraphicsMagick](http://www.graphicsmagick.org/))
   * [Hadley Wickham on the grammar of graphics](http://vita.had.co.nz/papers/layered-grammar.html)
   * [Tufte in R](http://motioninsocial.com/tufte/) (if that's your sort of thing)

### 3. Manipulating and Summarizing Data
   * [Slides for Lecture 3: Manipulating and summarizing data with `dplyr`](https://clanfear.github.io/CSSS508/Lectures/Week3/CSSS508_Week3_dplyr.html)
       + [Rmd for Lecture 3 slides](https://clanfear.github.io/CSSS508/Lectures/Week3/CSSS508_Week3_dplyr.Rmd)
   * [Lecture Video for Lecture 3](https://youtu.be/giKghK_7z7c), recorded October 10, 2018
   * Homework 3: Due at 11:59PM on October 16th
       + [Homework 3 Instructions](https://clanfear.github.io/CSSS508/Homework/HW3/homework_3.html)
       + [nycflights13 documentation](https://cran.r-project.org/web/packages/nycflights13/nycflights13.pdf)
   * Reading: **[Data Transformation chapter in R for Data Science](http://r4ds.had.co.nz/transform.html)**
   * [A cautionary tale about Excel](http://www.bloomberg.com/news/articles/2013-04-18/faq-reinhart-rogoff-and-the-excel-error-that-changed-history)
   * `dplyr` stuff:
       + [`dplyr` cheatsheets](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) with diagrams to help you remember functions
       + [Introduction to `dplyr`](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
       + [Window functions in `dplyr`](https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html)
       + [Joining data in `dplyr`](https://cran.rstudio.com/web/packages/dplyr/vignettes/two-table.html)
       + More advanced joins: [`sqldf` for easy SQL in R](https://cran.r-project.org/web/packages/sqldf/index.html)
   
### 4. Understanding R Data Structures
   * [Slides for Lecture 4: R data structures](https://clanfear.github.io/CSSS508/Lectures/Week4/CSSS508_week4_data_structures.html)
       + [Rmd for Lecture 4 slides](https://clanfear.github.io/CSSS508/Lectures/Week4/CSSS508_week4_data_structures.Rmd)
   * [Lecture Video for Lecture 4](https://youtu.be/fc6Rc7Fbv0g), recorded October 17, 2018
   * Homework 4 (two options, complete one): Due at 11:59PM on October 23rd
       + Homework 4: R Data Structures (Less Advanced)
           * [Homework 4: R Data Structures, R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW4/homework_4.Rmd) (you will download this, fill in and submit on Canvas)
           * [Homework 4: R Data Structures, HTML Document](https://clanfear.github.io/CSSS508/Homework/HW4/homework_4.html)
           * Homework 4: Data Structures, Key: [HTML](https://clanfear.github.io/CSSS508/Homework/HW4/HW4_Keys/homework_4_key.html), [RMD](https://clanfear.github.io/CSSS508/Homework/HW4/HW4_Keys/homework_4_key.Rmd)
       + Homework 4: Linear Regression (More Advanced)
           * [Homework 4: Linear Regression, R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW4_regression/HW4_regression.Rmd) (you will download this, fill in and submit on Canvas)
           * [Homework 4: Linear Regression, HTML Document](https://clanfear.github.io/CSSS508/Homework/HW4_regression/HW4_regression.html)
           * Homework 4: Linear Regression, Key: [HTML](https://clanfear.github.io/CSSS508/Homework/HW4/HW4_Keys/HW4_regression_key.html), [RMD](https://clanfear.github.io/CSSS508/Homework/HW4/HW4_Keys/HW4_regression_key.Rmd)
   * [Setting up swirl for practice](http://swirlstats.com/students.html)
   * Reading: **[Data Structures chapter in Advanced R](http://adv-r.had.co.nz/Data-structures.html)**

### 5. Importing, Exporting, and Cleaning Data
   * [Slides for Lecture 5: Data import, export, and cleaning](https://clanfear.github.io/CSSS508/Lectures/Week5/CSSS508_week5_data_import_export_cleaning.html)
       + [Rmd for Lecture 5 slides](https://clanfear.github.io/CSSS508/Lectures/Week5/CSSS508_week5_data_import_export_cleaning.Rmd)
   * [Lecture Video for Lecture 5](https://youtu.be/vPjW6jKVINI), recorded October 24, 2018
   * Homework 5, Part 1 due at 11:59 PM on October 30th
       + [Homework 5: R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW5/homework_5.Rmd) (you will download this, fill in and submit on Canvas)
       + [Homework 5: HTML Document](https://clanfear.github.io/CSSS508/Homework/HW5/homework_5.html)
       + Homework 5, Part 1 Key: [HTML](https://clanfear.github.io/CSSS508/Homework/HW5/HW5_Keys/homework_5_p1_key.html), [RMD](https://clanfear.github.io/CSSS508/Homework/HW5/HW5_Keys/homework_5_p1_key.Rmd)
       + [2016 general election voting data for King County](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW5/king_county_elections_2016.txt) (60 MB download; save, *don't load in browser*!)
   * Data in-class:
       + [Billboard Hot 100 data from 2000](https://raw.githubusercontent.com/hadley/tidyr/master/vignettes/billboard.csv)
       + [One day of Seattle Police Department incident data](https://raw.githubusercontent.com/clanfear/CSSS508/master/Seattle_Police_Department_911_Incident_Response.csv)
   * Data import and export:
       + [`readr` documentation](https://cran.r-project.org/web/packages/readr/readr.pdf)
       + [Column types in readr](https://cran.r-project.org/web/packages/readr/vignettes/column-types.html)
       + [Using `dput()` when asking for help](http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example)
       + [`readxl`](https://github.com/hadley/readxl) and [`openxlsx`](https://cran.r-project.org/web/packages/openxlsx/vignettes/Introduction.pdf) packages for Excel
   * General data access and cleaning:
       + [New York Times article on "data janitor" work](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html)
       + [Quartz guide to bad data: a must read!](http://qz.com/572338/the-quartz-guide-to-bad-data/)
       + [Lots of resources on survey data sources and analysis in R](http://www.asdfree.com/)
       + [rOpenSci](https://ropensci.org/packages/) (many packages for accessing particular data sources in R)
       + [`qualtrics` API package](https://github.com/jbryer/qualtrics) and [`Rmonkey` for Survey Monkey](https://github.com/cloudyr/Rmonkey)
   * Tidying:
       + [`tidyr` vignette](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)
       + [Tidy genomics](http://varianceexplained.org/r/tidy-genomics/) (a walkthough of tidy data preparation and analysis)
   * Dates and times:
       + [`lubridate` vignette](https://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html)
   * Factors:
       + [Lots on factors from Jenny Bryan](http://stat545-ubc.github.io/block014_factors.html)
       
### 6. Using Loops
   * [Slides for Lecture 6: Looping with `for()` loops](http://clanfear.github.io/CSSS508/Lectures/Week6/CSSS508_week6_loops.html)
       + [Rmd for Lecture 6 slides](http://clanfear.github.io/CSSS508/Lectures/Week6/CSSS508_week6_loops.Rmd)
   * [Lecture Video for Lecture 6](https://youtu.be/D0Zz3Sfxpxw), recorded October 31, 2018
   * Homework 5, Part 2 due at 11:59 PM on November 6th
       + [Homework 5: R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW5/homework_5_p2.Rmd) (you will download this, fill in and submit on Canvas)
       + [Homework 5: HTML Document](https://clanfear.github.io/CSSS508/Homework/HW5/homework_5_p2.html)
       + Homework 5, Part 2 Key: [HTML](https://clanfear.github.io/CSSS508/Homework/HW5/HW5_Keys/homework_5_p2_key.html), [RMD](https://clanfear.github.io/CSSS508/Homework/HW5/HW5_Keys/homework_5_p2_key.Rmd)
   
### 7. Writing Functions
   * [Slides for Lecture 7: Vectorization and writing functions](http://clanfear.github.io/CSSS508/Lectures/Week7/CSSS508_week7_vectorization.html)
       + [Rmd for Lecture 7 slides](http://clanfear.github.io/CSSS508/Lectures/Week7/CSSS508_week7_vectorization.Rmd)
   * [Lecture Video for Lecture 7](https://youtu.be/Eghfhtzr4jg), recorded November 7th, 2018
   * Homework 6, Part 1 due at 11:59 PM on November 13th
       + [Homework 6, Part 1: R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW6/homework_6.Rmd)
       + [Pronto! bike share data from fall 2014 through fall 2015](https://s3.amazonaws.com/pronto-data/open_data_year_one.zip)
       + Homework 6, Part 1 Key: [HTML](https://clanfear.github.io/CSSS508/Homework/HW6/HW6_Keys/homework_6_p1_key.html), [HTML](https://clanfear.github.io/CSSS508/Homework/HW6/HW6_Keys/homework_6_p1_key.Rmd)
   * [The R Inferno by Patrick Burns [PDF]](http://www.burns-stat.com/pages/Tutor/R_inferno.pdf): "Circles" 2, 3, and 4 are relevant after this week's material, and Circle 8 covers a lot of miscellaneous R weird things that may trip you up.
   * [Reference material on writing functions](http://r4ds.had.co.nz/functions.html) with lots of examples
   * [Code style guide](http://adv-r.had.co.nz/Style.html) for writing functions, etc.
   * [R, the master troll of statistical languages](http://www.talyarkoni.org/blog/2012/06/08/r-the-master-troll-of-statistical-languages/) (to read if you feel a bit frustrated!)

### 8.  Working with Text Data
   * [Slides for Lecture 8: Working with strings and character data](http://clanfear.github.io/CSSS508/Lectures/Week8/CSSS508_week8_strings.html)
       + [Rmd for Lecture 8 slides](http://clanfear.github.io/CSSS508/Lectures/Week8/CSSS508_week8_strings.Rmd)
   * [Lecture Video for Lecture 8](https://youtu.be/ZwjncjjTwC4), recorded November 14th, 2018
   * Homework 6, Part 2 due at 11:59 PM on November 20th
       + Homework 6, Part 2: R Markdown template
       + Homework 6, Part 2 Key: HTML, RMD
   * Data In-Class:
       + [Seattle restaurant inspection data from King County, cleaned.](http://clanfear.github.io/CSSS508/Lectures/Week8/restaurants.Rdata)
       + [Data source, King County](https://data.kingcounty.gov/Health/Food-Establishment-Inspection-Data/f29f-zza5)
   * [RStudio Cheat Sheet for Strings](https://github.com/rstudio/cheatsheets/raw/master/strings.pdf)
   * [`stringr` vignette](https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html)
   * [Site for regular expression testing](http://regexr.com/)  with a good cheatsheet and hover explanations
   * [Blog post explaining `paste()`](https://trinkerrstuff.wordpress.com/2013/09/15/paste-paste0-and-sprintf-2) for combining strings
   
### 9. Working with Geographical Data
   * [Slides for Lecture 9: Mapping and labels in `ggplot2`](http://clanfear.github.io/CSSS508/Lectures/Week9/CSSS508_week9_mapping.html)
       + [R code in Lecture 9 slides](http://clanfear.github.io/CSSS508/Lectures/Week9/CSSS508_week9_mapping.Rmd)
   * [Lecture Video for Lecture 9](https://youtu.be/NUL9ndVbuOE), recorded Spring 2018
   * Optional Homework 7: Due at 11:59 PM on November 27th
       + [Homework 7: R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW7/homework_7.Rmd)
       + [Homework 7: HTML File](http://clanfear.github.io/CSSS508/Homework/HW7/homework_7.html)
       + [Seattle restaurant inspection data since 2012](http://clanfear.github.io/CSSS508/Lectures/Week8/restaurants.Rdata) (CSV, about 16 MB) from King County
       + Homework 7 Key: HTML, RMD [Posted after HW7]
   * Suggested text: [Applied Spatial Data Analysis with R](http://www.springer.com/us/book/9781461476177)  by Bivand et al.
   * [RSpatial.org](http://www.rspatial.org/index.html): Massive resource for spatial analysis in R
   * [`ggmap` package examples](https://github.com/dkahle/ggmap)
   * [More in depth `ggmap` examples](http://vita.had.co.nz/papers/ggmap.pdf)
   * [`ggrepel` package vignette](https://cran.r-project.org/web/packages/ggrepel/vignettes/ggrepel.html)
   * [`sf` Vignette: Overview](https://cran.r-project.org/web/packages/sf/vignettes/sf1.html)
   * [`sf` Home Page](https://r-spatial.github.io/sf/)

### 10. Reproducibility and Best Practices
   * [Slides for Lecture 10: Reproducibility and Best Practices](http://clanfear.github.io/CSSS508/Lectures/Week10/CSSS508_week10_reproducibility.html)
      + [Rmd for Lecture 10 slides](http://clanfear.github.io/CSSS508/Lectures/Week10/CSSS508_week10_reproducibility.Rmd)
   * Leacture Video for Lecture 10
   * Reading: [Good Enough Practices in Scientific Computing](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510)
   * R Packages:
      + [`huskydown`](https://github.com/benmarwick/huskydown)
      + [`rrtools`](https://github.com/benmarwick/rrtools)
      
### 11. Working with Model Results (Under Renovation)
   * [Slides for Lecture 11: Tidy Model Results and Applied Data Cleaning](http://clanfear.github.io/CSSS508/Lectures/Week11/CSSS508_Week11_model_results.html)
       + [Rmd for Lecture 11 slides](http://clanfear.github.io/CSSS508/Lectures/Week11/CSSS508_Week11_model_results.Rmd)
   * [Lecture Video for Lecture 11](https://youtu.be/JjM0VYNGkUo), recorded Spring 2018
   * [`broom` vignette](https://cran.r-project.org/web/packages/broom/vignettes/broom.html)
   * [`ggeffects` vignette](https://cran.r-project.org/web/packages/ggeffects/vignettes/marginaleffects.html)
   * [`sjPlot` home page](http://www.strengejacke.de/sjPlot/)
   * [Overleaf online LaTeX editor](http://www.overleaf.com/)

### 12. Working with Social Media Data (Out of Date)
   * [Slides for Lecture 12: Social media and text mining](http://clanfear.github.io/CSSS508/Lectures/Week10/CSSS508_week10_scraping.html)
       + [Rmd for Lecture 12 slides](http://clanfear.github.io/CSSS508/Lectures/Week10/CSSS508_week10_scraping.Rpres)
   * [Lecture Video for Week 12](https://youtu.be/DJIgMr8GrzM), recorded Autumn 2017
   * [Twitter Apps portal](https://apps.twitter.com/)
   * [Fabulous analysis of Trump tweets using R](http://varianceexplained.org/r/trump-tweets/)
   * [Absolute Beginner's Guide to `SocialMediaLab`](http://www.academia.edu/19064267/Absolute_Beginners_Guide_to_the_SocialMediaLab_package_in_R)
   * [Static and Dynamic Network Visualizations with R](http://kateto.net/network-visualization)
   * [`rvest` for harvesting web data:](https://github.com/hadley/rvest)
       + [SelectorGadget](https://cran.r-project.org/web/packages/rvest/vignettes/selectorgadget.html)  for getting tags
       + [Good demo on State of the Union speeches by Jerid Francom](http://francojc.github.io/web-scraping-with-rvest/)
       + [Another demo pulling Superbowl scores by David Radcliffe](https://rpubs.com/Radcliffe/superbowl)
   * [`tm` package for text mining:](https://cran.r-project.org/web/packages/tm/index.html)
       + [`tm` vignette](https://cran.r-project.org/web/packages/tm/vignettes/tm.pdf)
       + [Slides by Yanchang Zhao on `tm` and Twitter data](http://www.rdatamining.com/docs/text-mining-with-r)
       + [`tidytext`](https://github.com/juliasilge/tidytext)  for tidy text analysis
       + [`quanteda`](https://github.com/kbenoit/quanteda) package for another set of tools
   * Social media data extraction tools:
       + [`twitteR`](https://cran.r-project.org/web/packages/twitteR/index.html) package for accessing Twitter in R
       + [Setting up API keys and secrets](http://bigcomputing.blogspot.com/2016/02/the-twitter-r-package-by-jeff-gentry-is.html)
       + [`twitteR` functions](http://geoffjentry.hexdump.org/twitteR.pdf)
       + [`streamR`](https://github.com/pablobarbera/streamR) for the streaming Twitter API
       + [`Rfacebook`](https://github.com/pablobarbera/Rfacebook)
   * [Shiny](http://shiny.rstudio.com/gallery/) for interactive R apps

This project is maintained by [clanfear](https://github.com/clanfear) and based on material from [rebeccaferrell](https://github.com/rebeccaferrell) with permission.