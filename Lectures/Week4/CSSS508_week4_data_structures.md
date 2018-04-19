<style>
code {
   background-color: #efefef;
   font-weight: bold;
}
</style>

CSSS 508, Week 4: R Data Structures
====================================================================================
author: Charles Lanfear
date: April 18, 2018
width: 1600
height: 900
transition: linear
font-family: helvetica


R Data Types
====================================================================================

So far we've been manipulating data frames, making visuals, and summarizing. This got you pretty far! Now we get more in the weeds of programming. Today is all about *types of data* in R.

Up Until Now
====================================================================================

A data frame is really a **list** of **vectors**, where each vector is a column of the same length (number of rows). But data frames are not the only object we want to have in R (e.g. linear regression output). We need to learn about **vectors**, **matrices**, and **lists** to do additional things we can't express with `dplyr` syntax.

Vectors
====================================================================================
type: section


Making Vectors
====================================================================================
incremental: true

In R, we call a set of values a **vector**. We can create vectors by using the `c()` function ("c" for **c**ombine or **c**oncatenate).


```r
c(1, 3, 7, -0.5)
```

```
[1]  1.0  3.0  7.0 -0.5
```

Vectors have **length**:

```r
length(c(1, 3, 7, -0.5))
```

```
[1] 4
```


Element-wise Vector Math
====================================================================================
incremental: true

When doing arithmetic operations on vectors, R handles these *element-wise*:

```r
c(1, 2, 3) + c(4, 5, 6)
```

```
[1] 5 7 9
```

```r
c(1, 2, 3, 4)^3 # exponentiation with ^
```

```
[1]  1  8 27 64
```

Common operations: `*`, `/`, `exp()` = $e^x$, `log()` = $\log_e(x)$


Vector Recycling
====================================================================================
incremental: true

If we work with vectors of different lengths, R will **recycle** the shorter one by repeating it to make it match up with the longer one:

```r
c(0.5, 3) * c(1, 2, 3, 4)
```

```
[1]  0.5  6.0  1.5 12.0
```

```r
c(0.5, 3, 0.5, 3) * c(1, 2, 3, 4) # same thing
```

```
[1]  0.5  6.0  1.5 12.0
```


Scalars as Recycling
====================================================================================
incremental: true

A special case of recycling involves arithmetic with **scalars** (a single number). These are vectors of length 1 that are recycled to make a longer vector:

```r
3 * c(-1, 0, 1, 2) + 1
```

```
[1] -2  1  4  7
```


Warning on Recycling
====================================================================================
incremental: true

Recycling doesn't work so well with vectors of incommensurate lengths:


```r
c(1, 2, 3, 4) + c(0.5, 1.5, 2.5)
```

```
Warning in c(1, 2, 3, 4) + c(0.5, 1.5, 2.5): longer object length is not a
multiple of shorter object length
```

```
[1] 1.5 3.5 5.5 4.5
```

Try not to let R's recycling behavior catch you by surprise!


Vector-Wise Math
====================================================================================
incremental: true

Some functions operate on an entire vector and return *one number* rather than working element-wise:


```r
sum(c(1, 2, 3, 4))
```

```
[1] 10
```

```r
max(c(1, 2, 3, 4))
```

```
[1] 4
```

Some others: `min()`, `mean()`, `median()`, `sd()`, `var()`

You've seen these used with `dplyr::summarize()`.


Example: Standardizing Data
====================================================================================
incremental: true

Let's say we had some test scores and we wanted to put these on a standardized scale: 

$$z_i = \frac{x_i - \text{mean}(x)}{\text{SD}(x)}$$


```r
x <- c(97, 68, 75, 77, 69, 81, 80, 92, 50, 34, 66, 83, 62)
z <- (x - mean(x)) / sd(x)
round(z, 2)
```

```
 [1]  1.49 -0.23  0.19  0.31 -0.17  0.54  0.48  1.19 -1.30 -2.24 -0.35
[12]  0.66 -0.58
```

The `scale()` function performs the above operation!


Types of Vectors
====================================================================================
incremental: true

