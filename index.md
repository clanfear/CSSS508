---
layout: default
---

Welcome to CSSS 508: Introduction to R for Social Scientists

University of Washington, Spring 2018

Instructor: [Charles Lanfear](mailto:clanfear@uw.edu), PhD student, UW Sociology

## Important Links

* [Canvas page for course (enrolled students only)](https://canvas.uw.edu/courses/1219583)
* [Syllabus](https://clanfear.github.io/CSSS508/docs/syllabus.html)
* [Homework Instructions](https://clanfear.github.io/CSSS508/docs/homework.html) and grading rubric.
* [Peer Review Instructions](https://clanfear.github.io/CSSS508/docs/peer_review.html) and suggestions for reading code.

## Helpful resources:

* [R for Data Science online](http://r4ds.had.co.nz/) textbook by Garrett Grolemund and Hadley Wickham. One of many good R texts available, but importantly it is free and focuses on the [tidyverse](http://tidyverse.org/) collection of R packages which form the backbone of this course.
* [Advanced R](http://adv-r.had.co.nz/) online textbook by Hadley Wickham. A great source for more in-depth and advanced R programming.
* [DataCamp for CSSS508](https://www.datacamp.com/enterprise/csss508-introduction-to-r-for-social-scientists/): Interactive R tutorials provided free of charge to registered CSSS508 students by DataCamp.
* [Jenny Bryan's materials for STAT545 at UBC](Jenny Bryan's materials for STAT545 at UBC). CSSS508 is partly based on Rebecca Ferrell's abbreviated version of Bryan's course, so more explanations can be found on her page.
* [Instructions for using RStudio in the CSSCR lab](https://clanfear.github.io/CSSS508/docs/CSSCR.html) (hopefully week 1 only; I would prefer you become comfortable using your own computers!)

## Weekly lecture notes and links:

1. RStudio and Markdown
   * [Slides for week 1: Course logistics, R/RStudio, making R Markdown documents](https://clanfear.github.io/CSSS508/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.html)
       + [R code for Week 1 slides](https://clanfear.github.io/CSSS508/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.Rmd)
   * [Lecture Video for Week 1](https://youtu.be/iLqvlSgiO6c)
   * Homework 1: Due at 11:59PM on October 2nd
       + [Homework 1](https://clanfear.github.io/CSSS508/Homework/HW1/homework_1.html)
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

   * Slides for week 2: Plotting with ggplot2
       + R code for week 2 slides
   * Lecture Video for Week 2
   * Homework 2: Due at 11:59PM on April 10th
       + Homework 2
       + Homework 2 Key: HTML, RMD
   * Visualization chapter in R for Data Science
   * ggplot2 documentation
   * ggplot2 Cheat Sheet
   * Cookbook for R graph reference
   * R graph catalog at UBC
   * ggthemes package
   * cowplot package for publication ready graphs, multiple plots in single image, etc.
   * gganimate for easy animations (saving GIFs requires ImageMagick or GraphicsMagick)
   * Hadley Wickham on the grammar of graphics
   * Tufte in R (if that's your sort of thing)
   * Caption demonstration with gridExtra or R Markdown

3. Manipulating and Summarizing Data

   * Slides for week 3: Manipulating and summarizing data with dplyr
       + R code for week 3 slides
   * Lecture Video for Week 3
   * Homework 3: Due at 11:59PM on April 17th
       + Homework 3
       + Homework 3 Key: HTML, RMD
   * Data Transformation chapter in R for Data Science
   * A cautionary tale about Excel
   * dplyr stuff:
       + dplyr cheatsheets with diagrams to help you remember functions
       + Introduction to dplyr
       + Window functions in dplyr
       + Joining data in dplyr
       + More advanced joins: sqldf for easy SQL in R
   * nycflights13 documentation
   
4. Understanding R Data Structures

   * Slides for week 4: R data structures
       + R code for week 4 slides
   * Lecture Video for Week 4
   * Homework 4 (two options, complete one): Due at 11:59PM on April 24th
       + Homework 4: R Data Structures (Less Advanced)
           * Homework 4: R Data Structures, HTML Document
           * Homework 4: R Data Structures, R Markdown template (you will download this, fill in and submit on Canvas)
           * Homework 4: Data Structures, Key: HTML, RMD
       + Homework 4: Linear Regression (More Advanced)
           * Homework 4: Linear Regression, HTML Document
           * Homework 4: Linear Regression, R Markdown template (you will download this, fill in and submit on Canvas)
           * Homework 4: Linear Regression, Key: HTML, RMD
   * Setting up swirl for practice
   * Data Structures chapter in Advanced R

5. Importing, Exporting, and Cleaning Data
   * Slides for week 5: data import, export, and cleaning with readr, tidyr, and lubridate
       + R code in week 5 slides
   * Lecture Video for Week 5
   * Homework 5, Part 1 due at 11:59 PM on May 1st
       + Homework 5: HTML Document
       + Homework 5: R Markdown template (you will download this, fill in and submit on Canvas)
       + Homework 5, Part 1 Key: HTML, RMD
   * 2016 general election voting data for King County (60 MB download; save, don't load in browser!)
   * Data in-class:
       + Billboard Hot 100 data from 2000
       + One day of Seattle Police Department incident data
   * Data import and export:
       + readr documentation
       + Column types in readr
       + Using dput when asking for help
       + readxl and openxlsx packages for Excel
   * General data access and cleaning:
       + New York Times article on "data janitor" work
       + Quartz guide to bad data: a must read!
       + Lots of resources on survey data sources and analysis in R
       + rOpenSci (many packages for accessing particular data sources in R)
       + Qualtrics API package and Rmonkey for Survey Monkey
   * Tidying:
       + tidyr vignette
       + Tidy genomics (a walkthough of tidy data preparation and analysis)
   * Dates and times:
       + lubridate vignette
   * Factors:
       + Lots on factors from Jenny Bryan
       
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