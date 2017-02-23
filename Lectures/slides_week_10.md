CSSS 508, Week 10
===
author: Rebecca Ferrell
date: June 1, 2016
transition: rotate
width: 1100
height: 750



Topics
===

* Scraping the web with `rvest`
* Mining text with `tm`
* What next?


Web scraping with rvest
===
type: section


Wait, isn't that Argus Filch?
===

![harry potter and game of thrones](https://pbs.twimg.com/media/Bt4B0NAIYAAbGMu.jpg)


Game of Thrones x Harry Potter
===

We'll use the package `rvest` ("harvest") to grab [IMDb](http://www.imdb.com) casts for Game of Thrones and Harry Potter to identify all overlapping actors.


```r
# install.packages("rvest")
library(rvest)
```

First, try out [SelectorGadget](https://cran.r-project.org/web/packages/rvest/vignettes/selectorgadget.html).

```r
# pull full Game of Thrones cast page
got_page <- read_html("http://www.imdb.com/title/tt0944947/fullcredits")
got_cast_raw <- got_page %>%
    html_nodes(".itemprop .itemprop , .character div") %>%
    html_text()
```


Cleaning up the Game of Thrones cast
===


```r
head(got_cast_raw)
```

```
[1] "Peter Dinklage"                                                                         
[2] "\n         Tyrion Lannister\n                  (56 episodes, 2011-2016)\n              "
[3] "Lena Headey"                                                                            
[4] "\n         Cersei Lannister\n                  (50 episodes, 2011-2016)\n              "
[5] "Kit Harington"                                                                          
[6] "\n         Jon Snow\n                  (47 episodes, 2011-2016)\n              "        
```

Pattern appears to be: [actor name], [messy character info], repeat.


Cleaning up the Game of Thrones cast
===

Make a data frame:


```r
got_cast_df <- data.frame(matrix(got_cast_raw, ncol = 2, byrow = TRUE), stringsAsFactors = FALSE)
colnames(got_cast_df) <- c("Actor", "char_info")
head(got_cast_df, 3)
```

```
           Actor
1 Peter Dinklage
2    Lena Headey
3  Kit Harington
                                                                                char_info
1 \n         Tyrion Lannister\n                  (56 episodes, 2011-2016)\n              
2 \n         Cersei Lannister\n                  (50 episodes, 2011-2016)\n              
3         \n         Jon Snow\n                  (47 episodes, 2011-2016)\n              
```


Clean up the character column
===

We want to trim initial whitespace, extract the character, and move the episode count to a new column.


```r
library(stringr); library(dplyr)
got_cast <- got_cast_df %>%
    mutate(char_info = str_trim(char_info),
           GoT_character = str_trim(str_extract(char_info, "^.*\\n")),
           Episodes = as.numeric(str_extract(str_extract(char_info, "[0-9]* episode"), "[0-9]*"))) %>%
    select(-char_info)
```


Scraping Harry Potter actors
===

We'll want to loop over all eight films to do this!


```r
HP_URLs <- c("http://www.imdb.com/title/tt0241527/fullcredits", "http://www.imdb.com/title/tt0295297/fullcredits", "http://www.imdb.com/title/tt0304141/fullcredits", "http://www.imdb.com/title/tt0330373/fullcredits", "http://www.imdb.com/title/tt0373889/fullcredits", "http://www.imdb.com/title/tt0417741/fullcredits", "http://www.imdb.com/title/tt0926084/fullcredits", "http://www.imdb.com/title/tt1201607/fullcredits")
```

Harry Potter scraping
===

Looping game plan:

1. Create a list with a spot for each film
2. Scrape the cast into the spot for each film
3. Reshape the character vector into a matrix
4. Combine the casts of all the films
5. Remove whitespace, etc.


```r
HP_cast_list <- vector("list", length(HP_URLs))
```


Looping
===

Consolidate the work done for GoT into a loop for HP:

```r
for(i in seq_along(HP_URLs)) {
    HP_cast_list[[i]] <- read_html(HP_URLs[i]) %>%
        html_nodes(".itemprop .itemprop , .character div") %>%
        html_text() %>%
        matrix(ncol = 2, byrow = TRUE) %>%
        data.frame(stringsAsFactors = FALSE)
    colnames(HP_cast_list[[i]]) <- c("Actor", "HP_character")
}
HP_cast <- bind_rows(HP_cast_list, .id = "HP_film") %>%
    mutate_each(funs(str_trim))
```

Who was in both?
===
incremental: true


```r
both_GoT_HP <- HP_cast %>%
    inner_join(got_cast, by = "Actor") %>%
    arrange(desc(Episodes), Actor)
```

* ![aragog pycelle](http://assets.cdn.moviepilot.de/files/b9494cbab8d744871de233c28109d0406548a64732c5f2baf993d88bf4d0/limit/1000/1000/daGWgAqX.jpg)


Other ways of getting data off the web
===

Specialized packages for specific services:

* `twitteR` (Twitter REST API), `streamR` (Twitter streaming API), `Rfacebook`
    + Require you get a key to run queries -- store in separate file and pull in, do not hardcode/share with others!
    + Rate limiting can be challenge, use `Sys.sleep(seconds)` if needed to slow code down
    
General API access:

* `httr` for HTTP requests and responses
* `jsonlite` for parsing JSON, `XML` for XML

Many tutorials just a Google search away!
    


Text mining with tm
===
type: section


Text mining terminology
===

* `tm`: R package for performing text mining
* Term: word
* Document: collection of terms
* Corpus: a collection of documents (plural: corpora)
* Dictionary: set of relevant terms


My first corpus
===

We can make a toy corpus manually by creating a character vector, running `VectorSource` on it to read it in, and then `VCorpus` to corpus-ify:


```r
library(tm)
UW_tweets <- c("Remembering and honoring those who made the ultimate sacrifice while serving our country. #MemorialDay2016", "VIDEO: This spring @UW students taught literacy arts to #Colville Reservation students. Check out book they made!", "Enjoy the long weekend, Huskies! And to those studying for finals: Good luck and hang in there!", ".@UWBuerk & @UWFosterSchool–hosted biz plan competition awards $85,000 to students for new ventures. http://ow.ly/3PtI300F87Y  #UWinnovates")
toy_corpus <- VCorpus(VectorSource(UW_tweets))
```


Accessing corpus entries
===

A corpus is just a fancy list of documents, and you can access a document as a list entry:


```r
toy_corpus[[3]]
```

```
<<PlainTextDocument>>
Metadata:  7
Content:  chars: 95
```

```r
as.character(toy_corpus[[3]])
```

```
[1] "Enjoy the long weekend, Huskies! And to those studying for finals: Good luck and hang in there!"
```


Text files as documents
===

You will more likely be making corpora from sources like Twitter or reading in data from text files. 

We'll import a sample of emails from the [Enron corpus](http://bailando.sims.berkeley.edu/enron_email.html) assembled by UC Berkeley students. First, let's download a ZIP file with the text files and unzip it.


```r
download.file("https://www.dropbox.com/s/qrd1j44qnlzg68a/enron_sample_emails.zip?dl=1", destfile = "enron_emails.zip", mode = "wb")
unzip("enron_emails.zip", exdir = "enron_emails")
```


```r
length(list.files("enron_emails/enron_sample_emails"))
```

```
[1] 100
```


Reading in text files
===

Make a corpus where each document is an email in the Enron subsample:


```r
enron_corpus <- VCorpus(DirSource(directory = "enron_emails/enron_sample_emails", mode = "text"))
as.character(enron_corpus[[3]])
```

```
 [1] "Message-ID: <26658543.1075843310470.JavaMail.evans@thyme>"                      
 [2] "Date: Fri, 22 Dec 2000 04:00:00 -0800 (PST)"                                    
 [3] "From: sarah.novosel@enron.com"                                                  
 [4] "To: susan.mara@enron.com"                                                       
 [5] "Subject: Re: Wolak report"                                                      
 [6] "Cc: donna.fulton@enron.com, jeff.dasovich@enron.com"                            
 [7] "Mime-Version: 1.0"                                                              
 [8] "Content-Type: text/plain; charset=us-ascii"                                     
 [9] "Content-Transfer-Encoding: 7bit"                                                
[10] "Bcc: donna.fulton@enron.com, jeff.dasovich@enron.com"                           
[11] "X-From: Sarah Novosel"                                                          
[12] "X-To: Susan J Mara"                                                             
[13] "X-cc: Donna Fulton, Jeff Dasovich"                                              
[14] "X-bcc: "                                                                        
[15] "X-Folder: \\Jeff_Dasovich_June2001\\Notes Folders\\All documents"               
[16] "X-Origin: DASOVICH-J"                                                           
[17] "X-FileName: jdasovic.nsf"                                                       
[18] ""                                                                               
[19] "Sue:"                                                                           
[20] ""                                                                               
[21] "I'm so impressed that you know how to put the link on the email.  I can't "     
[22] "figure out how to do that, and I think that looks much more \"high tech\" than "
[23] "attaching a silly old report."                                                  
[24] ""                                                                               
[25] "Thanks for the link.  We can take it from here.  "                              
[26] ""                                                                               
[27] "Sarah"                                                                          
[28] ""                                                                               
[29] ""                                                                               
[30] ""                                                                               
[31] ""                                                                               
[32] ""                                                                               
[33] "\tSusan J Mara"                                                                 
[34] "\t12/22/2000 11:31 AM"                                                          
[35] "\t\t "                                                                          
[36] "\t\t To: Sarah Novosel/Corp/Enron@ENRON, Donna Fulton/Corp/Enron@ENRON"         
[37] "\t\t cc: Jeff Dasovich/NA/Enron@Enron"                                          
[38] "\t\t Subject: Wolak report"                                                     
[39] ""                                                                               
[40] "Call me computer illiterate. I could not figure out how to download the "       
[41] "report off the web site, so here's the link."                                   
[42] ""                                                                               
[43] " "                                                                              
[44] " http://www.caiso.com/docs/2000/12/12/2000121215070918957.pdf"                  
```

Transformations (maps)
===

Let's change to lowercase, remove "stopwords" and header terms, remove punctuation, numbers, and whitespace, and "stem" the words:


```r
# install.packages("SnowballC") # may solve errors
enron_stripped <- enron_corpus %>%
    tm_map(content_transformer(str_to_lower)) %>%
    tm_map(removeWords, stopwords("english")) %>%
    tm_map(removeWords, c("javamail.evans@thyme", "message-id", "date", "subject", "mime-version", "content-type", "text/plain", "charset=us-ascii", "content-transfer-encoding", "x-", "x-cc", "x-bcc", "x-folder", "x-origin", "x-filename")) %>%
    tm_map(removePunctuation) %>%
    tm_map(removeNumbers) %>%
    tm_map(stripWhitespace) %>%
    tm_map(stemDocument)
```

Word clouds
===


```r
library(wordcloud)
wordcloud(enron_stripped, min.freq = 2, max.words = 80)
```

<img src="slides_week_10-figure/unnamed-chunk-14-1.png" title="plot of chunk unnamed-chunk-14" alt="plot of chunk unnamed-chunk-14" width="1100px" height="440px" />


Filtering to emails with California
===

We'll write a function that takes the content of the documents and looks for any instance of `"california"`, then use it with `tm_filter`:


```r
doc_word_search <- function(x, pattern) {
    any(str_detect(content(x), pattern = pattern))
}
cali_emails <- enron_stripped %>%
    tm_filter(doc_word_search, pattern = "california")
length(cali_emails)
```

```
[1] 14
```


Term-Document Matrices
===

We can look for patterns across the documents by constructing a `TermDocumentMatrix`:


```r
enron_tdm <- TermDocumentMatrix(enron_stripped)
str(enron_tdm)
```

```
List of 6
 $ i       : int [1:17721] 2 9 12 15 17 19 24 27 30 34 ...
 $ j       : int [1:17721] 1 1 1 1 1 1 1 1 1 1 ...
 $ v       : num [1:17721] 4 1 1 1 1 2 1 1 2 4 ...
 $ nrow    : int 5061
 $ ncol    : int 100
 $ dimnames:List of 2
  ..$ Terms: chr [1:5061] "abat" "abil" "abl" "abnorm" ...
  ..$ Docs : chr [1:100] "114495.txt" "115323.txt" "118675.txt" "119214.txt" ...
 - attr(*, "class")= chr [1:2] "TermDocumentMatrix" "simple_triplet_matrix"
 - attr(*, "weighting")= chr [1:2] "term frequency" "tf"
```

What does the matrix look like?
===

Too big to view at once, but we can look at snippets with `inspect`:


```r
inspect(enron_tdm[1:5, 1:5])
```

```
<<TermDocumentMatrix (terms: 5, documents: 5)>>
Non-/sparse entries: 2/23
Sparsity           : 92%
Maximal term length: 7
Weighting          : term frequency (tf)

         Docs
Terms     114495.txt 115323.txt 118675.txt 119214.txt 12030.txt
  abat             0          0          0          0         0
  abil             4          0          0          0         0
  abl              0          0          0          0         1
  abnorm           0          0          0          0         0
  abolish          0          0          0          0         0
```

Removing sparse words
===

We could focus on words that appear in at least 40% of documents.


```r
enron_tdm_sparse <- removeSparseTerms(enron_tdm, 0.60)
inspect(enron_tdm_sparse)
```

```
<<TermDocumentMatrix (terms: 11, documents: 100)>>
Non-/sparse entries: 659/441
Sparsity           : 40%
Maximal term length: 18
Weighting          : term frequency (tf)

                    Docs
Terms                114495.txt 115323.txt 118675.txt 119214.txt 12030.txt
  bit                         1          1          1          1         1
  document                    2          1          1          1         0
  folder                      1          1          1          1         0
  forward                     3          1          0          0         0
  kean                        0          2          0          0         0
  pdt                         1          1          0          0         1
  skeannsf                    0          0          0          0         0
  steven                      0          3          0          0         0
  stevenkeanenroncom          0          1          0          0         0
  thank                       2          0          1          0         0
  will                       19          3          0          0         0
                    Docs
Terms                12174.txt 121748.txt 121756.txt 12176.txt 122913.txt
  bit                        1          1          1         2          1
  document                   0          1          1         0          1
  folder                     0          1          1         0          1
  forward                    0          0          0         0          0
  kean                       0          0          0         0          0
  pdt                        0          1          1         0          1
  skeannsf                   0          0          0         0          0
  steven                     0          0          0         0          0
  stevenkeanenroncom         0          0          0         0          0
  thank                      1          0          0         0          0
  will                       0          0          0         7          0
                    Docs
Terms                122926.txt 130135.txt 149993.txt 165052.txt
  bit                         1          1          1          1
  document                    1          1          1          0
  folder                      1          1          1          0
  forward                     0          0          1          0
  kean                        0          0          0          3
  pdt                         1          0          0          0
  skeannsf                    0          0          0          0
  steven                      0          0          0          2
  stevenkeanenroncom          0          0          0          1
  thank                       0          1          0          1
  will                        1          1          0          0
                    Docs
Terms                173408.txt 173412.txt 173765.txt 173769.txt
  bit                         1          1          1          1
  document                    1          1          1          1
  folder                      1          1          1          1
  forward                     0          1          1          0
  kean                        2          2          2          2
  pdt                         0          0          1          1
  skeannsf                    1          1          1          1
  steven                      2          3          2          2
  stevenkeanenroncom          1          1          1          1
  thank                       1          0          0          1
  will                        0          0          2          1
                    Docs
Terms                173801.txt 173839.txt 173842.txt 173884.txt
  bit                         1          1          1          1
  document                    1          1          1          1
  folder                      1          1          1          1
  forward                     2          0          1          1
  kean                        2          2          2          2
  pdt                         1          1          1          1
  skeannsf                    1          1          1          1
  steven                      3          2          3          3
  stevenkeanenroncom          1          1          1          1
  thank                       0          0          1          1
  will                        0          1          4          0
                    Docs
Terms                173904.txt 173955.txt 173995.txt 174075.txt
  bit                         1          1          1          1
  document                    1          1          1          1
  folder                      1          1          1          1
  forward                     0          1          1          1
  kean                        2          2          2          3
  pdt                         1          1          1          1
  skeannsf                    1          1          1          1
  steven                      2          1          2          4
  stevenkeanenroncom          1          1          1          1
  thank                       0          3          1          0
  will                        1          0          0          1
                    Docs
Terms                174092.txt 174123.txt 174137.txt 174212.txt
  bit                         1          1          1          0
  document                    1          1          1          1
  folder                      1          1          1          1
  forward                     1          1          0          1
  kean                        2          2          2          2
  pdt                         1          1          1          1
  skeannsf                    1          1          1          1
  steven                      3          3          2          2
  stevenkeanenroncom          1          1          1          1
  thank                       1          2          2          0
  will                        1          2          1          8
                    Docs
Terms                174376.txt 174394.txt 174517.txt 175076.txt
  bit                         1          1          1          1
  document                    1          1          1          1
  folder                      1          1          1          1
  forward                     1          1          5          0
  kean                        2          2          2          2
  pdt                         1          1          1          1
  skeannsf                    1          1          1          1
  steven                      2          3          3          2
  stevenkeanenroncom          1          1          1          1
  thank                       1          1          1          1
  will                        2          0          6          0
                    Docs
Terms                175159.txt 175162.txt 175163.txt 175204.txt
  bit                         1          1          1          1
  document                    1          1          2          1
  folder                      1          1          1          1
  forward                     1          0          1          1
  kean                        2          2          2          3
  pdt                         1          1          1          1
  skeannsf                    1          1          1          1
  steven                      2          2          3          1
  stevenkeanenroncom          1          1          1          1
  thank                       3          2          1          2
  will                        1          0          0          0
                    Docs
Terms                175209.txt 175217.txt 175222.txt 175240.txt
  bit                         1          1          1          1
  document                    1          1          1          1
  folder                      1          1          1          1
  forward                     2          0          2          1
  kean                        2          3          2          2
  pdt                         1          1          1          1
  skeannsf                    1          1          1          1
  steven                      3          4          3          2
  stevenkeanenroncom          1          1          1          1
  thank                       0          0          1          1
  will                        0          1          0          0
                    Docs
Terms                175243.txt 175246.txt 175418.txt 175446.txt
  bit                         1          1          1          1
  document                    1          1          1          1
  folder                      1          1          1          1
  forward                     1          0          0          0
  kean                        2          2          2          2
  pdt                         1          1          1          1
  skeannsf                    1          1          1          1
  steven                      2          1          1          2
  stevenkeanenroncom          1          1          1          1
  thank                       2          1          0          3
  will                        1          0          0          0
                    Docs
Terms                175493.txt 175501.txt 175596.txt 175607.txt
  bit                         1          1          1          1
  document                    1          1          1          3
  folder                      1          1          1          1
  forward                     2          0          1          8
  kean                        2          3          2          1
  pdt                         1          1          0          0
  skeannsf                    1          1          1          1
  steven                      3          4          3          0
  stevenkeanenroncom          1          1          1          0
  thank                       1          0          1          1
  will                        1          0          0         73
                    Docs
Terms                175617.txt 175619.txt 175621.txt 175622.txt
  bit                         1          1          1          1
  document                    1          1          1          1
  folder                      1          1          1          1
  forward                     1          0          1          1
  kean                        2          3          2          3
  pdt                         0          0          0          0
  skeannsf                    1          1          1          1
  steven                      3          2          3          5
  stevenkeanenroncom          1          1          1          1
  thank                       4          1          2          0
  will                        2          1          0          2
                    Docs
Terms                175662.txt 175810.txt 176524.txt 176539.txt
  bit                         1          1          0          1
  document                    1          1          1          1
  folder                      1          1          1          1
  forward                     0          1          2          1
  kean                        2          3          3          2
  pdt                         0          0          1          1
  skeannsf                    1          1          1          1
  steven                      2          4          1          3
  stevenkeanenroncom          1          1          1          1
  thank                       1          0          1          0
  will                        1          0          1          0
                    Docs
Terms                176580.txt 176591.txt 176601.txt 176727.txt
  bit                         1          1          1          1
  document                    1          1          1          1
  folder                      1          1          1          1
  forward                     1          1          0          0
  kean                        2          2          2          2
  pdt                         1          1          1          1
  skeannsf                    1          1          1          1
  steven                      2          2          1          1
  stevenkeanenroncom          1          1          1          1
  thank                       3          0          4          3
  will                        0          3          5          0
                    Docs
Terms                176805.txt 177215.txt 177800.txt 177819.txt
  bit                         1          1          1          1
  document                    2          2          0          0
  folder                      0          0          0          0
  forward                     8          8          0          1
  kean                        1          1          2          2
  pdt                         0          0          1          1
  skeannsf                    1          1          0          0
  steven                      0          0          3          4
  stevenkeanenroncom          0          0          1          1
  thank                       1          1          0          0
  will                       73         73          1          0
                    Docs
Terms                177847.txt 177853.txt 178057.txt 194901.txt
  bit                         1          1          1          1
  document                    0          0          0          1
  folder                      0          0          0          0
  forward                     0          0          0          0
  kean                        2          2          2          0
  pdt                         1          1          1          1
  skeannsf                    0          0          0          0
  steven                      3          3          3          0
  stevenkeanenroncom          1          1          1          0
  thank                       1          0          1          0
  will                        0          0          2          0
                    Docs
Terms                229326.txt 239959.txt 255511.txt 50307.txt 52201.txt
  bit                         1          1          2         1         1
  document                    0          0          2         0         0
  folder                      0          0          1         0         0
  forward                     2          0          3         0         0
  kean                        2          0          0         0         0
  pdt                         1          0          1         1         1
  skeannsf                    0          0          0         0         0
  steven                      1          0          0         1         0
  stevenkeanenroncom          0          0          0         0         0
  thank                       1          2          2         0         0
  will                        0          0         19         0         0
                    Docs
Terms                52713.txt 53536.txt 54263.txt 54536.txt 54537.txt
  bit                        1         1         1         1         1
  document                   0         0         0         5         0
  folder                     0         0         0         0         0
  forward                    0         0         0         1         0
  kean                       0         0         0         0         0
  pdt                        0         0         1         1         1
  skeannsf                   0         0         0         0         0
  steven                     0         0         0         0         0
  stevenkeanenroncom         0         0         0         0         0
  thank                      1         1         1         3         1
  will                       0         0         0         3         1
                    Docs
Terms                54540.txt 54566.txt 54577.txt 54582.txt 54595.txt
  bit                        1         1         1         1         1
  document                   0         0         0         0         0
  folder                     0         0         0         0         0
  forward                    0         0         1         0         1
  kean                       0         0         0         0         0
  pdt                        1         1         1         1         1
  skeannsf                   0         0         0         0         0
  steven                     0         0         0         0         0
  stevenkeanenroncom         0         0         0         0         0
  thank                      1         0         1         0         0
  will                       1         0         2         0         0
                    Docs
Terms                54605.txt 54642.txt 54660.txt 54662.txt 54664.txt
  bit                        1         1         1         1         1
  document                   0         0         0         0         0
  folder                     0         0         0         0         0
  forward                    1         0         1         0         0
  kean                       0         0         0         0         0
  pdt                        1         1         1         1         1
  skeannsf                   0         0         0         0         0
  steven                     0         0         0         0         0
  stevenkeanenroncom         0         0         0         0         0
  thank                      0         2         0         0         0
  will                       1         1         1         0         0
                    Docs
Terms                54671.txt 54674.txt 54678.txt 54681.txt 54846.txt
  bit                        1         1         1         1         1
  document                   0         0         0         0         0
  folder                     0         0         0         0         0
  forward                    0         0         0         0         0
  kean                       0         0         0         0         0
  pdt                        1         1         1         1         1
  skeannsf                   0         0         0         0         0
  steven                     0         0         0         0         0
  stevenkeanenroncom         0         0         0         0         0
  thank                      0         0         1         0         0
  will                       0         0         3         0         0
                    Docs
Terms                55210.txt 65969.txt 9085.txt 9159.txt 9191.txt
  bit                        1         1        1        1        1
  document                   0         0        0        0        0
  folder                     0         0        0        0        0
  forward                    0         0        0        0        0
  kean                       0         0        0        0        1
  pdt                        0         0        1        1        1
  skeannsf                   0         0        0        0        0
  steven                     0         0        0        0        0
  stevenkeanenroncom         0         0        0        0        0
  thank                      0         0        0        2        0
  will                       0         0        3        1        0
```


Favorite dictionary words
===

Or we can make make a term-document matrix focusing on words in a dictionary and look at just those columns:


```r
inspect(TermDocumentMatrix(enron_stripped, list(dictionary = c("california", "utah", "texas")))[, 1:5])
```

```
<<TermDocumentMatrix (terms: 3, documents: 5)>>
Non-/sparse entries: 2/13
Sparsity           : 87%
Maximal term length: 10
Weighting          : term frequency (tf)

            Docs
Terms        114495.txt 115323.txt 118675.txt 119214.txt 12030.txt
  california         27         26          0          0         0
  texas               0          0          0          0         0
  utah                0          0          0          0         0
```


Most frequent words
===

Which terms appear at least 200 times?


```r
findFreqTerms(enron_tdm, 200)
```

```
 [1] "california" "compani"    "contract"   "electr"     "energi"    
 [6] "gas"        "generat"    "market"     "new"        "plant"     
[11] "power"      "price"      "said"       "state"      "time"      
[16] "util"       "will"       "year"      
```


Word associations
===

Which words co-occur frequently with "california"?

```r
findAssocs(enron_tdm, "california", 0.90)
```

```
$california
                             citizen                               condit 
                                1.00                                 1.00 
                              consum                               credit 
                                1.00                                 1.00 
                              dynegi                            economist 
                                1.00                                 1.00 
                              electr                               energi 
                                1.00                                 1.00 
                              enough                              essenti 
                                1.00                                 1.00 
                                forc                               higher 
                                1.00                                 1.00 
                              includ                              increas 
                                1.00                                 1.00 
                            investig                                locat 
                                1.00                                 1.00 
                              market                                order 
                                1.00                                 1.00 
                               power                                press 
                                1.00                                 1.00 
                              provid                                regul 
                                1.00                                 1.00 
                             reliabl                               report 
                                1.00                                 1.00 
                                roll                           sacramento 
                                1.00                                 1.00 
                            statewid                                 step 
                                1.00                                 1.00 
                            structur                               summer 
                                1.00                                 1.00 
                              suppli                                three 
                                1.00                                 1.00 
                             weather                                whose 
                                1.00                                 1.00 
                              abnorm                              abolish 
                                0.99                                 0.99 
                             abraham                              absolut 
                                0.99                                 0.99 
                              access                           accomplish 
                                0.99                                 0.99 
                               accru                              accumul 
                                0.99                                 0.99 
                               accus                               achiev 
                                0.99                                 0.99 
                          acknowledg                             acquisit 
                                0.99                                 0.99 
                               actor                                 acut 
                                0.99                                 0.99 
                                adam                                  add 
                                0.99                                 0.99 
                               addit                             addresse 
                                0.99                                 0.99 
                            adequaci                                adjac 
                                0.99                                 0.99 
                              adjust                                adopt 
                                0.99                                 0.99 
                            advantag                               advers 
                                0.99                                 0.99 
                               advoc                             advocaci 
                                0.99                                 0.99 
                              affect                                agenc 
                                0.99                                 0.99 
                               agent                              aggress 
                                0.99                                 0.99 
                                 aid                                  air 
                                0.99                                 0.99 
                             airport                              alamito 
                                0.99                                 0.99 
                               alarm                               albani 
                                0.99                                 0.99 
                               alert                                 aliv 
                                0.99                                 0.99 
                           allegheni                              alliant 
                                0.99                                 0.99 
                               allot                                allow 
                                0.99                                 0.99 
                                alon                                 also 
                                0.99                                 0.99 
                              altern                             altogeth 
                                0.99                                 0.99 
                               amass                                amoco 
                                0.99                                 0.99 
                                amok                                 ampl 
                                0.99                                 0.99 
                             analysi                                angel 
                                0.99                                 0.99 
                             angelid                                angus 
                                0.99                                 0.99 
                              anjali                               annual 
                                0.99                                 0.99 
                        anticompetit                            antitrust 
                                0.99                                 0.99 
                             antonio                              anywher 
                                0.99                                 0.99 
                            appendix                                 appl 
                                0.99                                 0.99 
                            applianc                             appointe 
                                0.99                                 0.99 
                              approv                                 arco 
                                0.99                                 0.99 
                                argu                              arguabl 
                                0.99                                 0.99 
                                aros                               arrang 
                                0.99                                 0.99 
                              arrest                             artifici 
                                0.99                                 0.99 
                                asid                               aspect 
                                0.99                                 0.99 
                             assembl                          assemblyman 
                                0.99                                 0.99 
                              assert                             atkinson 
                                0.99                                 0.99 
                              attack                             attorney 
                                0.99                                 0.99 
                            attribut                                audra 
                                0.99                                 0.99 
                             augusta                              automat 
                                0.99                                 0.99 
                               avail                               averag 
                                0.99                                 0.99 
                               avert                                await 
                                0.99                                 0.99 
                               award                               aybear 
                                0.99                                 0.99 
                              backup                             backyard 
                                0.99                                 0.99 
                                 bad                          bakersfield 
                                0.99                                 0.99 
                              balanc                               bangor 
                                0.99                                 0.99 
                          bankruptci                                  bar 
                                0.99                                 0.99 
                                barg                              bargain 
                                0.99                                 0.99 
                                barn                                basic 
                                0.99                                 0.99 
                               basin                               battin 
                                0.99                                 0.99 
                                bccd                               beaten 
                                0.99                                 0.99 
                                 bed                                begun 
                                0.99                                 0.99 
                              beloit                            benchmark 
                                0.99                                 0.99 
                             benefit                             berkeley 
                                0.99                                 0.99 
                            berkshir                    berkshirehathaway 
                                0.99                                 0.99 
                           bernadino                             berthold 
                                0.99                                 0.99 
                               besid                                beyer 
                                0.99                                 0.99 
                              bigger                              biggest 
                                0.99                                 0.99 
                             billion                              biomass 
                                0.99                                 0.99 
                              bitten                                black 
                                0.99                                 0.99 
                            blackout                                bless 
                                0.99                                 0.99 
                               blunt                                blyth 
                                0.99                                 0.99 
                                bond                                bonus 
                                0.99                                 0.99 
                               boost                               border 
                                0.99                                 0.99 
                          borderless                           borenstein 
                                0.99                                 0.99 
                                born                            bostonbas 
                                0.99                                 0.99 
                              bought                               bounti 
                                0.99                                 0.99 
                               bowen                                 bowr 
                                0.99                                 0.99 
                              breach                                break 
                                0.99                                 0.99 
                           breakdown                                brick 
                                0.99                                 0.99 
                               bridg                                brink 
                                0.99                                 0.99 
                             british                                 brka 
                                0.99                                 0.99 
                            broadbas                            broadcast 
                                0.99                                 0.99 
                               brown                             budhraja 
                                0.99                                 0.99 
                             buffett                                built 
                                0.99                                 0.99 
                                bulk                                 bump 
                                0.99                                 0.99 
                          bureaucrat                              burglar 
                                0.99                                 0.99 
                              burton                             bustillo 
                                0.99                                 0.99 
                               bustl                                caith 
                                0.99                                 0.99 
                           calenergi                                calif 
                                0.99                                 0.99 
                            califbas                        californialik 
                                0.99                                 0.99 
                      californiastyl                        californiatyp 
                                0.99                                 0.99 
                          calipatria                               caliso 
                                0.99                                 0.99 
                            campaign                               cancel 
                                0.99                                 0.99 
                                cape                                 carl 
                                0.99                                 0.99 
                            carolina                                carri 
                                0.99                                 0.99 
                           carsonbas                            cashstrap 
                                0.99                                 0.99 
                               catch                                 caus 
                                0.99                                 0.99 
                             caution                                  cec 
                                0.99                                 0.99 
                               cedar                                 cent 
                                0.99                                 0.99 
                         centraleast                               centro 
                                0.99                                 0.99 
                          chairwoman                              chamber 
                                0.99                                 0.99 
                               charg                              chastis 
                                0.99                                 0.99 
                            cheapest                              chevron 
                                0.99                                 0.99 
                               chose                                circl 
                                0.99                                 0.99 
                                cite                                 citi 
                                0.99                                 0.99 
                             clarifi                                clash 
                                0.99                                 0.99 
                            classifi                        cleanalthough 
                                0.99                                 0.99 
                             cleaner                             cleanest 
                                0.99                                 0.99 
                            clearlak                           closeddoor 
                                0.99                                 0.99 
                             coalfir                            coalgener 
                                0.99                                 0.99 
                               coast                                  cod 
                                0.99                                 0.99 
                             cogener                                 cohn 
                                0.99                                 0.99 
                                cold                             colleagu 
                                0.99                                 0.99 
                              column                               combat 
                                0.99                                 0.99 
                        combinedcycl                                 come 
                                0.99                                 0.99 
                          commentari                              commiss 
                                0.99                                 0.99 
                          commission                             committe 
                                0.99                                 0.99 
                             compani                         companyalong 
                                0.99                                 0.99 
                          companyown                           comparison 
                                0.99                                 0.99 
                             complac                             complain 
                                0.99                                 0.99 
                            compound                              conceiv 
                                0.99                                 0.99 
                             concert                             congener 
                                0.99                                 0.99 
                             congest                              connect 
                                0.99                                 0.99 
                              connel                              conserv 
                                0.99                                 0.99 
                     conservationist                             consolid 
                                0.99                                 0.99 
                             contend                             contenti 
                                0.99                                 0.99 
                             continu                           contractor 
                                0.99                                 0.99 
                            contrari                             contrast 
                                0.99                                 0.99 
                         controversi                              convinc 
                                0.99                                 0.99 
                                cook                               cooper 
                                0.99                                 0.99 
                                 cop                            copyright 
                                0.99                                 0.99 
                             cordova                               corner 
                                0.99                                 0.99 
                          cornerston                            corollari 
                                0.99                                 0.99 
                                 cos                                 cost 
                                0.99                                 0.99 
                         counterpart                               counti 
                                0.99                                 0.99 
                             countri                                  cow 
                                0.99                                 0.99 
                                cpuc                                craft 
                                0.99                                 0.99 
                               crash                             creditor 
                                0.99                                 0.99 
                        creditworthi                                creek 
                                0.99                                 0.99 
                               crisi                                cross 
                                0.99                                 0.99 
                           crossbord                            crossroad 
                                0.99                                 0.99 
                              crunch                                  cub 
                                0.99                                 0.99 
                               cubic                                 curb 
                                0.99                                 0.99 
                             current                               custom 
                                0.99                                 0.99 
                                 cut                              cutback 
                                0.99                                 0.99 
                                cycl                               damrel 
                                0.99                                 0.99 
                              danger                               darken 
                                0.99                                 0.99 
                                davi                                  day 
                                0.99                                 0.99 
                            dboulder                              dbuxton 
                                0.99                                 0.99 
                              dcalif                              deadlin 
                                0.99                                 0.99 
                           dealbreak                                 dean 
                                0.99                                 0.99 
                               deast                                debat 
                                0.99                                 0.99 
                               debra                                decri 
                                0.99                                 0.99 
                               dedic                               deeper 
                                0.99                                 0.99 
                              defend                                  del 
                                0.99                                 0.99 
                               deleg                                delic 
                                0.99                                 0.99 
                               delta                               demand 
                                0.99                                 0.99 
                           demandsid                              denounc 
                                0.99                                 0.99 
                              depart                               depend 
                                0.99                                 0.99 
                              deplor                              deregul 
                                0.99                                 0.99 
                              design                                desir 
                                0.99                                 0.99 
                              despit                               detmer 
                                0.99                                 0.99 
                             deulloa                                devis 
                                0.99                                 0.99 
                              devolv                              diametr 
                                0.99                                 0.99 
                               diann                                  dig 
                                0.99                                 0.99 
                             dilemma                                dilig 
                                0.99                                 0.99 
                            diminish                              dirtier 
                                0.99                                 0.99 
                          disappoint                               disast 
                                0.99                                 0.99 
                            discharg                              disclos 
                                0.99                                 0.99 
                             dismiss                             dispatch 
                                0.99                                 0.99 
                             disrupt                              distant 
                                0.99                                 0.99 
                            distress                             district 
                                0.99                                 0.99 
                             dittmer                               divers 
                                0.99                                 0.99 
                          divestitur                                divis 
                                0.99                                 0.99 
                             dmarina                               dollar 
                                0.99                                 0.99 
                               donal                             donnelli 
                                0.99                                 0.99 
                            dorinson                                 doti 
                                0.99                                 0.99 
                                 dow                             downplay 
                                0.99                                 0.99 
                            downstat                            dportland 
                                0.99                                 0.99 
                                drag                                dread 
                                0.99                                 0.99 
                              driven                                 drop 
                                0.99                                 0.99 
                            dshafter                         dspringfield 
                                0.99                                 0.99 
                    dtoddftenergycom                            duluthbas 
                                0.99                                 0.99 
                                 dwr                                  dyn 
                                0.99                                 0.99 
                               earli                                  eas 
                                0.99                                 0.99 
                              easier                               easili 
                                0.99                                 0.99 
                             eastern                               eclips 
                                0.99                                 0.99 
                                econ                               ecotek 
                                0.99                                 0.99 
                              edison                               effect 
                                0.99                                 0.99 
                                 eix                         electricgrid 
                                0.99                                 0.99 
                    electricitygener                   electricitypurchas 
                                0.99                                 0.99 
                             element                           ellingwood 
                                0.99                                 0.99 
                               embed                                 emit 
                                0.99                                 0.99 
                             emshwil                               endors 
                                0.99                                 0.99 
                               endur                          energystarv 
                                0.99                                 0.99 
                          energytrad                              england 
                                0.99                                 0.99 
                              enmiti                                enorm 
                                0.99                                 0.99 
                               ensur                               entitl 
                                0.99                                 0.99 
                                 epg                                equal 
                                0.99                                 0.99 
                               equat                              equival 
                                0.99                                 0.99 
                              ernaut                                estim 
                                0.99                                 0.99 
                                even                               exceed 
                                0.99                                 0.99 
                               excus                            execution 
                                0.99                                 0.99 
                              exempt                               exodus 
                                0.99                                 0.99 
                              exoner                               expans 
                                0.99                                 0.99 
                              expect                           expenditur 
                                0.99                                 0.99 
                              expens                                expir 
                                0.99                                 0.99 
                              explan                              exploit 
                                0.99                                 0.99 
                               expos                               extend 
                                0.99                                 0.99 
                               facil                               factor 
                                0.99                                 0.99 
                                fail                                fairi 
                                0.99                                 0.99 
                             falloff                             familiar 
                                0.99                                 0.99 
                                 fan                              fashion 
                                0.99                                 0.99 
                             fastest                                fault 
                                0.99                                 0.99 
                               feder                                 feet 
                                0.99                                 0.99 
                           feinstein                             ferguson 
                                0.99                                 0.99 
                              ferret                              fichera 
                                0.99                                 0.99 
                               fierc                                 fill 
                                0.99                                 0.99 
                              financ                        finesalthough 
                                0.99                                 0.99 
                                fire                             fiveyear 
                                0.99                                 0.99 
                           fixedpric                                 flag 
                                0.99                                 0.99 
                                flat                              flexibl 
                                0.99                                 0.99 
                                 fli                               florez 
                                0.99                                 0.99 
                            fluctuat                                 flux 
                                0.99                                 0.99 
                                 foe                              fogarti 
                                0.99                                 0.99 
                               foley                                foray 
                                0.99                                 0.99 
                            forecast                              formula 
                                0.99                                 0.99 
                             founder                               fourth 
                                0.99                                 0.99 
                              fragil                         franciscobas 
                                0.99                                 0.99 
                              franck                                 fray 
                                0.99                                 0.99 
                                fred                                freed 
                                0.99                                 0.99 
                          freemarket                                freez 
                                0.99                                 0.99 
                              frenzi                             frequent 
                                0.99                                 0.99 
                            frustrat                                 fuel 
                                0.99                                 0.99 
                                full                                  gap 
                                0.99                                 0.99 
                                 gas                              gascost 
                                0.99                                 0.99 
                              gasfir                              gaudett 
                                0.99                                 0.99 
                                gaug                              general 
                                0.99                                 0.99 
                             generat                              georgia 
                                0.99                                 0.99 
                            geotherm                                gerth 
                                0.99                                 0.99 
                               glenn                                 goal 
                                0.99                                 0.99 
                             goliath                                  gov 
                                0.99                                 0.99 
                                gray                              greater 
                                0.99                                 0.99 
                                grew                                 grid 
                                0.99                                 0.99 
                            guarante                             guidelin 
                                0.99                                 0.99 
                               gyrat                           hagerstown 
                                0.99                                 0.99 
                       hagerstownbas                                  hal 
                                0.99                                 0.99 
                                half                              halfown 
                                0.99                                 0.99 
                              hammer                               hamper 
                                0.99                                 0.99 
                            harrigan                                harsh 
                                0.99                                 0.99 
                            hathaway                                hawig 
                                0.99                                 0.99 
                           headquart                            healthier 
                                0.99                                 0.99 
                                heat                              heavili 
                                0.99                                 0.99 
                              hebert                                hefti 
                                0.99                                 0.99 
                              height                                herik 
                                0.99                                 0.99 
                                high                              highest 
                                0.99                                 0.99 
                           highlight                             highpric 
                                0.99                                 0.99 
                                hike                                hinik 
                                0.99                                 0.99 
                              histor                                 hole 
                                0.99                                 0.99 
                            hopeless                              horribl 
                                0.99                                 0.99 
                              hospit                            household 
                                0.99                                 0.99 
                               howev                  httpwwwagostatemaus 
                                0.99                                 0.99 
             httpwwwalliantenergycom                     httpwwwcpuccagov 
                                0.99                                 0.99 
                     httpwwwisonecom                        httpwwwmgecom 
                                0.99                                 0.99 
               httpwwwnstaronlinecom                  httpwwwpscstatewius 
                                0.99                                 0.99 
                    httpwwwwiscuborg                  httpwwwwisenergycom 
                                0.99                                 0.99 
                               huard                                hundr 
                                0.99                                 0.99 
                          huntington                                hurri 
                                0.99                                 0.99 
                               hydro                          hydroelectr 
                                0.99                                 0.99 
                         hydroquebec                              ideolog 
                                0.99                                 0.99 
                               ignor                                  ill 
                                0.99                                 0.99 
                              illbas                              illinoi 
                                0.99                                 0.99 
                                imag                               immedi 
                                0.99                                 0.99 
                              immens                                immin 
                                0.99                                 0.99 
                              impair                               imperi 
                                0.99                                 0.99 
                               impos                               imposs 
                                0.99                                 0.99 
                               impot                             imprecis 
                                0.99                                 0.99 
                               inabl                              inaccur 
                                0.99                                 0.99 
                               inact                                  inc 
                                0.99                                 0.99 
                              incent                               incept 
                                0.99                                 0.99 
                               incid                               inclin 
                                0.99                                 0.99 
                           inconsist                               indebt 
                                0.99                                 0.99 
                            independ                                index 
                                0.99                                 0.99 
                           indispens                             ineffect 
                                0.99                                 0.99 
                              inevit                            influenti 
                                0.99                                 0.99 
                             infobox                            infograph 
                                0.99                                 0.99 
                              ingram                              inhibit 
                                0.99                                 0.99 
                              inject                              injunct 
                                0.99                                 0.99 
                             insofar                               insolv 
                                0.99                                 0.99 
                             instanc                            insuffici 
                                0.99                                 0.99 
                               insul                               intens 
                                0.99                                 0.99 
interactivecaliforniaimplicationsdoc     interactivecaliforniaselecteddoc 
                                0.99                                 0.99 
                        interconnect                               interf 
                                0.99                                 0.99 
                            interfac                       interjurisdict 
                                0.99                                 0.99 
                           interpret                            interrupt 
                                0.99                                 0.99 
                             interst                            intervent 
                                0.99                                 0.99 
                             intrast                             intrazon 
                                0.99                                 0.99 
                            introduc                          investorown 
                                0.99                                 0.99 
                         involuntari                               inward 
                                0.99                                 0.99 
                             iowabas                                 iron 
                                0.99                                 0.99 
                             irrepar                                jason 
                                0.99                                 0.99 
             jasonleopolddowjonescom                                jenif 
                                0.99                                 0.99 
                            jeopardi                               jersey 
                                0.99                                 0.99 
                      jerseymaryland                              jessica 
                                0.99                                 0.99 
          jessicabertholddowjonescom                               jockey 
                                0.99                                 0.99 
                              joliet                                 jone 
                                0.99                                 0.99 
                          journalist                                 judg 
                                0.99                                 0.99 
                                juic                               justic 
                                0.99                                 0.99 
                              justif                              justifi 
                                0.99                                 0.99 
                                kate                               keeley 
                                0.99                                 0.99 
                              keeper                                 kern 
                                0.99                                 0.99 
                              keynot                                  kid 
                                0.99                                 0.99 
                            kilowatt                         kilowatthour 
                                0.99                                 0.99 
                                king                                 kirk 
                                0.99                                 0.99 
                               knock                                 lack 
                                0.99                                 0.99 
                                laid                                 lake 
                                0.99                                 0.99 
                             lancast                             landmark 
                                0.99                                 0.99 
                           landsberg                                 laps 
                                0.99                                 0.99 
                             larcamp                                 larg 
                                0.99                                 0.99 
                              larger                              largest 
                                0.99                                 0.99 
                                 las                                 last 
                                0.99                                 0.99 
                           lastminut                               latest 
                                0.99                                 0.99 
                              lawmak                              lawrenc 
                                0.99                                 0.99 
                             lawsuit                               lawyer 
                                0.99                                 0.99 
                          legislatur                              legitim 
                                0.99                                 0.99 
                            leimgrub                             leitzing 
                                0.99                                 0.99 
                                lend                               length 
                                0.99                                 0.99 
                             lengthi                              leopold 
                                0.99                                 0.99 
                                less                               lessen 
                                0.99                                 0.99 
                             leverag                                 levi 
                                0.99                                 0.99 
                                 lie                            lightbulb 
                                0.99                                 0.99 
                              lightn                           likelihood 
                                0.99                                 0.99 
                               liken                                 line 
                                0.99                                 0.99 
                                load                             lobbyist 
                                0.99                                 0.99 
                          localfeder                               longer 
                                0.99                                 0.99 
                            longrang                             longterm 
                                0.99                                 0.99 
                                 los                                 loss 
                                0.99                                 0.99 
                                lott                                  low 
                                0.99                                 0.99 
                              lowest                                  ltd 
                                0.99                                 0.99 
                               lurch                                 made 
                                0.99                                 0.99 
                             madison                             magnitud 
                                0.99                                 0.99 
                                main                                major 
                                0.99                                 0.99 
                                make                            manhattan 
                                0.99                                 0.99 
                            manifest                              manipul 
                                0.99                                 0.99 
                                 map                             marathon 
                                0.99                                 0.99 
                              marcel                           markethedg 
                                0.99                                 0.99 
                           marketpow                     marketrestructur 
                                0.99                                 0.99 
                            maryland                                 mass 
                                0.99                                 0.99 
                        massachusett                               massiv 
                                0.99                                 0.99 
                         mattereveri                                mayor 
                                0.99                                 0.99 
                           mcelhenni                             meanwhil 
                                0.99                                 0.99 
                              mechan                                medic 
                                0.99                                 0.99 
                             mediums                             megawatt 
                                0.99                                 0.99 
                        megawatthour                             meltdown 
                                0.99                                 0.99 
                              merger                               merril 
                                0.99                                 0.99 
                               meter                                 meti 
                                0.99                                 0.99 
                                mges                              michaud 
                                0.99                                 0.99 
                         midamerican                 midamericancalenergi 
                                0.99                                 0.99 
                           midatlant                           midjanuari 
                                0.99                                 0.99 
                               midst                               midway 
                                0.99                                 0.99 
                        midwaysunset                              midwest 
                                0.99                                 0.99 
                              miguel                          millinocket 
                                0.99                                 0.99 
                             million                         milwaukeebas 
                                0.99                                 0.99 
                           minnesota                               mirror 
                                0.99                                 0.99 
                         misbehavior                             mismatch 
                                0.99                                 0.99 
                             mission                        mississippian 
                                0.99                                 0.99 
                              mistak                              mitchel 
                                0.99                                 0.99 
                               mitig                               modest 
                                0.99                                 0.99 
                              modifi                              monahan 
                                0.99                                 0.99 
                               money                                month 
                                0.99                                 0.99 
                              morain                           moratorium 
                                0.99                                 0.99 
                              morrel                               mosher 
                                0.99                                 0.99 
                              motion                                motiv 
                                0.99                                 0.99 
                               mount                             mountain 
                                0.99                                 0.99 
                        mountainview                             movement 
                                0.99                                 0.99 
                                much                              multipl 
                                0.99                                 0.99 
                            multipli                            multiyear 
                                0.99                                 0.99 
                             municip                                musel 
                                0.99                                 0.99 
                             mustrun                                  mwh 
                                0.99                                 0.99 
                                myer                                nasti 
                                0.99                                 0.99 
                           nationwid                                natur 
                                0.99                                 0.99 
                           naturalga                                 near 
                                0.99                                 0.99 
                        nearbankrupt                                  neb 
                                0.99                                 0.99 
                                need                             neighbor 
                                0.99                                 0.99 
                             network                                  nev 
                                0.99                                 0.99 
                              nevada                         nevertheless 
                                0.99                                 0.99 
                                 new                                newli 
                                0.99                                 0.99 
                             newswir                               nimock 
                                0.99                                 0.99 
      nimockshounorthamericamckinsey                                nizat 
                                0.99                                 0.99 
                              nobodi                                  non 
                                0.99                                 0.99 
                                none                               nonrmr 
                                0.99                                 0.99 
                           nontradit                               normal 
                                0.99                                 0.99 
                              norman                           northbrook 
                                0.99                                 0.99 
                           northeast                         northeastern 
                                0.99                                 0.99 
                           northwest                               notabl 
                                0.99                                 0.99 
                              notion                                  nrg 
                                0.99                                 0.99 
                               nstar                              nuclear 
                                0.99                                 0.99 
                               nyiso                                  oak 
                                0.99                                 0.99 
                              obscur                               observ 
                                0.99                                 0.99 
                              offici                               offlin 
                                0.99                                 0.99 
                             offshor                                 ohio 
                                0.99                                 0.99 
                                 oil                                 okla 
                                0.99                                 0.99 
                            oklahoma                            ombudsman 
                                0.99                                 0.99 
                                omin                                  one 
                                0.99                                 0.99 
                            onethird                              oneyear 
                                0.99                                 0.99 
                                ongo                                 onto 
                                0.99                                 0.99 
                                open                                 oper 
                                0.99                                 0.99 
                               oppos                              opposit 
                                0.99                                 0.99 
                                 ore                                 orga 
                                0.99                                 0.99 
                               outag                               outcom 
                                0.99                                 0.99 
                              outpac                               output 
                                0.99                                 0.99 
                            outright                               outsiz 
                                0.99                                 0.99 
                           overbuild                            overcharg 
                                0.99                                 0.99 
                              overdu                               overse 
                                0.99                                 0.99 
                                 own                               oyster 
                                0.99                                 0.99 
                                pace                                pacif 
                                0.99                                 0.99 
                                paid                                 pain 
                                0.99                                 0.99 
                                pale                             parallel 
                                0.99                                 0.99 
                             partial                             partylin 
                                0.99                                 0.99 
                            pasadena                                 pass 
                                0.99                                 0.99 
                              passiv                              patient 
                                0.99                                 0.99 
                                 pay                                payer 
                                0.99                                 0.99 
                             payment                                  pcg 
                                0.99                                 0.99 
                                peak                      pennsylvanianew 
                                0.99                                 0.99 
                             percent                               period 
                                0.99                                 0.99 
                             permiss                            petroleum 
                                0.99                                 0.99 
                                 pge                           phenomenon 
                                0.99                                 0.99 
                              picpcx                               pillar 
                                0.99                                 0.99 
                             pinnacl                               pitfal 
                                0.99                                 0.99 
                                 pjm                                 pjms 
                                0.99                                 0.99 
                               plagu                                 plan 
                                0.99                                 0.99 
                               plane                                plant 
                                0.99                                 0.99 
                                 plc                             pleasant 
                                0.99                                 0.99 
                              plenti                               plight 
                                0.99                                 0.99 
                                plow                                 plug 
                                0.99                                 0.99 
                              pocket                                pocta 
                                0.99                                 0.99 
                                pois                                 pole 
                                0.99                                 0.99 
                               polic                               pollut 
                                0.99                                 0.99 
                        pollutionrel                               polski 
                                0.99                                 0.99 
                                pool                                 pore 
                                0.99                                 0.99 
                             portion                                 pose 
                                0.99                                 0.99 
                             postpon                              potenti 
                                0.99                                 0.99 
                               pound                           powergener 
                                0.99                                 0.99 
                            powerget                               prairi 
                                0.99                                 0.99 
                               prais                                  pre 
                                0.99                                 0.99 
                              preced                            predatori 
                                0.99                                 0.99 
                         preliminari                               presum 
                                0.99                                 0.99 
                            pretextu                                  pri 
                                0.99                                 0.99 
                               price                         pricerespons 
                                0.99                                 0.99 
                         pricesensit                             principl 
                                0.99                                 0.99 
                       privatesector                                  pro 
                                0.99                                 0.99 
                               probe                               produc 
                                0.99                                 0.99 
                              profil                               profit 
                                0.99                                 0.99 
                             program                              prolong 
                                0.99                                 0.99 
                              promin                             pronounc 
                                0.99                                 0.99 
                               proof                              prophet 
                                0.99                                 0.99 
                              propos                                  pru 
                                0.99                                 0.99 
                                 psc                               public 
                                0.99                                 0.99 
                                pull                                 pump 
                                0.99                                 0.99 
                              punish                              purchas 
                                0.99                                 0.99 
                              purpos                             pursuant 
                                0.99                                 0.99 
                                push                                  pwr 
                                0.99                                 0.99 
                                 qfs                              qualifi 
                                0.99                                 0.99 
                             quarter                              questar 
                                0.99                                 0.99 
                             quicken                                quinn 
                                0.99                                 0.99 
                              quinta                                 rail 
                                0.99                                 0.99 
                             rainfal                                raini 
                                0.99                                 0.99 
                                rais                                  ram 
                                0.99                                 0.99 
                            randolph                                 rang 
                                0.99                                 0.99 
                                rare                                 rate 
                                0.99                                 0.99 
                             ratepay                               rattey 
                                0.99                                 0.99 
                                 raw                              realtim 
                                0.99                                 0.99 
                                ream                                 reap 
                                0.99                                 0.99 
                              reason                              reassur 
                                0.99                                 0.99 
                               rebat                                rebuf 
                                0.99                                 0.99 
                              recent                              reclaim 
                                0.99                                 0.99 
                            reconsid                              recruit 
                                0.99                                 0.99 
                                 red                             redesign 
                                0.99                                 0.99 
                             reflect                               refund 
                                0.99                                 0.99 
                          regardless                               region 
                                0.99                                 0.99 
                                 rei                               reilli 
                                0.99                                 0.99 
                            reimburs                                 rein 
                                0.99                                 0.99 
                           reiterman                                relax 
                                0.99                                 0.99 
                          relentless                              relianc 
                                0.99                                 0.99 
                             reliant                               reliev 
                                0.99                                 0.99 
                              remedi                                renew 
                                0.99                                 0.99 
                             renobas                               repaid 
                                0.99                                 0.99 
                              repair                                repay 
                                0.99                                 0.99 
                              repeal                            repercuss 
                                0.99                                 0.99 
                              replac                               replic 
                                0.99                                 0.99 
                              requir                               reserv 
                                0.99                                 0.99 
                              resold                              resourc 
                                0.99                                 0.99 
                            restrain                               result 
                                0.99                                 0.99 
                              revenu                               reward 
                                0.99                                 0.99 
                                 rey                               rhanov 
                                0.99                                 0.99 
                              rhetor                               ribbon 
                                0.99                                 0.99 
                           ridgewood                                 rife 
                                0.99                                 0.99 
                                rise                                risen 
                                0.99                                 0.99 
                           riskavers                                riski 
                                0.99                                 0.99 
                            riversid                         rjacksonvill 
                                0.99                                 0.99 
                                 rla                             rlancast 
                                0.99                                 0.99 
                                 rmr                             robinson 
                                0.99                                 0.99 
                                rock                               rocket 
                                0.99                                 0.99 
                               rocki                                 roil 
                                0.99                                 0.99 
                                rone                            roosevelt 
                                0.99                                 0.99 
                                root                                 rose 
                                0.99                                 0.99 
                            rosemead                                rough 
                                0.99                                 0.99 
                               rreno                                 rule 
                                0.99                                 0.99 
                             runaway                               runner 
                                0.99                                 0.99 
                               runup                                saber 
                                0.99                                 0.99 
                       sacramentobas                                 said 
                                0.99                                 0.99 
                                sale                                salem 
                                0.99                                 0.99 
                                salt                                savag 
                                0.99                                 0.99 
                                save                                 saxl 
                                0.99                                 0.99 
                                 say                             scenario 
                                0.99                                 0.99 
                          schoenherr                               school 
                                0.99                                 0.99 
                                scof                              scrambl 
                                0.99                                 0.99 
                            scrutini                        secondlargest 
                                0.99                                 0.99 
                             secreci                              section 
                                0.99                                 0.99 
                                seek                              segundo 
                                0.99                                 0.99 
                                sell                               sempra 
                                0.99                                 0.99 
                               separ                                  set 
                                0.99                                 0.99 
                               seven                                sever 
                                0.99                                 0.99 
                             severin                            sharehold 
                                0.99                                 0.99 
                            sheffrin                                shelv 
                                0.99                                 0.99 
                            sheppard                                shift 
                                0.99                                 0.99 
                            shipment                              shipper 
                                0.99                                 0.99 
                               shock                              shortag 
                                0.99                                 0.99 
                             shorten                             shortfal 
                                0.99                                 0.99 
                                shot                                 show 
                                0.99                                 0.99 
                              shrink                               shrunk 
                                0.99                                 0.99 
                                shut                             shutdown 
                                0.99                                 0.99 
                              sierra                                 sign 
                                0.99                                 0.99 
                              signal                              similar 
                                0.99                                 0.99 
                               simpl                               simpli 
                                0.99                                 0.99 
                            simultan                                 sinc 
                                0.99                                 0.99 
                                site                             sixmonth 
                                0.99                                 0.99 
                                size                              skeptic 
                                0.99                                 0.99 
                              skygen                                slack 
                                0.99                                 0.99 
                               slate                               slight 
                                0.99                                 0.99 
                                slip                               sloppi 
                                0.99                                 0.99 
                              slower                                small 
                                0.99                                 0.99 
                           smallbusi                             smallest 
                                0.99                                 0.99 
                             smarter                                 smog 
                                0.99                                 0.99 
                              smooth                                 soar 
                                0.99                                 0.99 
                               socal                              softped 
                                0.99                                 0.99 
                               sokol                                solar 
                                0.99                                 0.99 
                                sold                                 solv 
                                0.99                                 0.99 
                             solvenc                              sophist 
                                0.99                                 0.99 
                            sorensen                                south 
                                0.99                                 0.99 
                            southern                            southland 
                                0.99                                 0.99 
                                spar                           specialist 
                                0.99                                 0.99 
                             specifi                              specter 
                                0.99                                 0.99 
                              specul                              spencer 
                                0.99                                 0.99 
                               spent                                spike 
                                0.99                                 0.99 
                              spiral                            spokesman 
                                0.99                                 0.99 
                           spokesmen                          spokeswoman 
                                0.99                                 0.99 
                          spotmarket                               spring 
                                0.99                                 0.99 
                                spur                                  sre 
                                0.99                                 0.99 
                             stagger                                stall 
                                0.99                                 0.99 
                            standard                                state 
                                0.99                                 0.99 
                        stateappoint                              station 
                                0.99                                 0.99 
                             statist                                stave 
                                0.99                                 0.99 
                            steadili                                steam 
                                0.99                                 0.99 
                               steep                              steepli 
                                0.99                                 0.99 
                                stem                              stengel 
                                0.99                                 0.99 
                               stern                                stick 
                                0.99                                 0.99 
                               stifl                                 stop 
                                0.99                                 0.99 
                              storag                               strain 
                                0.99                                 0.99 
                              stride                                strip 
                                0.99                                 0.99 
                             struggl                                stunt 
                                0.99                                 0.99 
                             subsidi                           subsidiari 
                                0.99                                 0.99 
                           substanti                               suffer 
                                0.99                                 0.99 
                             suffici                               summar 
                                0.99                                 0.99 
                           summerlik                               summit 
                                0.99                                 0.99 
                              sunset                             superior 
                                0.99                                 0.99 
                            supplier                               surgic 
                                0.99                                 0.99 
                             surplus                             surround 
                                0.99                                 0.99 
                             suspend                            suspicion 
                                0.99                                 0.99 
                             sustain                               suzann 
                                0.99                                 0.99 
           suzannenimocksmckinseycom                              swelter 
                                0.99                                 0.99 
                              switch                              sympath 
                                0.99                                 0.99 
                              system                                  tab 
                                0.99                                 0.99 
                              tailor                               tamaki 
                                0.99                                 0.99 
                                 tap                                taper 
                                0.99                                 0.99 
                              taxpay                                  tem 
                                0.99                                 0.99 
                          temperatur                              tempest 
                                0.99                                 0.99 
                           temporari                          temporarili 
                                0.99                                 0.99 
                                tend                              tenuous 
                                0.99                                 0.99 
                                 tep                              testifi 
                                0.99                                 0.99 
                           testimoni                                therm 
                                0.99                                 0.99 
                             thermal                               thermo 
                                0.99                                 0.99 
                               third                               thorni 
                                0.99                                 0.99 
                           threshold                             thursday 
                                0.99                                 0.99 
                                 tie                                 time 
                                0.99                                 0.99 
                          timeconsum                                 tini 
                                0.99                                 0.99 
                              togeth                                token 
                                0.99                                 0.99 
                                toll                                 tool 
                                0.99                                 0.99 
                            townsend                                trace 
                                0.99                                 0.99 
                               trade                          transenergi 
                                0.99                                 0.99 
                            translat                             transmit 
                                0.99                                 0.99 
                          transplant                                tread 
                                0.99                                 0.99 
                             treasur                                trend 
                                0.99                                 0.99 
                               trent                                 trim 
                                0.99                                 0.99 
                                tuck                                tulsa 
                                0.99                                 0.99 
                            tulsabas                              turmoil 
                                0.99                                 0.99 
                               twice                                  two 
                                0.99                                 0.99 
                            twothird                                typic 
                                0.99                                 0.99 
                               ultim                              unavail 
                                0.99                                 0.99 
                           uncertain                            uncollect 
                                0.99                                 0.99 
                        undercollect                           underestim 
                                0.99                                 0.99 
                           underscor                             underwat 
                                0.99                                 0.99 
                             undesir                                 undo 
                                0.99                                 0.99 
                                undu                               unfair 
                                0.99                                 0.99 
                              unfett                                unfil 
                                0.99                                 0.99 
                          unforeseen                              uniform 
                                0.99                                 0.99 
                            unintend                                union 
                                0.99                                 0.99 
                               unlaw                                unlik 
                                0.99                                 0.99 
                              unpaid                             unpreced 
                                0.99                                 0.99 
                             unregul                             unseason 
                                0.99                                 0.99 
                              unwarr                                upset 
                                0.99                                 0.99 
                              upstat                               upward 
                                0.99                                 0.99 
                                utah                                 util 
                                0.99                                 0.99 
                      utilitiespacif                         utilitiessan 
                                0.99                                 0.99 
                     utilitiesstrenu                       utilityderegul 
                                0.99                                 0.99 
                              valley                                  van 
                                0.99                                 0.99 
                              vanech                              variabl 
                                0.99                                 0.99 
                             varieti                              various 
                                0.99                                 0.99 
                                vast                             vegasbas 
                                0.99                                 0.99 
                            vehement                        venkateshwara 
                                0.99                                 0.99 
                               venki                             verbatim 
                                0.99                                 0.99 
                                verg                              veteran 
                                0.99                                 0.99 
                             victori                                vigor 
                                0.99                                 0.99 
                              vikram                         villaraigosa 
                                0.99                                 0.99 
                              violat                             virginia 
                                0.99                                 0.99 
                               virtu                                vocal 
                                0.99                                 0.99 
                               vogel                              volatil 
                                0.99                                 0.99 
                              voltag                                volum 
                                0.99                                 0.99 
                              vulner                                wagon 
                                0.99                                 0.99 
                                wake                                walli 
                                0.99                                 0.99 
                                warn                              warrant 
                                0.99                                 0.99 
                              warren                                 weak 
                                0.99                                 0.99 
                           wednesday                        weeklysometim 
                                0.99                                 0.99 
                           wellequip                             wellhead 
                                0.99                                 0.99 
                              whenev                               wherea 
                                0.99                                 0.99 
                             whether                             whitewat 
                                0.99                                 0.99 
                          wholeheart                                widen 
                                0.99                                 0.99 
                            widerang                                 wild 
                                0.99                                 0.99 
                           wilkerson                                 will 
                                0.99                                 0.99 
                             william                              windfal 
                                0.99                                 0.99 
                              winter                               winwin 
                                0.99                                 0.99 
                           wisconsin                              wisvest 
                                0.99                                 0.99 
                                 wit                               within 
                                0.99                                 0.99 
                                 wmb                                 wood 
                                0.99                                 0.99 
                               worri                                 wors 
                                0.99                                 0.99 
                              worsen                               writer 
                                0.99                                 0.99 
                             wrongdo                     wwwlatimescompow 
                                0.99                                 0.99 
                                wyom                                 year 
                                0.99                                 0.99 
                             yearend                               yorker 
                                0.99                                 0.99 
                                zero                              ziegler 
                                0.99                                 0.99 
                                abus                               accord 
                                0.98                                 0.98 
                                 act                            agreement 
                                0.98                                 0.98 
                            although                                among 
                                0.98                                 0.98 
                              amount                                april 
                                0.98                                 0.98 
                               avoid                                 basi 
                                0.98                                 0.98 
                               beach                                began 
                                0.98                                 0.98 
                                 bid                                  big 
                                0.98                                 0.98 
                               build                                  buy 
                                0.98                                 0.98 
                               capac                                claim 
                                0.98                                 0.98 
                            competit                            construct 
                                0.98                                 0.98 
                            contract                            contribut 
                                0.98                                 0.98 
                               court                               critic 
                                0.98                                 0.98 
                                debt                               decemb 
                                0.98                                 0.98 
                               decis                               declin 
                                0.98                                 0.98 
                              differ                                 done 
                                0.98                                 0.98 
                                 due                                 edit 
                                0.98                                 0.98 
                               emerg                              environ 
                                0.98                                 0.98 
                              examin                              exchang 
                                0.98                                 0.98 
                              execut                                  far 
                                0.98                                 0.98 
                            februari                                 file 
                                0.98                                 0.98 
                               first                                 five 
                                0.98                                 0.98 
                               focus                               foster 
                                0.98                                 0.98 
                               fulli                                 give 
                                0.98                                 0.98 
                                hand                                  hot 
                                0.98                                 0.98 
                                hour                                 huge 
                                0.98                                 0.98 
                              impact                               import 
                                0.98                                 0.98 
                            industri                                 issu 
                                0.98                                 0.98 
                             januari                                 keep 
                                0.98                                 0.98 
                               known                                  law 
                                0.98                                 0.98 
                                lose                                  lot 
                                0.98                                 0.98 
                               lower                                 mani 
                                0.98                                 0.98 
                               march                               margin 
                                0.98                                 0.98 
                          marketplac                                  may 
                                0.98                                 0.98 
                              measur                           memorandum 
                                0.98                                 0.98 
                              miller                              monitor 
                                0.98                                 0.98 
                                must                               negoti 
                                0.98                                 0.98 
                              novemb                                often 
                                0.98                                 0.98 
                                 owe                                owner 
                                0.98                                 0.98 
                                part                                parti 
                                0.98                                 0.98 
                                paso                              possibl 
                                0.98                                 0.98 
                             problem                              process 
                                0.98                                 0.98 
                              promis                               prompt 
                                0.98                                 0.98 
                                 puc                                refus 
                                0.98                                 0.98 
                          regulatori                                relat 
                                0.98                                 0.98 
                              repres                              request 
                                0.98                                 0.98 
                               right                                  run 
                                0.98                                 0.98 
                             serious                               servic 
                                0.98                                 0.98 
                            signific                               situat 
                                0.98                                 0.98 
                               sourc                                 spot 
                                0.98                                 0.98 
                              stabil                                staff 
                                0.98                                 0.98 
                               still                              suggest 
                                0.98                                 0.98 
                          supervisor                               though 
                                0.98                                 0.98 
                                took                                total 
                                0.98                                 0.98 
                              toward                             transact 
                                0.98                                 0.98 
                              troubl                                 unit 
                                0.98                                 0.98 
                                 use                                 want 
                                0.98                                 0.98 
                               water                              western 
                                0.98                                 0.98 
                             without                                  yet 
                                0.98                                 0.98 
                                york                              acceler 
                                0.98                                 0.97 
                              actual                            administr 
                                0.97                                 0.97 
                                agre                                ahead 
                                0.97                                 0.97 
                              almost                              alreadi 
                                0.97                                 0.97 
                              appeal                               applic 
                                0.97                                 0.97 
                              associ                                audit 
                                0.97                                 0.97 
                                base                               calpin 
                                0.97                                 0.97 
                                came                                  can 
                                0.97                                 0.97 
                                case                               center 
                                0.97                                 0.97 
                             certain                              commerc 
                                0.97                                 0.97 
                             conclud                           constraint 
                                0.97                                 0.97 
                             consult                              correct 
                                0.97                                 0.97 
                               cover                                 deal 
                                0.97                                 0.97 
                               decad                               declar 
                                0.97                                 0.97 
                            determin                              economi 
                                0.97                                 0.97 
                              effici                               effort 
                                0.97                                 0.97 
                              employ                                enter 
                                0.97                                 0.97 
                               everi                               excess 
                                0.97                                 0.97 
                              expand                              express 
                                0.97                                 0.97 
                                face                                 fall 
                                0.97                                 0.97 
                               figur                              financi 
                                0.97                                 0.97 
                                flaw                                  fpa 
                                0.97                                 0.97 
                                home                               implic 
                                0.97                                 0.97 
                               insid                              instead 
                                0.97                                 0.97 
                            interest                                 lead 
                                0.97                                 0.97 
                                like                                might 
                                0.97                                 0.97 
                              monday                             monopoli 
                                0.97                                 0.97 
                                 net                                 news 
                                0.97                                 0.97 
                                next                              nonpubl 
                                0.97                                 0.97 
                              oregon                               overal 
                                0.97                                 0.97 
                                 per                              pipelin 
                                0.97                                 0.97 
                               posit                              practic 
                                0.97                                 0.97 
                              privat                             properti 
                                0.97                                 0.97 
                               prove                              qualiti 
                                0.97                                 0.97 
                               refer                               remain 
                                0.97                                 0.97 
                               resid                                 rest 
                                0.97                                 0.97 
                               share                               sought 
                                0.97                                 0.97 
                              submit                             threaten 
                                0.97                                 0.97 
                                thus                                 told 
                                0.97                                 0.97 
                                 tri                              twoyear 
                                0.97                                 0.97 
                                user                                  way 
                                0.97                                 0.97 
                                 won                               across 
                                0.97                                 0.96 
                             address                            ancillari 
                                0.96                                 0.96 
                                away                                begin 
                                0.96                                 0.96 
                              behind                               breath 
                                0.96                                 0.96 
                               bring                                buyer 
                                0.96                                 0.96 
                                call                                 ceil 
                                0.96                                 0.96 
                               chang                                clear 
                                0.96                                 0.96 
                             collect                              complet 
                                0.96                                 0.96 
                             complex                            condition 
                                0.96                                 0.96 
                             consequ                              coordin 
                                0.96                                 0.96 
                                corp                               direct 
                                0.96                                 0.96 
                            director                                 duti 
                                0.96                                 0.96 
                             earlier                                emiss 
                                0.96                                 0.96 
                                form                                futur 
                                0.96                                 0.96 
                                 get                                given 
                                0.96                                 0.96 
                                hard                                  hit 
                                0.96                                 0.96 
                            identifi                                illeg 
                                0.96                                 0.96 
                       infrastructur                              inquiri 
                                0.96                                 0.96 
                                just                                 late 
                                0.96                                 0.96 
                               later                                 long 
                                0.96                                 0.96 
                              matter                                 mean 
                                0.96                                 0.96 
                         necessarili                             northern 
                                0.96                                 0.96 
                            procedur                               procur 
                                0.96                                 0.96 
                                 put                               receiv 
                                0.96                                 0.96 
                             respect                              respons 
                                0.96                                 0.96 
                                rush                                  see 
                                0.96                                 0.96 
                               solut                               someth 
                                0.96                                 0.96 
                              spread                                stage 
                                0.96                                 0.96 
                               stand                               tariff 
                                0.96                                 0.96 
                                text                             therefor 
                                0.96                                 0.96 
                               tight                                  top 
                                0.96                                 0.96 
                              trader                              tuesday 
                                0.96                                 0.96 
                                turn                               unless 
                                0.96                                 0.96 
                            withhold                                worth 
                                0.96                                 0.96 
                                 ago                                anoth 
                                0.95                                 0.95 
                              articl                               author 
                                0.95                                 0.95 
                         californian                             consider 
                                0.95                                 0.95 
                               daili                                 data 
                                0.95                                 0.95 
                             describ                              develop 
                                0.95                                 0.95 
                                 end                            experienc 
                                0.95                                 0.95 
                              happen                               inform 
                                0.95                                 0.95 
                              intern                            interview 
                                0.95                                 0.95 
                              joseph                                 kept 
                                0.95                                 0.95 
                           marketbas                                offer 
                                0.95                                 0.95 
                               panel                              proceed 
                                0.95                                 0.95 
                             product                              project 
                                0.95                                 0.95 
                          republican                              sometim 
                                0.95                                 0.95 
                               spend                            statement 
                                0.95                                 0.95 
                                texa                                track 
                                0.95                                 0.95 
                           transport                                 wall 
                                0.95                                 0.95 
                                week                                 west 
                                0.95                                 0.95 
                              afford                                alloc 
                                0.94                                 0.94 
                               along                               appear 
                                0.94                                 0.94 
                            approach                               assess 
                                0.94                                 0.94 
                              burden                               calcul 
                                0.94                                 0.94 
                                cash                                civil 
                                0.94                                 0.94 
                                club                                 coal 
                                0.94                                 0.94 
                              compar                              compens 
                                0.94                                 0.94 
                         connecticut                              definit 
                                0.94                                 0.94 
                                easi                                entir 
                                0.94                                 0.94 
                              entiti                               eventu 
                                0.94                                 0.94 
                                find                               former 
                                0.94                                 0.94 
                                free                                georg 
                                0.94                                 0.94 
                              insist                             investor 
                                0.94                                 0.94 
                                 jay                                labor 
                                0.94                                 0.94 
                              launch                                  llc 
                                0.94                                 0.94 
                              manner                                 mile 
                                0.94                                 0.94 
                               night                                occur 
                                0.94                                 0.94 
                               onlin                               parent 
                                0.94                                 0.94 
                                pend                                peopl 
                                0.94                                 0.94 
                             persuad                                point 
                                0.94                                 0.94 
                               polit                           politician 
                                0.94                                 0.94 
                           portfolio                             previous 
                                0.94                                 0.94 
                               print                             progress 
                                0.94                                 0.94 
                            question                             retroact 
                                0.94                                 0.94 
                               settl                                sharp 
                                0.94                                 0.94 
                               short                                 side 
                                0.94                                 0.94 
                               split                               strict 
                                0.94                                 0.94 
                              suppos                              suspect 
                                0.94                                 0.94 
                               swept                                 take 
                                0.94                                 0.94 
                                term                            transform 
                                0.94                                 0.94 
                                wind                                 work 
                                0.94                                 0.94 
                                abil                                asset 
                                0.93                                 0.93 
                             brought                               compet 
                                0.93                                 0.93 
                             default                                deliv 
                                0.93                                 0.93 
                            elsewher                               especi 
                                0.93                                 0.93 
                               exact                                  fix 
                                0.93                                 0.93 
                             foundat                             individu 
                                0.93                                 0.93 
                            influenc                               island 
                                0.93                                 0.93 
                                 jan                               legisl 
                                0.93                                 0.93 
                               light                                limit 
                                0.93                                 0.93 
                            maintain                            nonprofit 
                                0.93                                 0.93 
                                note                              partner 
                                0.93                                 0.93 
                             primari                               reform 
                                0.93                                 0.93 
                                role                                secur 
                                0.93                                 0.93 
                                 sen                                taken 
                                0.93                                 0.93 
                               today                                  ann 
                                0.93                                 0.92 
                               becam                                 bill 
                                0.92                                 0.92 
                                bush                                  cap 
                                0.92                                 0.92 
                             comment                               detail 
                                0.92                                 0.92 
                           difficult                                 fair 
                                0.92                                 0.92 
                                 fee                             institut 
                                0.92                                 0.92 
                              involv                                  iso 
                                0.92                                 0.92 
                               local                                  met 
                                0.92                                 0.92 
                                move                               number 
                                0.92                                 0.92 
                                past                                place 
                                0.92                                 0.92 
                              presid                              publish 
                                0.92                                 0.92 
                           recommend                               record 
                                0.92                                 0.92 
                              specif                                  tax 
                                0.92                                 0.92 
                                well                                allen 
                                0.92                                 0.91 
                              believ                               commod 
                                0.91                                 0.91 
                           communiti                                  dan 
                                0.91                                 0.91 
                           disclosur                             encourag 
                                0.91                                 0.91 
                               error                                 evid 
                                0.91                                 0.91 
                                ferc                               global 
                                0.91                                 0.91 
                                gone                                initi 
                                0.91                                 0.91 
                               legal                                lynch 
                                0.91                                 0.91 
                              materi                              meantim 
                                0.91                                 0.91 
                              review                                  sat 
                                0.91                                 0.91 
                                soon                                sound 
                                0.91                                 0.91 
                               start                                 talk 
                                0.91                                 0.91 
                               truth                           washington 
                                0.91                                 0.91 
                             announc                              attempt 
                                0.90                                 0.90 
                              commit                              concern 
                                0.90                                 0.90 
                                deni                               enforc 
                                0.90                                 0.90 
                             expedit                               extens 
                                0.90                                 0.90 
                                hold                               morgan 
                                0.90                                 0.90 
                               other                              prevent 
                                0.90                                 0.90 
                              provis                             reaction 
                                0.90                                 0.90 
                               reduc                              schedul 
                                0.90                                 0.90 
                                stay                               street 
                                0.90                                 0.90 
                               unabl 
                                0.90 
```


What else might you do?
===

* Use the `tidytext` package to work in a "tidy" way
* Make more visualizations of word frequencies or relationships in `ggplot2`
* Use hierarchical clustering to group together terms
* Fit topic models to find overarching topics
* Use `NLP` package to find bigrams (two-word phrases)
* Use `qdap` package to classify document sentiment (positive, negative) and look for relationships

(Please social science responsibly!)


Wrapping up the course
===
type: section


What you've learned
===

A lot!

* How to get data into R from a variety of formats
* How to do "data janitor" work to manipulate and clean data
* How to make pretty visualizations
* How to automate with loops and functions
* How to fit linear regression models
* How to combine text, calculations, plots, and tables into dynamic R Markdown reports 


What comes next?
===

* Doing statistical inference
    + Functions for hypothesis testing, hierarchical/mixed effect models, machine learning, survey design, etc. straightforward to use...once data are clean
    + Access output by working with list structures (like with linear regression HW)
* Practice, practice, practice!
    + Replicate analyses you've done in Excel, SPSS, Stata
    + Think about data using `dplyr` verbs, tidy data principles
    + R Markdown for documenting cleaning and analysis start-to-finish
* More advanced
    + Using version control (git) in RStudio
    + Interactive Shiny web apps
    

Thank you!
===
type: section
