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
reverse_code_labels <- data_key %>% filter(ReverseCode) %>%
  select(ColumnLabel)

# use mutate_at to reverse the code label at the specified columns
# could alternately use r's built in [] filter and use lapply to column indices
processed_data <- raw_data  %>% mutate_at(reverse_code_labels$ColumnLabel,
                                    function(x) 6-x)

# In class activity 2 change certain columns to numeric
numeric_labels <- data_key %>% filter(Type == "Scalar") %>%
  select(ColumnLabel)

processed_data <- processed_data  %>% mutate_at(numeric_labels$ColumnLabel, 
                                                as.numeric)

# Àctivity 3
# Collapse columns in to certain factors
# http://derekogle.com/fishR/2018-03-30-Collapsing_Values

# a28_2 3+4
processed_data$A28_2 <- plyr::mapvalues(processed_data$A28_2,
                                        from = c("4"),
                                        to = c("3"))
# a28_3 4+6+7+8
# Drop 4
processed_data$A28_3 <- plyr::mapvalues(processed_data$A28_3,
                                        from = c("4","6","7","8"),
                                        to = c("4","4","4","4"))
# a28_6 drop 2
processed_data$A28_6 <- plyr::mapvalues(processed_data$A28_6,
                                        from = c("2"),
                                        to = c(NA))
# a28_7 3+4
processed_data$A28_7 <- plyr::mapvalues(processed_data$A28_7,
                                        from = c("4"),
                                        to = c("3"))
# a28_8 leave alone
# a28_9 3+4+5
processed_data$A28_9 <- plyr::mapvalues(processed_data$A28_9,
                                        from = c("3","4","5"),
                                        to = c("3","3","3"))
# a28_10 3+4+5+8
processed_data$A28_10 <- plyr::mapvalues(processed_data$A28_10,
                                        from = c("3","4","5", "8"),
                                        to = c("3","3","3","3"))