`class()` or `str()` will tell you what kind of vector you have. There are a few common types of vectors:

- **numeric**: `c(1, 10*3, 4, -3.14)`
    + **integer**: `0:10`
- **character**: `c("red", "blue", "yellow", "blue")`
- **factor**: `factor(c("red", "blue", "yellow", "blue"))`
- **logical**: `c(FALSE, TRUE, TRUE, FALSE)`


Generating Numeric Vectors
====================================================================================
incremental: true

Numeric vectors contain only numbers, with any number of decimal places.

There are shortcuts for generating common kinds of vectors:

```r
seq(-3, 6, by = 1.75)
```

```
[1] -3.00 -1.25  0.50  2.25  4.00  5.75
```

```r
rep(c(-1, 0, 1), times = 3)
```

```
[1] -1  0  1 -1  0  1 -1  0  1
```

```r
rep(c(-1, 0, 1), each = 3)
```

```
[1] -1 -1 -1  0  0  0  1  1  1
```

Generating Integer Vectors
====================================================================================
incremental: true

Integer vectors are a special case of numeric vectors where all the values are whole numbers.

We can produce them using the `:` shortcut:


```r
n <- 12
1:n
```

```
 [1]  1  2  3  4  5  6  7  8  9 10 11 12
```

```r
n:4
```

```
[1] 12 11 10  9  8  7  6  5  4
```

You can also specify an integer using a whole number followed by `L`:


```r
class(9L)
```

```
[1] "integer"
```


Character Vectors
====================================================================================
incremental: true

Character vectors store data as text and typically come up when dealing names, addresses, and IDs:


```r
first_names <- c("Andre", "Beth", "Carly", "Dan")
class(first_names)
```

```
[1] "character"
```

Note you can store numbers as character data as well, but you cannot perform math on them unless you convert them to numeric.

Factor Vectors
====================================================================================
incremental: true

Factors are categorical data that encode a (modest) number of **levels**, like for gender, experimental group, or geographic region: 


```r
gender <- factor(c("M", "F", "F", "M"))
gender
```

```
[1] M F F M
Levels: F M
```

Character data usually can't go directly into a statistical model, but factor data can. It has an *underlying numeric representation*:


```r
as.numeric(gender)
```

```
[1] 2 1 1 2
```


Logical Vectors
====================================================================================
incremental: true

Logical vectors take only TRUE and FALSE values, and are typically the product of logical tests (e.g. `x==5`). We can make logical vectors by defining binary conditions to check for. For example, we can look at which of the first names has at least 4 letters:


```r
name_lengths <- nchar(first_names) # number of characters
name_lengths
```

```
[1] 5 4 5 3
```

```r
name_lengths >= 4
```

```
[1]  TRUE  TRUE  TRUE FALSE
```


Logical Vectors as Numeric
====================================================================================
incremental: true

You can do math with logical vectors, because `TRUE`=1 and `FALSE`=0:


```r
name_lengths >= 4
```

```
[1]  TRUE  TRUE  TRUE FALSE
```

```r
mean(name_lengths >= 4)
```

```
[1] 0.75
```

What did this last line do?

It told us the *proportion* of name lengths greater than or equal to four!


Combining Logical Conditions
====================================================================================
incremental: true

Suppose we are interested in which names have an even number of letters:


```r
even_length <- (name_lengths %% 2 == 0)
# %% is modulo operator: gives remainder when dividing
even_length
```

```
[1] FALSE  TRUE FALSE FALSE
```

or whose second letter is "a":

```r
second_letter_a <- (substr(first_names, start=2, stop=2) == "a")
# substr: substring (portion) of a char vector
second_letter_a
```

```
[1] FALSE FALSE  TRUE  TRUE
```


Logical Operators: Previously seen in dplyr::filter()
====================================================================================
incremental: true

* `&` is **AND** (both conditions must be `TRUE` to be `TRUE`):


```r
even_length & second_letter_a
```

```
[1] FALSE FALSE FALSE FALSE
```

