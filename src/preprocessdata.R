packages <- c("dplyr", "readr", "tibble")
install.packages(setdiff(packages, rownames(installed.packages())))
lapply(packages, require, character.only = TRUE)

raw_data = read.csv('data/homeless_survey.csv')
data_key = read.csv('data/DataGuide.csv')
# drop rows that don't exist
data_key = data_key %>% filter(ColumnLabel != "A2_6")

# In class activity 1 Reverse code labeling
# this is getting a list of columns. Can be replaced by another function
# for instance names(raw_data[indices])
reverse_code_lables <- data_key %>% filter(ReverseCode) %>%
  select(ColumnLabel)


# could alternately use r's built in [] filter and use lapply to column indices
processed_data <- raw_data  %>% mutate_at(reverse_code_lables$ColumnLabel,
                                    function(x) 6-x)
processed_data %>% select(reverse_code_lables$ColumnLabel)

# In class activity 2 change certain columns to numeric
numeric_labels <- data_key %>% filter(Type == "Scalar") %>%
  select(ColumnLabel)

processed_data <- processed_data  %>% mutate_at(numeric_labels$ColumnLabel, 
                                                as.numeric)

# Àctivity 3
# Collapse columns in to certain factors

# collapse demo info into three categories

# change continuous scale into factor scale
