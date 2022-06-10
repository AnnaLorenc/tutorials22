
## Suggested R courses and materials

### Installation
Install R on your computer from [CRAN](https://cran.r-project.org/)

Install RStudio from [R Studio, choose open source version](https://www.rstudio.com/products/rstudio/)

Biology-specific packages are mostly at [Bioconductor](https://bioconductor.org/). All packages there have vignettes with examples of use.  Also home to field-specific workflows, support groups etc.

### R courses
Software/Data Carpentries are generally highly recommended  
[Software Carpentry R course 1](http://swcarpentry.github.io/r-novice-inflammation/)  
[Software Carpentry R course 2](https://software-carpentry.org/)  
[Data Carpentry R courses](https://datacarpentry.org/ )  
[More in depth course with videos by adventures-in-r](https://www.adventures-in-r.com)  
[Babraham Institute collection of general/more specialised R courses](https://www.bioinformatics.babraham.ac.uk/training.html) - tidyverse, ggplot2, shiny  
[Well structured intro to basic R](https://github.com/matloff/fasteR)  
[Exhaustive and enjoyable book about modern R - 'R for Data Science'](https://r4ds.had.co.nz/index.html)  
A very thorough collection of links about R, computational biology etc. from  [Jarek Bryk](https://github.com/jarekbryk/compbioftw)

---------

## Functions
### Object creation
`c()`  
`list()`  
`matrix()`  
`data.frame()`   
`tibble()`   

### Reading in and writing out the data
`read.table()`,`read.csv()`, `readr::read_tsv()`, `readr::read_csv()`  
`readxl::read_excel()` (possible to specify sheets and locations)  
`readRDS()`, `readr::read_rds()`  

See package _googlesheets4_ for reading in googlesheets

Writing out: change `read` to `write` (except `saveRDS()`)  

Graphics: `pdf()`, `jpeg()` + any type of plot + `dev.off()`
`ggsave()` for ggplot2 plots  

## Investigating objects
`str()`,`glimpse()`  
`length()`,`dim()`, `nrow()`, `ncol()`  
`names()`, `class()`  

## Accessing objects
OBJECT[INDEX], OBJECT[NAME]  
OBJECT[INDEX,INDEX], OBJECT[NAME,NAME] (data.frame, matrix)  
OBJECT[[INDEX]], OBJECT[[NAME]], OBJECT$NAME (list, data.frame)  
OBJECT@SLOT (object from a S4 class)  

## Workspace
`ls()` without argument 
`rm()`



## Data object types 
`vector`  
`list`  
`matrix`  
`data frame`  
`tibble`  

## Tidyverse data wrangling functions
`filter()` -->selection of rows  
`select()` -->selection of columns  
`mutate()`  
`summarise()`  
`n()`, `n_distinct()`  
`pivot_longer()`, `pivot_wider()` -->change shape
`left_join()`, `inner_join()`, `full_join()` --> join tibbles by common column(s)
`group_by`, `group_split()`,  `ungroup()`,`rowwise()`

## R packages
`install.packages()`
`library()`


_tidyverse_ ( _dplyr_, _ggplot2_, _readr_, _readxl_ ...)  
_emojis_ (just for fun)  

_Biostrings_  
_GenomicRanges_  
...
