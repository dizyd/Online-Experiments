# This codes loads data exported from JATOS # and creates a tidy data.frame
# Code mostly from: https://labjs.readthedocs.io/en/latest/learn/deploy/3c-jatos.html
# Last updated: 05.05.2021


# load packages

library(tidyverse)
library(jsonlite)


# Read in data
data0 <- read_file('files/jatos_results_20210505121959.txt') %>% # Read the text file from JATOS ...
          str_split('\n') %>% first() %>%   # ... split it into lines ...
          discard(function(x) x == '') %>%   # ... filter empty rows ...
          map_dfr(fromJSON, flatten=T) # ... parse JSON into a data.frame 

# Optionally save the resulting dataset without SONA-ID
write_csv2(data0 %>% select(-SONA_ID), "files/data_raw_rulexjquick.csv")



# Prepare data.frame
data <- data %>% 
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
          filter(sender %in% c("trial"))  # filter out everything except the trial sender
                          


# Safe SONA Data (the labJS form was called still called prolific_ID here in this example)
SONA <- data %>% select(SONA_ID = prolific_ID) %>% distinct()
write_csv2(SONA,"files/SONA.csv")



# Safe tidy data
data <- data %>% select(-SONA_ID = prolific_ID)
write_csv2(data, "files/data_tidy.csv")

