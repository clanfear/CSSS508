---
layout: default
---

Welcome to CSSS 508: Introduction to R for Social Scientists

University of Washington, Autumn 2018

Instructor: [Charles Lanfear](mailto:clanfear@uw.edu), PhD student, UW Sociology

## Important Links

* [Canvas page for course (enrolled students only)](https://canvas.uw.edu/courses/1219583)
* [Syllabus](https://clanfear.github.io/CSSS508/docs/syllabus.html)
* [Homework Instructions](https://clanfear.github.io/CSSS508/docs/homework.html) and grading rubric.
* [Peer Review Instructions](https://clanfear.github.io/CSSS508/docs/peer_review.html) and suggestions for reading code.

## Helpful resources:

* [R for Data Science online](http://r4ds.had.co.nz/) textbook by Garrett Grolemund and Hadley Wickham. One of many good R texts available, but importantly it is free and focuses on the [`tidyverse`](http://tidyverse.org/) collection of R packages which form the backbone of this course.
* [Advanced R](http://adv-r.had.co.nz/) online textbook by Hadley Wickham. A great source for more in-depth and advanced R programming.
* [DataCamp for CSSS508](https://www.datacamp.com/enterprise/csss508-introduction-to-r-for-social-scientists/): Interactive R tutorials provided free of charge to registered CSSS508 students by DataCamp.
* [Jenny Bryan's materials for STAT545 at UBC](Jenny Bryan's materials for STAT545 at UBC). CSSS508 is partly based on Rebecca Ferrell's abbreviated version of Bryan's course, so more explanations can be found on her page.
* [Instructions for using RStudio in the CSSCR lab](https://clanfear.github.io/CSSS508/docs/CSSCR.html) (hopefully week 1 only; I would prefer you become comfortable using your own computers!)

## Weekly lecture notes and links:

1. RStudio and Markdown
   * [Slides for week 1: Course logistics, R/RStudio, making R Markdown documents](https://clanfear.github.io/CSSS508/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.html)
       + [Rmd for Week 1 slides](https://clanfear.github.io/CSSS508/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.Rmd)
   * [Lecture Video for Week 1](https://youtu.be/iLqvlSgiO6c)
   * Homework 1: Due at 11:59PM on October 2nd
       + [Homework 1 Instructions](https://clanfear.github.io/CSSS508/Homework/HW1/homework_1.html)
       + Homework 1 Key #1: HTML, RMD
       + Homework 1 Key #2: HTML, RMD
   * [Get R](https://cran.r-project.org/)
   * [Get RStudio](https://www.rstudio.com/)
   * [RMarkdown documentation](http://rmarkdown.rstudio.com/)
       + [HTML document options (global formatting, etc.)](http://rmarkdown.rstudio.com/html_document_format.html)
       + [PDF document options (requires LaTeX installation to output PDFs)](http://rmarkdown.rstudio.com/pdf_document_format.html)
       + [Word document options (but please do not use Word output for this class!)](http://rmarkdown.rstudio.com/word_document_format.html)
   * [Useful RStudio cheatsheets on R Markdown, RStudio shortcuts, etc.](https://www.rstudio.com/resources/cheatsheets/)
   * [Information on the `prettydoc` package](https://yixuan.cos.name/prettydoc/cayman.html) for nicer looking RMarkdown themes
   * [`pander` documentation](http://rapporter.github.io/pander/) for making tables, etc.
   * [Shapes and line types](http://www.cookbook-r.com/Graphs/Shapes_and_line_types/) in base R
   * [Color names (PDF)](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf) in base R
   
2. Visualizing Data

   * [Slides for week 2: Plotting with `ggplot2`](https://clanfear.github.io/CSSS508/Lectures/Week2/CSSS508_Week2_GGPlot2.html)
       + [Rmd for week 2 slides](https://clanfear.github.io/CSSS508/Lectures/Week2/CSSS508_Week2_GGPlot2.Rpres)
   * [Lecture Video for Week 2](https://youtu.be/eJuWqsj8K5A)
   * Homework 2: Due at 11:59PM on April 10th
       + [Homework 2 Instructions](https://clanfear.github.io/CSSS508/Homework/HW2/homework_2.html)
       + Homework 2 Key: HTML, RMD
   * Reading: **[Visualization chapter in R for Data Science](http://r4ds.had.co.nz/data-visualisation.html)**
   * [`ggplot2` documentation](http://docs.ggplot2.org/current/)
   * [`ggplot2` Cheat Sheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf)
   * [Cookbook for R graph reference](http://www.cookbook-r.com/Graphs/)
   * [R graph catalog at UBC](http://shiny.stat.ubc.ca/r-graph-catalog/)
   * `ggplot2` add-ons
       + `ggthemes` package
       + `cowplot` package for publication ready graphs, multiple plots in single image, etc.
       + `gganimate` for easy animations (saving GIFs requires ImageMagick or GraphicsMagick)
   * [Hadley Wickham on the grammar of graphics](http://vita.had.co.nz/papers/layered-grammar.html)
   * [Tufte in R](http://motioninsocial.com/tufte/) (if that's your sort of thing)

3. Manipulating and Summarizing Data

   * [Slides for week 3: Manipulating and summarizing data with `dplyr`](https://clanfear.github.io/CSSS508/Lectures/Week3/CSSS508_Week3_dplyr.html)
       + [Rmd for week 3 slides](https://clanfear.github.io/CSSS508/Lectures/Week3/CSSS508_Week3_dplyr.Rpres)
   * [Lecture Video for Week 3](https://youtu.be/-jCMNTUUmJI)
   * Homework 3: Due at 11:59PM on April 17th
       + [Homework 3 Instructions](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW3/homework_3.html)
       + Homework 3 Key: HTML, RMD
       + [nycflights13 documentation](https://cran.r-project.org/web/packages/nycflights13/nycflights13.pdf)
   * Reading: **[Data Transformation chapter in R for Data Science](http://r4ds.had.co.nz/transform.html)**
   * [A cautionary tale about Excel](http://www.bloomberg.com/news/articles/2013-04-18/faq-reinhart-rogoff-and-the-excel-error-that-changed-history)
   * `dplyr` stuff:
       + [`dplyr` cheatsheets](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) with diagrams to help you remember functions
       + [Introduction to `dplyr`](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
       + [Window functions in `dplyr`](https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html)
       + [Joining data in `dplyr`](https://cran.rstudio.com/web/packages/dplyr/vignettes/two-table.html)
       + More advanced joins: [`sqldf` for easy SQL in R](https://cran.r-project.org/web/packages/sqldf/index.html)
   
4. Understanding R Data Structures

   * [Slides for week 4: R data structures](https://clanfear.github.io/CSSS508/Lectures/Week4/CSSS508_week4_data_structures.html)
       + [R code for week 4 slides](https://clanfear.github.io/CSSS508/Lectures/Week4/CSSS508_week4_data_structures.Rpres)
   * [Lecture Video for Week 4](https://youtu.be/giD90SP7r64)
   * Homework 4 (two options, complete one): Due at 11:59PM on April 24th
       + Homework 4: R Data Structures (Less Advanced)
           * [Homework 4: R Data Structures, R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW4/homework_4.Rmd) (you will download this, fill in and submit on Canvas)
           * [Homework 4: R Data Structures, HTML Document](https://clanfear.github.io/CSSS508/Homework/HW4/homework_4.html)
           * Homework 4: Data Structures, Key: HTML, RMD
       + Homework 4: Linear Regression (More Advanced)
           * [Homework 4: Linear Regression, R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW4_regression/HW4_regression.Rmd) (you will download this, fill in and submit on Canvas)
           * [Homework 4: Linear Regression, HTML Document](https://clanfear.github.io/CSSS508/Homework/HW4_regression/HW4_regression.html)
           * Homework 4: Linear Regression, Key: HTML, RMD
   * [Setting up swirl for practice](http://swirlstats.com/students.html)
   * Reading: **[Data Structures chapter in Advanced R](http://adv-r.had.co.nz/Data-structures.html)**

5. Importing, Exporting, and Cleaning Data
   * [Slides for Week 5: Data import, export, and cleaning](https://clanfear.github.io/CSSS508/Lectures/Week5/CSSS508_week5_data_import_export_cleaning.html)
       + [R code in week 5 slides](https://clanfear.github.io/CSSS508/Lectures/Week5/CSSS508_week5_data_import_export_cleaning.Rpres)
   * [Lecture Video for Week 5](https://youtu.be/9zObKNltIlw)
   * Homework 5, Part 1 due at 11:59 PM on May 1st
       + [Homework 5: R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW5/homework_5.Rmd) (you will download this, fill in and submit on Canvas)
       + [Homework 5: HTML Document](https://clanfear.github.io/CSSS508/Homework/HW5/homework_5.html)
       + Homework 5, Part 1 Key: HTML, RMD
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
       
6. Using Loops
   * Slides for week 6: Looping with for() loops
       + R code in week 6 slides
   * Lecture Video for Week 6
   * Homework 5, Part 2 due at 11:59 PM on May 8th
       + Homework 5: R Markdown template (you will download this, fill in and submit on Canvas)
       + Homework 5: HTML Document
       + Homework 5, Part 2 Key: HTML, RMD
   
7. Writing Functions
   * Slides for week 7: Vectorization and writing functions
       + R code in week 7 slides
   * Lecture Video for Week 7
   * Homework 6: Part 1 due at 11:59 PM on May 15th
       + Homework 6: R Markdown template
       + Pronto! bike share data from fall 2014 through fall 2015
       + Homework 6, Part 1 Key: HTML, RMD
   * The R Inferno by Patrick Burns [PDF]: "Circles" 2, 3, and 4 are relevant after this week's material, and Circle 8 covers a lot of miscellaneous R weird things that may trip you up.
   * Reference material on writing functions with lots of examples
   * Code style guide for writing functions, etc.
   * R, the master troll of statistical languages (to read if you feel a bit frustrated!)

8.  Working with Text Data
   * Slides for week 8: Working with strings and character data
       + R code in week 8 slides
   * Lecture Video for Week 8
       + Homework 6: Part 2 due at 11:59 PM on May 22nd
       + Homework 6, Part 2 Key: HTML, RMD
   * Data In-Class:
       + Seattle restaurant inspection data from King County, cleaned.
       + Data source, King County
   * RStudio Cheat Sheet for Strings
   * stringr vignette
   * Site for regular expression testing with a good cheatsheet and hover explanations
   * Blog post explaining paste for combining strings
   
9. Working with Geographical Data
   * Slides for week 9: Mapping and labels in ggplot2
       + R code in week 9 slides
   * Lecture Video for Week 9
   * Optional Homework 7: Due at 11:59 PM on May 29
       + Homework 7: R Markdown template
       + Homework 7: HTML File
       + Seattle restaurant inspection data since 2012 (CSV, about 16 MB) from King County
       + Homework 7 Key: HTML, RMD [Posted after HW7]
   * Suggested text: Applied Spatial Data Analysis with R by Bivand et al.
   * ggmap package examples
   * More in depth ggmap examples
   * ggrepel package vignette

10. Working with Model Results
   * Slides for Lecture 11: Tidy Model Results and Applied Data Cleaning
       + R code in week 11 slides
   * Lecture Video for Week 11
   * broom vignette
   * ggeffects vignette
   * sjPlot home page
   * Overleaf online LaTeX editor

11. Reproducibility and Best Practices
   * Slides for Lecture 12: Reproducibility and Best Practices
   * Reading: [Good Enough Practices in Scientific Computing](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510)
   * R Packages:
      + [`huskydown`](https://github.com/benmarwick/huskydown)
      + [`rrtools`](https://github.com/benmarwick/rrtools)

12. Working with Social Media Data (A bit out of date)
   * Slides for Lecture 12: Social media and text mining
       + R code in week 10 slides
   * Lecture Video for Week 10
   * Twitter Apps portal
   * Fabulous analysis of Trump tweets using R
   * Absolute Beginner's Guide to SocialMediaLab
   * Static and Dynamic Network Visualizations with R
   * rvest for harvesting web data:
   * SelectorGadget for getting tags
   * Good demo on State of the Union speeches by Jerid Francom
   * Another demo pulling Superbowl scores by David Radcliffe
   * tm package for text mining:
   * tm vignette
   * Slides by Yanchang Zhao on tm and Twitter data
   * tidytext for tidy text analysis
   * quanteda package for another set of tools
   * Social media data extraction tools:
   * twitteR package for accessing Twitter in R
   * Setting up API keys and secrets
   * twitteR functions
   * streamR for the streaming Twitter API
   * Rfacebook
   * Shiny for interactive R apps

This project is maintained by [clanfear](https://github.com/clanfear) and based on material from [rebeccaferrell](https://github.com/rebeccaferrell) with permission.