CSSS 508, Week 11: Tidy Model Results and Applied Data Cleaning
====================================================================================
author: Charles Lanfear
date: December 6, 2017
transition: linear
width: 1400
height: 960


Topics for Today
====================================================================================

Displaying Model Results

* Using `broom`
   * Turning model output lists into dataframes
   * Plotting model output
   * Bootstrapping confidence intervals



* Making regression tables
  * Using `mtable()` in `memisc`
  * Using `stargazer` and `pander`
  
  
  

```r
devtools::install_github("dgrtwo/broom")
library(broom)
```


broom
====================================================================================

tidy() - Creates a dataframe summary of a model.
augment() - Adds columns---such as fitted values---to the data used in the model.
glance() - Provides one row of fit statistics for models.


Standard Output
====================================================================================



```
Error in summary(lm1) : object 'lm1' not found
```
