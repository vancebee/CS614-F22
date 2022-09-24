library(dplyr)
data = read.csv("data/homeless_survey.csv")
load('data/homeless_survey.RData')
summary(df)

df[,24:171] = data.frame(apply(df[,24:171],2,as.numeric))




class(data$StartDate)


df[,!sapply(df, class) %in% c('integer', 'numeric')]
# contains numbers only






data %>%
  select(char_variables)

class(char_variables)