* `|` is **OR** (at least one condition must be `TRUE` to be `TRUE`):


```r
even_length | second_letter_a
```

```
[1] FALSE  TRUE  TRUE  TRUE
```

* `!` is **NOT** (switches `TRUE` and `FALSE`):


```r
!(even_length | second_letter_a)
```

```
[1]  TRUE FALSE FALSE FALSE
```


Subsetting Vectors
====================================================================================
incremental: true

We can **subset** a vector in a number of ways:

* Passing a single index or vector of entries to **keep**:


```r
first_names[c(1, 4)]
```

```
[1] "Andre" "Dan"  
```

* Passing a single index or vector of entries to **drop**:


```r
first_names[-c(1, 4)]
```

```
[1] "Beth"  "Carly"
```


Subsetting Vectors
====================================================================================
incremental: true

* Passing a logical vector (`TRUE`=keep, `FALSE`=drop):


```r
first_names[even_length | second_letter_a]
```

```
[1] "Beth"  "Carly" "Dan"  
```

```r
first_names[gender != "F"] # != is "not equal to"
```

```
[1] "Andre" "Dan"  
```


Some Logical/Subsetting Functions
====================================================================================
incremental: true

`%in%` lets you avoid typing a lot of logical ORs (`|`):


```r
first_names %in% c("Andre", "Carly", "Dan")
```

```
[1]  TRUE FALSE  TRUE  TRUE
```

`which()` gives the indices of `TRUE`s in a logical vector:


```r
which(first_names %in% c("Andre", "Carly", "Dan"))
```

```
[1] 1 3 4
```


Missing Values
====================================================================================
incremental: true

Missing values are coded as `NA` entries without quotes:


```r
vector_w_missing <- c(1, 2, NA, 4, 5, 6, NA)
```

Even one `NA` "poisons the well": You'll get `NA` out of your calculations unless you remove them manually or with the extra argument `na.rm = TRUE` (in some functions):


```r
mean(vector_w_missing)
```

```
[1] NA
```

```r
mean(vector_w_missing, na.rm=TRUE)
```

```
[1] 3.6
```

Finding Missing Values
====================================================================================
incremental: true

**WARNING:** You can't test for missing values by seeing if they "equal" (`==`) `NA`:


```r
vector_w_missing == NA
```

```
[1] NA NA NA NA NA NA NA
```

But you can use the `is.na()` function:


```r
is.na(vector_w_missing)
```

```
[1] FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE
```

```r
mean(vector_w_missing[!is.na(vector_w_missing)])
```

```
[1] 3.6
```


NA and %in%
====================================================================================
incremental: true

When testing logical conditions, `NA` will produce an `NA` rather than `TRUE` or `FALSE`:


```r
vector_w_missing == 5
```

```
[1] FALSE FALSE    NA FALSE  TRUE FALSE    NA
```

It is noteworthy, however, that `%in%` will handle NAs:


```r
vector_w_missing %in% 5
```

```
[1] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE
```

```r
vector_w_missing %in% NA
```

```
[1] FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE
```

It is still usually best to handle NAs *directly*, however!


Inf and NaN
====================================================================================
incremental: true

Sometimes we might get positive or negative infinity ($\pm \infty$) or `NaN` (**N**ot **A** **N**umber) from our calculations:


```r
c(-2, -1, 0, 1, 2) / 0
```

```
[1] -Inf -Inf  NaN  Inf  Inf
```

You can check for these using functions like `is.finite()` or `is.nan()`.


```r
is.finite(c(-2, -1, 0, 1, 2) / 0)
```

```
[1] FALSE FALSE FALSE FALSE FALSE
```

```r
is.nan(c(-2, -1, 0, 1, 2) / 0)
```

```
[1] FALSE FALSE  TRUE FALSE FALSE
```


Previewing Vectors
====================================================================================
incremental: true

Like with data frames, we can use `head()` and `tail()` to preview vectors:


```r
head(letters) # letters is a built-in vector
```

```
[1] "a" "b" "c" "d" "e" "f"
```

```r
head(letters, 10)
```

