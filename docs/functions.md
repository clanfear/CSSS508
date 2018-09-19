# Function Reference

This page serves as a quick reference for key functions taught in each lecture of the course.
Under each numbered lecture, you can find a list of the key functions covered in that
lecture with a short description. For more information, use R's built in help (`?`) or
browse the relevant lecture.

Functions listed like `dplyr::filter()` indicate that the function is named `filter()` and it comes from the `dplyr` package. You can actually call a function this way from a package without loading it using `library()`. This is good when you want to use a function that has the same name as one you've already loaded (e.g. `MASS::select()` when you already have `dplyr` loaded).

## Lectures

1. [RStudio and Markdown](https://clanfear.github.io/CSSS508/Lectures/Week1/CSSS508_Week1_RStudio_and_RMarkdown.html)
   * `<-`: The assignment operator, for creating objects.
   * `c()`: **Combine** elements into a vector.
   * `data()`: Load data objects from R packages.
   * `head()`: Displays the first few elements of an object.
   * `hist()`: Draws a histogram of a numeric vector.
   * `install.packages()`: Install a package when given a package name as a string (that is, a name in quotes).
   * `library()`: Loads a package when given the package name (doesn't need to be in quotes).
   * `pander::pander()`: Creates a table in an R Markdown doc out of an object.
   * `plot()`: Draws a default plot (scatterplot for two variables).
   * `str()`: Displays the **structure** of an object such as data types and dimensions.
   * `summary()`: Summarize an object. This function does different things for different types of objects!
   * `View()`: Opens up a data viewer window.
   
2. [Visualizing Data](https://clanfear.github.io/CSSS508/Lectures/Week2/CSSS508_Week2_GGPlot2.html)
   * `getwd()`: Returns the path of the current working directory as a text string.
   * `setwd()`: Sets a new working directory when given a path as a text string.
   * `save()`: Writes an R object to disk as a .RData or .Rds file.
   * `load()`: Opens .RData and .Rds files.
   * `dplyr::filter()`: Subsets data to specific rows based on logical expressions.
   * `ggplot2::ggplot()`: Initiates a `ggplot2` plot.
   * `ggplot2::aes()`: Sets aesthetics inside a `ggplot2` call.
   * `ggplot2::geom_point()`: Draws a points layer (scatterplot).
   * `ggplot2::geom_line()`: Draws a lines layer (line plot).
   * `ggplot2::facet_wrap()`: Splits a plot into a series of plots by levels of a factor.
   * `ggplot2::facet_grid()`: Splits a plot into a grid of plots by levels of multiple factors.
   * `ggplot2::theme()`: A function with many arguments for setting the appearance of a `ggplot2` plot.
   * `ggplot2::ggsave()`: Saves a plot as a PDF or image file.
   
3. Manipulating and Summarizing Data
4. Understanding R Data Structures
5. Importing, Exporting, Cleaning Data
6. Using Loops
7. Writing Functions
8. Working with Text Data
9. Working with Geographical Data
10. Reproducibility and Best Practices
11. Working with Model Results
12. Working with Social Media Data