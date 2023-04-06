# This codes loads data exported from JATOS  and creates a tidy data.frame
# Code mostly from: https://labjs.readthedocs.io/en/latest/learn/deploy/3c-jatos.html
# Last updated: 18.06.2021


# load packages
library(tidyverse)
library(jsonlite)

# load function to create readme
devtools::source_url("https://github.com/dizyd/functions/blob/master/make_readme_fun.R?raw=TRUE")


# Define Study name
study <- "test"

# Read in data
data0 <- read_file('files/jatos_results_20210505121959.txt') %>% # Read the text file from JATOS ...
          str_split('\n') %>% first() %>%   # ... split it into lines ...
          discard(function(x) x == '') %>%   # ... filter empty rows ...
          map_dfr(fromJSON, flatten=T) # ... parse JSON into a data.frame 

# Optionally save the resulting data set without Prolific-ID
write_csv2(data0 %>% select(-Prolific_ID), paste0("2 Data/data_raw_",study,".csv"))



# Prepare data.frame
data <- data0 %>% 
          filter(sender %in% c("1 Welcome","Consent6",  # keep only rows with useful information -> filter by sender 
                               "trial","demo2","demo3",
                               "demo3_rule","demo4",
                               "SONA_ID"))   %>% 
          select(ID = url.srid, # select ( & rename) only variables of interest
                 sender, 
                 condition,
                 consent:trial,age:prolific_ID) %>% # from variable consent to variable trial
          fill(ID,.direction = "down") %>%  # check if this works, i.e. the ID is in the first row of each person  
          group_by(ID) %>%  #group by ID for the next command
          fill(condition:prolific_ID,.direction = "downup")   %>% 
          filter(sender %in% c("trial")) %>%   # filter out everything except the trial sender
          select(ID,consent,condition,block,trial,trial_ID,cue1:cue4,criterion,judgment,age,gender,qc,prolific_ID)
                          


#IF SONA-ID in extra file: Safe SONA Data (the labJS form was called still called prolific_ID here in this example)
# SONA <- data %>% select(SONA_ID = prolific_ID) %>% distinct()
# write_csv2(SONA,"files/SONA.csv")



# Safe tidy data without Prolific ID
data <- data %>% select(-prolific_ID)
write_csv2(data, paste0("2 Data/data_tidy_",study,".csv"))




# Create Readme.txt
make_df_readme(df   = data,
               desc = c("unique numeric participant ID",
                        "if participant gave consent",
                        "condition [rule,exemplar]",
                        "block number [1-2]",
                        "trial number [1-24]",
                        "numeric ID of stimulus shown in the corresponding trial",
                        "value of cue 1",
                        "value of cue 2",
                        "value of cue 3",
                        "value of cue 4",
                        "true criterion value of the stimulus",
                        "judgment of the participant [scale: 0-100]",
                        "age of the participant in years",
                        "gender of the participant",
                        "data quality question (i.e., 'should we use your data?')"),
               info = "Data of the pilot study accessing free word associations",
               file = paste0("readme_",study,".txt"))