```
 [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
```

```r
tail(letters)
```

```
[1] "u" "v" "w" "x" "y" "z"
```


Named Vector Entries
====================================================================================
incremental: true

We can also index vectors by assigning **names** to the entries.


```r
a_vector <- 1:26
names(a_vector) <- LETTERS # capital version of letters
head(a_vector)
```

```
A B C D E F 
1 2 3 4 5 6 
```

```r
a_vector[c("R", "S", "T", "U", "D", "I", "O")]
```

```
 R  S  T  U  D  I  O 
18 19 20 21  4  9 15 
```

Names are nice for subsetting because they don't depend on your data being in a certain order.


Matrices
====================================================================================
type: section


Matrices: 2D vectors
====================================================================================
incremental: true

**Matrices** extend vectors to two **dimension**s: **rows** and **columns**. We can construct them directly using `matrix`.

Note the `byrow` argument which determines whether the data fill the matrix by row or by column.

```r
(a_matrix <- matrix(letters[1:6], nrow=2, ncol=3))
```

```
     [,1] [,2] [,3]
[1,] "a"  "c"  "e" 
[2,] "b"  "d"  "f" 
```

```r
(b_matrix <- matrix(letters[1:6], nrow=2, ncol=3, byrow=TRUE))
```

```
     [,1] [,2] [,3]
[1,] "a"  "b"  "c" 
[2,] "d"  "e"  "f" 
```


Binding Vectors
====================================================================================
incremental: true

We can also make matrices by *binding* vectors together with `rbind()` (**r**ow **bind**) and `cbind()` (**c**olumn **bind**).


```r
(c_matrix <- cbind(c(1, 2), c(3, 4), c(5, 6)))
```

```
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```

```r
(d_matrix <- rbind(c(1, 2, 3), c(4, 5, 6)))
```

```
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
```


Subsetting Matrices
====================================================================================
incremental: true

We subset matrices using the same methods as with vectors, except we index them with `[rows, columns]`:


```r
a_matrix[1, 2] # row 1, column 2
```

```
[1] "c"
```

```r
a_matrix[1, c(2, 3)] # row 1, columns 2 and 3
```

```
[1] "c" "e"
```

We can obtain the dimensions of a matrix using `dim()`.


```r
dim(a_matrix)
```

```
[1] 2 3
```

Note that using `length()` on a matrix will not give you the number of rows or columns but rather the number of elements!

Matrices Becoming Vectors
====================================================================================
incremental: true

If a matrix ends up having just one row or column after subsetting, by default R will make it into a vector. You can prevent this behavior using `drop=FALSE`.


```r
a_matrix[, 1] # all rows, column 1, becomes a vector
```

```
[1] "a" "b"
```

```r
a_matrix[, 1, drop=FALSE] # all rows, column 1, stays a matrix
```

```
     [,1]
[1,] "a" 
[2,] "b" 
```


Matrix Data Type Warning
====================================================================================
incremental: true

Matrices can be numeric, integer, factor, character, or logical, just like vectors. Also like vectors, *all elements must be the same data type*.


```r
(bad_matrix <- cbind(1:2, LETTERS[c(6,1)]))
```

```
     [,1] [,2]
[1,] "1"  "F" 
[2,] "2"  "A" 
```

```r
typeof(bad_matrix)
```

```
[1] "character"
```

In this case, everything was converted to character so as not to lose information.


Matrix Dimension Names
====================================================================================
incremental: true

We can access dimension names or name them ourselves:


```r
rownames(bad_matrix) <- c("Wedge", "Biggs")
colnames(bad_matrix) <- c("Pilot grade", "Moustache grade")
bad_matrix
```

```
      Pilot grade Moustache grade
Wedge "1"         "F"            
Biggs "2"         "A"            
```

```r
bad_matrix["Biggs", , drop=FALSE]
```

```
      Pilot grade Moustache grade
Biggs "2"         "A"            
```


Matrix Arithmetic
====================================================================================
incremental: true

Matrices of the same dimensions can have math performed entry-wise with the usual arithmetic operators:



```r
cbind(c_matrix, d_matrix) # look at side by side
```

```
     [,1] [,2] [,3] [,4] [,5] [,6]
[1,]    1    3    5    1    2    3
[2,]    2    4    6    4    5    6
```

```r
3 * c_matrix / d_matrix
```

```
     [,1] [,2] [,3]
[1,]  3.0  4.5    5
[2,]  1.5  2.4    3
```


Matrix Transposition and Multiplication
====================================================================================
incremental: true

To do matrix transpositions, use `t()`.


```r
(e_matrix <- t(c_matrix))
```

```
     [,1] [,2]
[1,]    1    2
[2,]    3    4
[3,]    5    6
```

To do actual matrix multiplication (not entry-wise), use `%*%`.


```r
(f_matrix <- d_matrix %*% e_matrix)
```

```
     [,1] [,2]
[1,]   22   28
[2,]   49   64
```

Matrix Inversion
====================================================================================
incremental: true

To invert an invertible square matrix, use `solve()`.


```r
(g_matrix <- solve(f_matrix))
```

```
          [,1]       [,2]
[1,]  1.777778 -0.7777778
[2,] -1.361111  0.6111111
```

```r
f_matrix %*% g_matrix
```

```
     [,1]          [,2]
[1,]    1 -3.552714e-15
[2,]    0  1.000000e+00
```

Note the floating point imprecision: The off-diagonals are *very close to zero* rather than actually zero!

Diagonal Matrices
====================================================================================
incremental: true

To extract the diagonal of a matrix or make a diagonal matrix (usually the identity matrix), use `diag()`.


```r
diag(2)
```

```
     [,1] [,2]
[1,]    1    0
[2,]    0    1
```

```r
diag(g_matrix)
```

```
[1] 1.7777778 0.6111111
```


Lists
====================================================================================
type: section


What are Lists?
====================================================================================
incremental: true

**Lists** are an object that can store multiple types of data.


```r
(my_list <- list("first_thing" = 1:5, "second_thing" = matrix(8:11, nrow = 2), "third_thing" = lm(dist ~ speed, data = cars)))
```

```
$first_thing
[1] 1 2 3 4 5

$second_thing
     [,1] [,2]
[1,]    8   10
[2,]    9   11

$third_thing

Call:
lm(formula = dist ~ speed, data = cars)

Coefficients:
(Intercept)        speed  
    -17.579        3.932  
```


Accessing List Elements
====================================================================================
incremental: true

You can access a list element by its name or number in `[[ ]]`, or a `$` followed by its name:


```r
my_list[["first_thing"]]
```

```
[1] 1 2 3 4 5
```

```r
my_list$first_thing
```

```
[1] 1 2 3 4 5
```

```r
my_list[[1]]
```

```
[1] 1 2 3 4 5
```

Why Two Brackets [[]]?
====================================================================================
incremental: true

If you use one bracket to access list elements, you get a **list** back. The double brackets get *the actual element*, as whatever data type it is stored as, in that location in the list.


```r
str(my_list[1])
```

```
List of 1
 $ first_thing: int [1:5] 1 2 3 4 5
```

```r
str(my_list[[1]])
```

```
 int [1:5] 1 2 3 4 5
```

Note that you can only select a single list element at a time using `[[ ]]`, because otherwise this would have to return multiple objects!

Subsetted Lists Can Be of Length > 1
====================================================================================
incremental: true

You can use vector-style subsetting to get a sublist of multiple elements:

```r
length(my_list[c(1, 2)])
```

```
[1] 2
```

```r
str(my_list[c(1, 2)])
```

```
List of 2
 $ first_thing : int [1:5] 1 2 3 4 5
 $ second_thing: int [1:2, 1:2] 8 9 10 11
```


Linear Regression Output is a List!
====================================================================================
incremental: true


```r
str(my_list[[3]])
```

