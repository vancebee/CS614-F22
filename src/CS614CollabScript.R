library(dplyr)

###Load Data and Data Guide
load('data/homeless_survey.RData')
dg = read.csv('data/DataGuide.csv')

###Convert select (nearly all) variables to numeric 
vars2num = dg$ColumnLabel[dg$Type != 'Character'] #All vars from data guide that are not character 
vars2num = c('Progress','Duration..in.seconds.',vars2num) #might use Progress and Duration

df[,vars2num] = apply(df[,vars2num],2,as.numeric)
str(df)






