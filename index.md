---
layout: default
---

# CSSS 508
## Introduction to R for Social Scientists
### University of Washington

## Important links

* [Zoom Meeting for Lectures](https://washington.zoom.us/j/848704242)
* [Canvas Page (enrolled students only)](https://canvas.uw.edu/courses/1272898)
* [Syllabus](https://clanfear.github.io/CSSS508/docs/syllabus.html)
* [Homework Instructions](https://clanfear.github.io/CSSS508/docs/homework.html) and grading rubric.
* [Peer Review Instructions](https://clanfear.github.io/CSSS508/docs/peer_review.html) and suggestions for reading code.
* [Class Mailing List](mailto:csss508a_sp21@uw.edu)
* [Class Slack Channel](https://uwcsss508.slack.com/)
* [R and RStudio Installation Instructions](https://clanfear.github.io/CSSS508/docs/installation.html)
* [Enabling compilation of packages](https://clanfear.github.io/CSSS508/docs/compiling.html)
* [How to Read an R Help Page](https://socviz.co/appendix.html#a-little-more-about-r)

## Helpful resources:

* [R for Data Science online](http://r4ds.had.co.nz/) textbook by Garrett Grolemund and Hadley Wickham. One of many good R texts available, but importantly it is free and focuses on the [`tidyverse`](http://tidyverse.org/) collection of R packages which form the backbone of this course.
* [Advanced R](http://adv-r.had.co.nz/) online textbook by Hadley Wickham. A great source for more in-depth and advanced R programming.
* [Introduction to R Workshop](https://youtu.be/HbFaPArTIjo), recorded Oct. 11, 2018, with [companion webpage](https://clanfear.github.io/Intro_R_Workshop/).
* [Intermediate R Workshop](https://youtu.be/pSWaOOniVBk), recorded Jan. 31, 2019, with [companion webpage](https://clanfear.github.io/Intermediate_R_Workshop/).
* [What They Forgot to Teach You About R](https://whattheyforgot.org/) by Jenny Bryan and Jim Hester. Great information on best practices for managing projects and R itself.
* [Teacups, Giraffes, and Statistics](https://tinystats.github.io/teacups-giraffes-and-statistics/index.html), an illustrated and interactive introduction to R and statistics.
* [The Epidemiologist R Handbook](https://epirhandbook.com/index.html), an online textbook introducing modern R approaches for epidemiology.

## Weekly lecture notes and links:

### 1. RStudio and R Markdown
   * [Slides for Lecture 1: Course logistics, R/RStudio, and R Markdown](https://clanfear.github.io/CSSS508/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.html)
       + [R Script for Lecture 1 slides](https://raw.githubusercontent.com/clanfear/CSSS508/master/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.R)
       + [PDF of Lecture 1 slides](https://clanfear.github.io/CSSS508/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.pdf)
       + [Rmd for Lecture 1 slides](https://raw.githubusercontent.com/clanfear/CSSS508/master/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.Rmd)
   * Lecture Video for Lecture 1, recorded March 31st, 2021
       + [Zoom](https://washington.zoom.us/rec/share/FCZbVGlYad-_zZno5wCnCvC2FiHPHiZil75GAcg2LTmUEVzhxLO2dULpdyfppCsp.eKhSOgBPu3IvNQrd?startTime=1617229639000)
       + [YouTube](https://youtu.be/rATB_Rb96Cc)
   * Homework 1:
       + [Homework 1 Instructions](https://clanfear.github.io/CSSS508/Homework/HW1/homework_1.html)
       + Homework 1 Example #1: [HTML](Keys/HW1_Keys/homework_1_key_1.html) , [RMD](Keys/HW1_Keys/homework_1_key_1.Rmd)
       + Homework 1 Example #2: [HTML](Keys/HW1_Keys/homework_1_key_2.html), [RMD](Keys/HW1_Keys/homework_1_key_2.Rmd)
       + Lab 1 Video: [Zoom](https://washington.zoom.us/rec/share/JttdIjmfBWO6yXgSHlVeXXDpxDZDYXL8VXnwvr9auRGlkD43oYFzfCFUJMWY5hOC.fMey0jcfiBuVrx9L?startTime=1601936998000), [YouTube](https://youtu.be/ybAedC9T7ys)
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
   * [Slides for Lecture 2: Plotting with `ggplot2`](https://clanfear.github.io/CSSS508/Lectures/Week2/CSSS508_Week2_ggplot2.html)
       + [R Script for Lecture 2 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week2/CSSS508_Week2_ggplot2.R)
       + [PDF of Lecture 2 slides](https://clanfear.github.io/CSSS508/Lectures/Week2/CSSS508_Week2_ggplot2.pdf)
       + [Rmd for Lecture 2 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week2/CSSS508_Week2_ggplot2.Rmd)
   * Lecture Video for Lecture 2, recorded April 7th, 2021
       + [Zoom](https://washington.zoom.us/rec/share/cWgRZvLkZ7T6JiscanOwHb7le8n1LNpCm2eKlf-ebOd8hnuE6ouRS5lFqQe9VtSs.q0owwo12HTmQ5As2)
       + [YouTube](https://youtu.be/CvHwQb25NZQ)
   * Homework 2:
       + [Homework 2 Instructions](https://clanfear.github.io/CSSS508/Homework/HW2/homework_2.html)
       + Homework 2 Example: [HTML](Keys/HW2_Keys/homework_2_key_1.html), [RMD](Keys/HW2_Keys/homework_2_key_1.Rmd)
       + Lab 2 Video: [Zoom](https://washington.zoom.us/rec/share/QDHNSElYpz1784iyaw6FNDfYyhvaPVbImL4_GZ7mASQkHZFEYnxDq8XyrvdKBkcr.qbRNmrFcPHl8iArN), [YouTube](https://www.youtube.com/watch?v=RhyVKggSmMY)
   * Reading: **[Visualization chapter in R for Data Science](http://r4ds.had.co.nz/data-visualisation.html)**
   * [`ggplot2` Website](https://ggplot2.tidyverse.org/)
   * [`ggplot2` Cheat Sheet](https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf)
   * [The ggplot Flipbook](https://evamaerey.github.io/ggplot_flipbook/ggplot_flipbook_xaringan.html) by [Gina Reynolds](https://github.com/EvaMaeRey)
   * [Cookbook for R graph reference](http://www.cookbook-r.com/Graphs/)
   * [R graph catalog at UBC](http://shiny.stat.ubc.ca/r-graph-catalog/)
   * `ggplot2` add-ons
       + [`ggthemes` package](https://github.com/jrnold/ggthemes)
       + [`cowplot` package](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html) for publication ready graphs, multiple plots in single image, etc.
       + [`gganimate` package](https://github.com/dgrtwo/gganimate) for easy animations (saving GIFs requires [ImageMagick](https://www.imagemagick.org/script/index.php) or [GraphicsMagick](http://www.graphicsmagick.org/))
   * [Hadley Wickham on the grammar of graphics](http://vita.had.co.nz/papers/layered-grammar.html)
   * [Tufte in R](http://motioninsocial.com/tufte/) (if that's your sort of thing)
   * Recommended text: [Data Visualization: A Practical Introduction](https://kieranhealy.org/publications/dataviz/) by Kieran Healy

### 3. Manipulating and Summarizing Data
   * [Slides for Lecture 3: Manipulating and summarizing data with `dplyr`](https://clanfear.github.io/CSSS508/Lectures/Week3/CSSS508_Week3_dplyr.html)
       + [R Script for Lecture 3 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week3/CSSS508_Week3_dplyr.R)
       + [PDF of Lecture 3 slides](https://clanfear.github.io/CSSS508/Lectures/Week3/CSSS508_Week3_dplyr.pdf)
       + [Rmd for Lecture 3 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week3/CSSS508_Week3_dplyr.Rmd)
   * Lecture Video for Lecture 3, recorded April 14th, 2021
       + [Zoom](https://washington.zoom.us/rec/share/TiLXSn538pm9iBphYyW_Eqh2Km_FBBcGyKfqB2TY2rvn-GkKlsKvLCKeOQZ8DGBG.YY8AGaKqZaviZ_M0)
       + [YouTube](https://youtu.be/119PCaj0wyA)
   * Homework 3:
       + [Homework 3 Instructions](https://clanfear.github.io/CSSS508/Homework/HW3/homework_3.html)
       + [nycflights13 documentation](https://cran.r-project.org/web/packages/nycflights13/nycflights13.pdf)
       + Homework 3 Example: HTML, RMD
       + Lab 3 Video: [Zoom](https://washington.zoom.us/rec/share/1zkVUYZ5GrKHCiU2KiH9JOku7gKWXMw8xzaBxV6bI9Y3o-WzmhnV_byb5swlNc0.Iuby5s1GBHtyjTWh), [YouTube](https://youtu.be/fQ2x1bMH1a0)
   * Reading: **[Data Transformation chapter in R for Data Science](http://r4ds.had.co.nz/transform.html)**
   * [A cautionary tale about Excel](http://www.bloomberg.com/news/articles/2013-04-18/faq-reinhart-rogoff-and-the-excel-error-that-changed-history)
   * `dplyr` stuff:
       + [`dplyr` cheatsheets](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) with diagrams to help you remember functions
       + [Introduction to `dplyr`](https://cran.rstudio.com/web/packages/dplyr/vignettes/dplyr.html)
       + [Window functions in `dplyr`](https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html)
       + [Joining data in `dplyr`](https://cran.rstudio.com/web/packages/dplyr/vignettes/two-table.html)
       + More advanced joins: [`sqldf` for easy SQL in R](https://cran.r-project.org/web/packages/sqldf/index.html)
   
### 4. Understanding R Data Structures
   * [Slides for Lecture 4: R data structures](https://clanfear.github.io/CSSS508/Lectures/Week4/CSSS508_Week4_data_structures.html)
       + [R Script for Lecture 4 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week4/CSSS508_Week4_data_structures.R)
       + [PDF of Lecture 4 slides](https://clanfear.github.io/CSSS508/Lectures/Week4/CSSS508_Week4_data_structures.pdf)
       + [Rmd for Lecture 4 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week4/CSSS508_Week4_data_structures.Rmd)
   * Lecture Video for Lecture 4, recorded April 21st, 2021
       + [Zoom](https://washington.zoom.us/rec/share/TW1krQYmrWCpPD8zjlaiYD52LUkKayP3roulNdWdJMwWKqXWsTuKokInyqYJtxoW.KFWQFoU9F8dhG5D0)
       + [YouTube](https://youtu.be/2-zBRkY3nQQ)
   * Homework 4 (two options, complete one):
       + Homework 4: R Data Structures (Less Advanced)
           * [Homework 4: R Data Structures, R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW4/homework_4.Rmd) (you will download this, fill in and submit on Canvas)
           * [Homework 4: R Data Structures, HTML Document](https://clanfear.github.io/CSSS508/Homework/HW4/homework_4.html)
           * Homework 4: Data Structures, Key: [HTML](https://clanfear.github.io/CSSS508/Keys/HW4_Keys/homework_4_key.html), [RMD](https://clanfear.github.io/CSSS508/Keys/HW4_Keys/homework_4_key.Rmd)
       + Homework 4: Linear Regression (More Advanced)
           * [Homework 4: Linear Regression, R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW4_regression/HW4_regression.Rmd) (you will download this, fill in and submit on Canvas)
           * [Homework 4: Linear Regression, HTML Document](https://clanfear.github.io/CSSS508/Homework/HW4_regression/HW4_regression.html)
           * Homework 4: Linear Regression, Key: [HTML](https://clanfear.github.io/CSSS508/Keys/HW4_Keys/homework_4_regression_key.html), [RMD](https://clanfear.github.io/CSSS508/Keys/HW4_Keys/homework_4_regression_key.Rmd)
       + Lab 4 Video: [Zoom](https://washington.zoom.us/rec/share/a-Ecjzv9qjF9TMocXRyaq4eMrZrHLdFdknhX1DtROq5gkfcOicU_vwcHns3sS9mZ.0NV8Z8KSfmCTpzh7?startTime=1603751226000), [YouTube](https://youtu.be/LwPXDVpZFKk)
   * [Setting up swirl for practice](http://swirlstats.com/students.html)
   * Reading: **[Data Structures chapter in Advanced R](http://adv-r.had.co.nz/Data-structures.html)**

### 5. Importing, Exporting, and Cleaning Data
   * [Slides for Lecture 5: Data import, export, and cleaning](https://clanfear.github.io/CSSS508/Lectures/Week5/CSSS508_Week5_data_import_export_cleaning.html)
       + [R Script for Lecture 5 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week5/CSSS508_Week5_data_import_export_cleaning.R)
       + [PDF of Lecture 5 slides](https://clanfear.github.io/CSSS508/Lectures/Week5/CSSS508_Week5_data_import_export_cleaning.pdf)
       + [Rmd for Lecture 5 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week5/CSSS508_Week5_data_import_export_cleaning.Rmd)
   * Lecture Video for Lecture 5, recorded April 28th, 2021
       + [Zoom](https://washington.zoom.us/rec/share/264a1a8XrIlkA3Okp_EI0CFzdohKpT4rZhhtpTCPbIjA0hJMaJjkmIkvFbR03HI.KUYc2TvqkDib8vq9)
       + [YouTube](https://www.youtube.com/watch?v=IZjeq70hNSs)
   * Homework 5, Part 1:
       + [Homework 5: R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW5/homework_5.Rmd) (you will download this, fill in and submit on Canvas)
       + [Homework 5: HTML Document](https://clanfear.github.io/CSSS508/Homework/HW5/homework_5.html)
           * Homework 5, Part 1: Key: [HTML](https://clanfear.github.io/CSSS508/Keys/HW5_Keys/homework_5_p1_key.html), [RMD](https://raw.githubusercontent.com/clanfear/CSSS508/master/Keys/HW5_Keys/homework_5_p1_key.Rmd)
       + [2016 general election voting data for King County](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW5/king_county_elections_2016.txt) (60 MB download; save, *don't load in browser*!)
       + Lab 5 Video: [Zoom](https://washington.zoom.us/rec/share/4X97iuNKSfom2Og-jfeX8UP_t5vEjZRlFf8P216d1WCAQ_NEmBN7tJN8bo_zGRAd.OxvNe_et9V18U5QM?startTime=1620080961000), [YouTube](https://youtu.be/hgW-K9GcZ04)
   * Data in-class:
       + [Billboard Hot 100 data from 2000](https://clanfear.github.io/CSSS508/Lectures/Week5/data/billboard.csv)
       + [One day of Seattle Police Department incident data](https://raw.githubusercontent.com/clanfear/CSSS508/master/Seattle_Police_Department_911_Incident_Response.csv)
   * Data import and export:
       + [`readr` documentation](https://cran.r-project.org/web/packages/readr/readr.pdf)
       + [Column types in readr](https://cran.r-project.org/web/packages/readr/vignettes/column-types.html)
       + [Using `dput()` when asking for help](http://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example)
       + [`readxl`](https://readxl.tidyverse.org/) and [`writexl`](https://docs.ropensci.org/writexl/) packages for Excel
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
   * [Slides for Lecture 6: Loops](http://clanfear.github.io/CSSS508/Lectures/Week6/CSSS508_Week6_loops.html)
       + [R script for Lecture 6 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week6/CSSS508_Week6_loops.R)
       + [PDF of Lecture 6 slides](http://clanfear.github.io/CSSS508/Lectures/Week6/CSSS508_Week6_loops.pdf)
       + [Rmd for Lecture 6 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week6/CSSS508_Week6_loops.Rmd)
   * Lecture Video for Lecture 6, recorded May 5th, 2021
       + [Zoom](https://washington.zoom.us/rec/share/EDO-YKST1AG0FUaaowxiwjnZq0y1j0SbAbQDJeKOz2bd1dUtfzU2bWCQ5HPlATvi.v3YWALS_emWaQ-5q)
       + [YouTube](https://youtu.be/4BqFNMQzLE4)
   * Homework 5, Part 2:
       + [Homework 5, Part 2: R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Keys/HW5_Keys/homework_5_p1_key.Rmd) (you will download this, fill in and submit on Canvas)
       + [Homework 5, Part 2: HTML Document](https://clanfear.github.io/CSSS508/Keys/HW5_Keys/homework_5_p1_key.html)
       + Homework 5, Part 2 Key: [HTML](https://clanfear.github.io/CSSS508/Keys/HW5_Keys/homework_5_p2_key.html), [RMD](https://raw.githubusercontent.com/clanfear/CSSS508/master/Keys/HW5_Keys/homework_5_p2_key.Rmd)
   
### 7. Writing Functions
   * [Slides for Lecture 7: Vectorization and writing functions](http://clanfear.github.io/CSSS508/Lectures/Week7/CSSS508_Week7_vectorization.html)
       + [R script for Lecture 7 slides](http://clanfear.github.io/CSSS508/Lectures/Week7/CSSS508_Week7_vectorization.R)
       + [PDF of Lecture 7 slides](http://clanfear.github.io/CSSS508/Lectures/Week7/CSSS508_Week7_vectorization.pdf)
       + [Rmd for Lecture 7 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week7/CSSS508_Week7_vectorization.Rmd)
   * Lecture Video for Lecture 7, recorded May 12th, 2021
       + [Zoom](https://washington.zoom.us/rec/share/XgXwNj-vI7i_lpiIBuB_1BEFulFbxbDCPQSSgHuvI7WlJzKyE_c9vCgUYJyFI2vm.2CVmfEtvjkHGmDXV?startTime=1620858604000)
       + [YouTube](https://youtu.be/Qq1VFydPlNw)
   * Homework 6, Part 1:
       + [Homework 6, Part 1: R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW6/homework_6.Rmd)
       + [Pronto! bike share data from fall 2014 through fall 2015](https://s3.amazonaws.com/pronto-data/open_data_year_one.zip)
       + Homework 6, Part 1 Key: [HTML](https://clanfear.github.io/CSSS508/Keys/HW6_Keys/homework_6_p1_key.html), [RMD](https://raw.githubusercontent.com/clanfear/CSSS508/master/Keys/HW6_Keys/homework_6_p1_key.Rmd)
   * [The R Inferno by Patrick Burns [PDF]](http://www.burns-stat.com/pages/Tutor/R_inferno.pdf): "Circles" 2, 3, and 4 are relevant after this week's material, and Circle 8 covers a lot of miscellaneous R weird things that may trip you up.
   * [Reference material on writing functions](http://r4ds.had.co.nz/functions.html) with lots of examples
   * [Code style guide](http://adv-r.had.co.nz/Style.html) for writing functions, etc.
   * [R, the master troll of statistical languages](http://www.talyarkoni.org/blog/2012/06/08/r-the-master-troll-of-statistical-languages/) (to read if you feel a bit frustrated!)
   * [Tutorial on `purrr` ](https://jennybc.github.io/purrr-tutorial/) for vectorization by Jenny Bryan.

### 8.  Working with Text Data
   * [Slides for Lecture 8: Working with strings and character data](http://clanfear.github.io/CSSS508/Lectures/Week8/CSSS508_Week8_strings.html)
       + [R script for Lecture 8 slides](http://clanfear.github.io/CSSS508/Lectures/Week8/CSSS508_Week8_strings.R)
       + [PDF of Lecture 8 slides](http://clanfear.github.io/CSSS508/Lectures/Week8/CSSS508_Week8_strings.pdf)
       + [Rmd for Lecture 8 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week8/CSSS508_Week8_strings.Rmd)
   * Lecture Video for Lecture 8, recorded May 19th, 2021
       + [Zoom](https://washington.zoom.us/rec/share/RG_UitXYFfU00tqHVlNSPTeV2wqa6wolw_vGXyToBCreuQM2SITL7Dda5XLRYmI0.g3BUk2B5JkbyTHpm?startTime=1621463290000)
       + [YouTube](https://youtu.be/cfLXurY-hQ0)
   * Homework 6, Part 2:
       + Homework 6, Part 2: [RMD](https://raw.githubusercontent.com/clanfear/CSSS508/master/Keys/HW6_Keys/homework_6_p1_key.Rmd)
       + Homework 6, Part 2 Key: HTML, RMD
   * Data In-Class:
       + [Seattle restaurant inspection data from King County, cleaned.](http://clanfear.github.io/CSSS508/Lectures/Week8/restaurants.Rdata)
       + [Data source, King County](https://data.kingcounty.gov/Health/Food-Establishment-Inspection-Data/f29f-zza5)
   * [RStudio Cheat Sheet for Strings](https://github.com/rstudio/cheatsheets/raw/master/strings.pdf)
   * [`stringr` vignette](https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html)
   * [Site for regular expression testing](http://regexr.com/)  with a good cheatsheet and hover explanations
   * [Blog post explaining `paste()`](https://trinkerrstuff.wordpress.com/2013/09/15/paste-paste0-and-sprintf-2) for combining strings
   
### 9. Working with Geographical Data
   * [Slides for Lecture 9: Mapping with `ggplot2` and `sf`](http://clanfear.github.io/CSSS508/Lectures/Week9/CSSS508_Week9_mapping.html)
       + [R script for Lecture 9 slides](http://clanfear.github.io/CSSS508/Lectures/Week9/CSSS508_Week9_mapping.R)
       + [PDF of Lecture 9 slides](http://clanfear.github.io/CSSS508/Lectures/Week9/CSSS508_Week9_mapping.pdf)
       + [Rmd for Lecture 9 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week9/CSSS508_Week9_mapping.Rmd)
   * Lecture Video for Lecture 9, recorded May 26th, 2021
       + [Zoom](https://washington.zoom.us/rec/share/ask1E_JbcyCvCGHaVxfqKgXW4bByEw7afZJIGFAngaobHxfSVKUYSubrqAXMyqc8.8_Lw8u_nDrimg4Z0)
       + [YouTube](https://youtu.be/EWQomHf6GJ0)
   * Optional Homework 7:
       + [Homework 7: R Markdown template](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW7/homework_7.Rmd)
       + [Homework 7: HTML File](http://clanfear.github.io/CSSS508/Homework/HW7/homework_7.html)
       + [Seattle restaurant inspection data since 2012](http://clanfear.github.io/CSSS508/Lectures/Week8/restaurants.Rdata) (Rdata file) from King County
       + Homework 7 Key: [RMD](https://raw.githubusercontent.com/clanfear/CSSS508/master/Homework/HW7/homework_7_key.Rmd), [HTML](http://clanfear.github.io/CSSS508/Homework/HW7/homework_7.html)
   * Suggested text: [Applied Spatial Data Analysis with R](http://www.springer.com/us/book/9781461476177)  by Bivand et al.
   * [RSpatial.org](http://www.rspatial.org/index.html): Massive resource for spatial analysis in R
   * [`ggmap` package examples](https://github.com/dkahle/ggmap)
   * [More in depth `ggmap` examples](http://vita.had.co.nz/papers/ggmap.pdf)
   * [`ggrepel` package vignette](https://cran.r-project.org/web/packages/ggrepel/vignettes/ggrepel.html)
   * [`sf` Vignette: Overview](https://cran.r-project.org/web/packages/sf/vignettes/sf1.html)
   * [`sf` Home Page](https://r-spatial.github.io/sf/)
   * [Tyler Morgan Wall's 3D Mapping and Visualization Masterclass](https://github.com/tylermorganwall/MusaMasterclass)

### 10. Reproducibility and Model Results
   * [Slides for Lecture 10: Reproducibility and model results](http://clanfear.github.io/CSSS508/Lectures/Week10/CSSS508_Week10_reproducibility_and_model_results.html)
      + [PDF of Lecture 10 slides](http://clanfear.github.io/CSSS508/Lectures/Week10/CSSS508_Week10_reproducibility_and_model_results.pdf)
      + [Rmd for Lecture 10 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week10/CSSS508_Week10_reproducibility_and_model_results.Rmd)
   * Lecture Video for Week 10, recorded December 9th, 2020
       + [Zoom](https://washington.zoom.us/rec/share/a1simgomwoMiNz5E3DrthXmGNW3fncEi3o89lR8MmWjbniVhMj3A90wxnFJjYQGP.w4bsxphxQ1rbLl78?startTime=1607556423000)
       + [YouTube](https://youtu.be/yTV5hzzaMfM)
   * Reading: [Good Enough Practices in Scientific Computing](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005510)
   * [Initial Steps Toward Reproducible Research](https://kbroman.org/steps2rr/) by Karl Broman
   * [The Plain Person's Guide to Plain Text Social Science](http://plain-text.co) by Kieran Healy
   * R Packages:
      + [`huskydown`](https://github.com/benmarwick/huskydown)
      + [`rrtools`](https://github.com/benmarwick/rrtools)
      * [`broom` vignette](https://cran.r-project.org/web/packages/broom/vignettes/broom.html)
      * [`ggeffects` vignette](https://cran.r-project.org/web/packages/ggeffects/vignettes/marginaleffects.html)
      * [`sjPlot` home page](http://www.strengejacke.de/sjPlot/)
   * [Overleaf online LaTeX editor](http://www.overleaf.com/)
      
### 12. Working with Social Media Data (Out of Date)
   * [Slides for Lecture 12: Social media and text mining](http://clanfear.github.io/CSSS508/Lectures/Week12/CSSS508_week10_scraping.html)
       + [Rmd for Lecture 12 slides](https://github.com/clanfear/CSSS508/raw/master/Lectures/Week12/CSSS508_week10_scraping.Rpres)
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

This project is maintained by [clanfear](https://github.com/clanfear) and includes materials from [rebeccaferrell](https://github.com/rebeccaferrell) with permission.