```
List of 12
 $ coefficients : Named num [1:2] -17.58 3.93
  ..- attr(*, "names")= chr [1:2] "(Intercept)" "speed"
 $ residuals    : Named num [1:50] 3.85 11.85 -5.95 12.05 2.12 ...
  ..- attr(*, "names")= chr [1:50] "1" "2" "3" "4" ...
 $ effects      : Named num [1:50] -303.914 145.552 -8.115 9.885 0.194 ...
  ..- attr(*, "names")= chr [1:50] "(Intercept)" "speed" "" "" ...
 $ rank         : int 2
 $ fitted.values: Named num [1:50] -1.85 -1.85 9.95 9.95 13.88 ...
  ..- attr(*, "names")= chr [1:50] "1" "2" "3" "4" ...
 $ assign       : int [1:2] 0 1
 $ qr           :List of 5
  ..$ qr   : num [1:50, 1:2] -7.071 0.141 0.141 0.141 0.141 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:50] "1" "2" "3" "4" ...
  .. .. ..$ : chr [1:2] "(Intercept)" "speed"
  .. ..- attr(*, "assign")= int [1:2] 0 1
  ..$ qraux: num [1:2] 1.14 1.27
  ..$ pivot: int [1:2] 1 2
  ..$ tol  : num 1e-07
  ..$ rank : int 2
  ..- attr(*, "class")= chr "qr"
 $ df.residual  : int 48
 $ xlevels      : Named list()
 $ call         : language lm(formula = dist ~ speed, data = cars)
 $ terms        :Classes 'terms', 'formula'  language dist ~ speed
  .. ..- attr(*, "variables")= language list(dist, speed)
  .. ..- attr(*, "factors")= int [1:2, 1] 0 1
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:2] "dist" "speed"
  .. .. .. ..$ : chr "speed"
  .. ..- attr(*, "term.labels")= chr "speed"
  .. ..- attr(*, "order")= int 1
  .. ..- attr(*, "intercept")= int 1
  .. ..- attr(*, "response")= int 1
  .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
  .. ..- attr(*, "predvars")= language list(dist, speed)
  .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
  .. .. ..- attr(*, "names")= chr [1:2] "dist" "speed"
 $ model        :'data.frame':	50 obs. of  2 variables:
  ..$ dist : num [1:50] 2 10 4 22 16 10 18 26 34 17 ...
  ..$ speed: num [1:50] 4 4 7 7 8 9 10 10 10 11 ...
  ..- attr(*, "terms")=Classes 'terms', 'formula'  language dist ~ speed
  .. .. ..- attr(*, "variables")= language list(dist, speed)
  .. .. ..- attr(*, "factors")= int [1:2, 1] 0 1
  .. .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. .. ..$ : chr [1:2] "dist" "speed"
  .. .. .. .. ..$ : chr "speed"
  .. .. ..- attr(*, "term.labels")= chr "speed"
  .. .. ..- attr(*, "order")= int 1
  .. .. ..- attr(*, "intercept")= int 1
  .. .. ..- attr(*, "response")= int 1
  .. .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv> 
  .. .. ..- attr(*, "predvars")= language list(dist, speed)
  .. .. ..- attr(*, "dataClasses")= Named chr [1:2] "numeric" "numeric"
  .. .. .. ..- attr(*, "names")= chr [1:2] "dist" "speed"
 - attr(*, "class")= chr "lm"
```

Use Names to Find Out List Elements
====================================================================================
incremental: true


```r
names(my_list[[3]])
```

```
 [1] "coefficients"  "residuals"     "effects"       "rank"         
 [5] "fitted.values" "assign"        "qr"            "df.residual"  
 [9] "xlevels"       "call"          "terms"         "model"        
```


Data Frames are Just a List of Vectors!
====================================================================================
incremental: true


```r
str(cars)
```

```
'data.frame':	50 obs. of  2 variables:
 $ speed: num  4 4 7 7 8 9 10 10 10 11 ...
 $ dist : num  2 10 4 22 16 10 18 26 34 17 ...
```

```r
length(cars)
```

```
[1] 2
```

```r
length(cars$dist) # should be same as nrow(cars)
```

```
[1] 50
```


