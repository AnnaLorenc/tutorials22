## ----setup, include=FALSE---------------------------------------------------------------------
## knitr::opts_chunk$set(echo=TRUE)
## knitr::opts_chunk$set(eval=FALSE)


## ---------------------------------------------------------------------------------------------
## library( tidyverse )


## ---------------------------------------------------------------------------------------------
## covid_data <- read_csv( "https://www.immunophenotype.org/wp-content/uploads/2020/07/2020-06-30flow_sero_cyto__ifnaexport.csv" )
## 
## ##Just in case you cannot access it online
## XXXX
## 
## 
## #How big is this dataset? ###
## covid_data
## 
## #print a useful summary
## glimpse( covid_data )
## 
## nrow( covid_data )
## ncol( covid_data )
## 


## ---------------------------------------------------------------------------------------------
## covid_data[ 1:3, c( 1, 4, 55 ) ]
## 
## #what type is data in the columns Clinical_sample and `B_01/CD45_01 |freq` ?
## covid_data[ 1:3, "Clinical_sample" ]
## 
## #But you can also access specific column with the operator $ ( as for list ). #type covid_data$ and hit tab - RStudio will suggest you options
## 
## #Additional_point
## #Have a look on column names of covid_data. Some of them contain 'forbidden' characters - spaces, "|". When using them, you will need to quote them in "" or in `` ( depending on context )
## 


## ---------------------------------------------------------------------------------------------
## 
## b <- 1:10
## 
## 
## b %>%             #take b
##  .[ 1:4 ] %>%     # take first 4 elements of b
##  mean( . ) %>%    #compute a mean
##  + 3 %>%          #add 3
## paste( "result is", . ) %>% #add text
##  print( )
## 
## 
## #This is the same as:
## print( paste ( "result is", mean( b[ 1:4 ] ) + 3 ) )
## 
## #what will be the result of this operation?
## a <- 4
## 
## a %>%
##  sqrt( ) %>%
##  .^2
## 


## ---- eval=FALSE------------------------------------------------------------------------------
## 
## #prepare a smaller table with columns "T_01/CD45_01 |freq" and "Memory_B_01/B_01 |freq"
## covid_data %>%
##  select( "Clinical_sample", "T_01/CD45_01 |freq", "Memory_B_01/B_01 |freq" )
## 
## #Now changing column order
## covid_data %>%
##  select( "T_01/CD45_01 |freq", "Memory_B_01/B_01 |freq", "Clinical_sample" )
## 
## #With tibbles, quotes around well formed names are unnecessary. Names with spaces, / and other bad characters require backticks `` or quotes ( "" or '' ). Check what are the rules for good names in R (no spaces/special characters, do not start from number)
## 
## covid_data %>%
##  select( Clinical_sample, `T_01/CD45_01 |freq`, `Memory_B_01/B_01 |freq` )
## 
## 
## #Find all samples with less than 10% of T cells in CD45 cells
## covid_data %>%
##  select( Clinical_sample, `T_01/CD45_01 |freq` ) %>%
##  filter( `T_01/CD45_01 |freq` < 0.1 )
## 
## 
## #Find frequencies of T and B cells for sample "p028n01" ( this is 'patient 28, sample 1' )
## covid_data %>%
##  select( Clinical_sample, `T_01/CD45_01 |freq`, `Memory_B_01/B_01 |freq` ) %>%
##  filter( Clinical_sample == "p028n01" )
## 
## ###(1)
## ###Now you. How many samples has patient p001? Add missing parts of the code
## ###
## #covid_data
## # filter( )
## 
## 


## ----elective_part----------------------------------------------------------------------------
## #Merge sample information with clinical information, joining two tables by patient ids. From the big table above we are taking only columns NOT containing MFI measurements or derived values ( frequencies, ratios ) cell
## 
## 
## patient_info <- read_csv( "data/20-07-25patients_metadatav2.csv" )
## 
## columns_to_take_from_big_data <- colnames( covid_data ) %>%grep( pattern = "Median|Ratio|freq", value = TRUE, invert = T )
## 
## covid_data_annotated <- covid_data %>%
##  select( Clinical_sample, patient_id, columns_to_take_from_big_data ) %>%
##  left_join( patient_info, ., by = c( "patient_id" ) )
## 
## write_csv( covid_data_annotated, file = "data/covid_data_annotated.csv" )
## 