You Can Treat Data Frames like a Matrix
====================================================================================
incremental: true


```r
cars[1, ]
```

```
  speed dist
1     4    2
```

```r
cars[1:5, "speed", drop = FALSE]
```

```
  speed
1     4
2     4
3     7
4     7
5     8
```


Base R vs. dplyr
====================================================================================
incremental: true

Two ways of calculating the same thing: which do you like better?

Classic R:

```r
mean(swiss[swiss$Agriculture > mean(swiss$Agriculture), "Fertility"])
```

`dplyr`:

```r
library(dplyr)
swiss %>%
    filter(Agriculture > mean(Agriculture)) %>%
    summarize(mean = mean(Fertility))
```

An Aside for People with Statistics Training
====================================================================================
type: section

Getting Fitted Regression Coefficients
====================================================================================
incremental: true


```r
my_list[[3]][["coefficients"]]
```

```
(Intercept)       speed 
 -17.579095    3.932409 
```

```r
(speed_beta <- my_list[[3]][["coefficients"]]["speed"])
```

```
   speed 
3.932409 
```

Summarizing Regression with a List
====================================================================================
incremental: true

`summary(lm_object)` is also a list with more information, which has the side effect of printing some output to the console:


```r
summary(my_list[[3]]) # this prints output
```

```

Call:
lm(formula = dist ~ speed, data = cars)

Residuals:
    Min      1Q  Median      3Q     Max 
-29.069  -9.525  -2.272   9.215  43.201 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -17.5791     6.7584  -2.601   0.0123 *  
speed         3.9324     0.4155   9.464 1.49e-12 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 15.38 on 48 degrees of freedom
Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438 
F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12
```


Getting Standard Errors
====================================================================================
incremental: true


```r
summary(my_list[[3]])[["coefficients"]] # a matrix
```

```
              Estimate Std. Error   t value     Pr(>|t|)
(Intercept) -17.579095  6.7584402 -2.601058 1.231882e-02
speed         3.932409  0.4155128  9.463990 1.489836e-12
```

```r
(speed_SE <- summary(my_list[[3]])[["coefficients"]]["speed", "Std. Error"])
```

```
[1] 0.4155128
```


Example: Approximate 95% confidence interval
====================================================================================


```r
speed_CI <- speed_beta + c(-qnorm(0.975), qnorm(0.975)) * speed_SE
names(speed_CI) <- c("lower", "upper")
```

Now you can include these values in a Markdown document:


```r
A 1 mph increase in speed is associated with a `r round(speed_beta, 1)` ft increase in stopping distance (95% CI: (`r round(speed_CI["lower"],1)`, `r round(speed_CI["upper"],1)`)).
```

A 1 mph increase in speed is associated with a 3.9 ft increase in stopping distance (95% CI: (3.1, 4.7)).

Practice and Homework
====================================================================================
type: section

Suggested Practice: swirl
====================================================================================

You can do interactive R tutorials in `swirl` that cover these structure basics. To set up `swirl`:

1. `install.packages("swirl")`
2. `library("swirl")`
3. `swirl()`
4. Choose `R Programming`, pick a tutorial, and follow directions
5. To get out of `swirl`, type `bye()` in the middle of a lesson, or `0` in the menus

At this point, tutorials 1-8 are appropriate.


Homework: Two Choices
====================================================================================
type:section

## Guided Data Structure Practice (Less Advanced):
Fill in a template R Markdown file that walks you through 
creating, accessing, and manipulating R data structures. Enter values in 
the R Markdown document and knit it to check your answers. **Knit after entering each answer**. 
If you get an error, check to see if undoing your last edit solves the problem; coding an assignment to handle
all possible mistakes is really hard! This assignment is also long, so **start early**.

## Manual Linear Regression (More Advanced)
Fill in a template R markdown file that walks you through (1) doing linear regression
manually and (2) comparing it to the built-in `lm()` function. Includes simulating data and
creating and modifying data structures. **Knit after entering each answer**. This
assignment does not check answers as you go. This is also long, so **start early**!