## ---------------------------------------------------------------------------------------------
## covid_data_annotated <- read_csv( "data/covid_data_annotated.csv" )
## 
## colnames( covid_data_annotated )
## 
## #Select a subset of columns, giving them handy names.
## 
## #columns to choose: "Time_03/Cells_03/Singlets1_03/Singlets2_03/Live_03/CD45p_03/T_03/CD3p_gdn_03/CD4_03 | Count_back"
## # "Time_03/Cells_03/Singlets1_03/Singlets2_03/Live_03/CD45p_03/T_03/CD3p_gdn_03/CD8_03 | Count_back"
## 
## 
## covid_data_annotated_small <- covid_data_annotated %>%
##  select( Clinical_sample, patient_id, sex, age, status = class_dss,
##    CD4 = "Time_03/Cells_03/Singlets1_03/Singlets2_03/Live_03/CD45p_03/T_03/CD3p_gdn_03/CD4_03 | Count_back",
##    CD8 = "Time_03/Cells_03/Singlets1_03/Singlets2_03/Live_03/CD45p_03/T_03/CD3p_gdn_03/CD8_03 | Count_back" )
## 
## 


## ---------------------------------------------------------------------------------------------
## 
## #Ad a new column: with ratio of CD4 cells to CD8 cells
## covid_data_annotated_small <- covid_data_annotated_small %>%
##  mutate( CD4_CD8_ratio = CD4/CD8 )
## 


## ---------------------------------------------------------------------------------------------
## #summarise: what summarie
## covid_data_annotated_small %>%
##  summarise( mean_CD4 = mean( CD4 ),
##    mean_CD8 = mean( CD8 ),
##    median_CD4 = median( CD4 ),
##    median_CD8 = median( CD8 ),
##    max_ratio = max( CD4_CD8_ratio ),
##    min_ratio = min( CD4_CD8_ratio ),
##    N = n( ), individuals = n_distinct( patient_id ) )
## 
## #This did not work as intended -  this is because many functions require special dealing with missing values ( NA ). For many, it requires a special argument na.rm = T
## 
## covid_data_annotated_small %>%
##  summarise( mean_CD4 = mean( CD4, na.rm = T ),
##    mean_CD8 = mean( CD8, na.rm = T ),
##    median_CD4 = median( CD4, na.rm = T ),
##    median_CD8 = median( CD8, na.rm = T ),
##    max_ratio = max( CD4_CD8_ratio, na.rm = T ),
##    min_ratio = min( CD4_CD8_ratio, na.rm = T ),
##    N = n( ), individuals = n_distinct( patient_id ) )
## 


## ---------------------------------------------------------------------------------------------
## #Group by sex and perform the same calculations as before
##  covid_data_annotated_small %>%
##  group_by( sex ) %>%
##  summarise( mean_CD4 = mean( CD4, na.rm = T ),
##    mean_CD8 = mean( CD8, na.rm = T ),
##    median_CD4 = median( CD4, na.rm = T ),
##    median_CD8 = median( CD8, na.rm = T ),
##    max_ratio = max( CD4_CD8_ratio, na.rm = T ),
##    min_ratio = min( CD4_CD8_ratio, na.rm = T ),
##    N = n( ), individuals = n_distinct( patient_id ) )
## 
## #Now the same, but group by sex and disease status
## covid_data_annotated_small %>%
##  group_by( sex, status ) %>%
##  summarise( mean_CD4 = mean( CD4, na.rm = T ),
##    mean_CD8 = mean( CD8, na.rm = T ),
##    median_CD4 = median( CD4, na.rm = T ),
##    median_CD8 = median( CD8, na.rm = T ),
##    max_ratio = max( CD4_CD8_ratio, na.rm = T ),
##    min_ratio = min( CD4_CD8_ratio, na.rm = T ),
##    N = n( ), individuals = n_distinct( patient_id ) )
## 
## ###(2)
## ###Now you: fill in the code. Count number of samples per individual ( group by individual and use n( ) ).
## ###
## covid_data_annotated_small  XXXX
##  group_by( XXXX) %>%
##  summarise( N = XXXX)
## 
## # What was the biggest number of samples per individual?
## covid_data_annotated_small  XXXX
##  group_by( sex, status ) %>%
##  summarise( N = XXXX) %>%
##  summarise ( max_no_of_samples =XXXX )
## 


## ---------------------------------------------------------------------------------------------
## 
## covid_data_annotated_small %>%
##  ggplot( ) +
##  geom_point( aes( x = age, y = CD4, col = sex ) )
## 
## #Now the same, but plotting as boxplots
## covid_data_annotated_small %>%
##  ggplot( ) +
##  geom_boxplot( aes( x = age, y = CD4, fill = sex ) )
## 
## ###(3)
## ###Now you. Plot CD8s by status
## ###
## 
## 


## ----extension_lapply-------------------------------------------------------------------------
## 
## 
## my_list <- list( 1:3, 4:8, 0:2 )
## lapply( list( 1:3, 4:8, 0:2 ), max )  #computes max of each list element and returns a list with results
## 
## #You can use a ready-made function or make your own:
## add_flower <- function( word ){
##  paste( word, "flower" )
## }
## 
## lapply( 1:3, add_flower )
## 
## 
## 

