
packages <- c("dplyr", "readr", "tibble")
install.packages(setdiff(packages, rownames(installed.packages())))
lapply(packages, require, character.only = TRUE)
source('src/plotter.R', 'src/preprocess.R')

###Load Data and Data Guide
load('data/homeless_survey.RData')
dg = read.csv('data/DataGuide.csv')

###Convert select (nearly all) variables to numeric 
vars2num = dg$ColumnLabel[dg$Type != 'Character'] #All vars from data guide that are not character 
vars2num = c('Progress','Duration..in.seconds.',vars2num) #might use Progress and Duration

df[,vars2num] = apply(df[,vars2num],2,as.numeric)
str(df)

### Logic for excluding observations that didn't answer attention  
### checks as expected
### trust_obs == 1 (we keep this row)
### trust_obs == 0 (we drop this row)
df$trust_obs = df %>% select(A5_8, A7_17, A9_12, A29_1, A29_2, A29_3) %>%
  mutate(A5_8_b = case_when(A5_8 == '1' ~ 1, TRUE ~ 0),
         A7_17_b = case_when(A7_17 == '4' ~ 1, TRUE ~ 0),
         A9_12_b = case_when(A9_12 == '5' ~ 1, TRUE ~ 0),
         A29_1_b = case_when(A29_1 == '1' ~ 1, TRUE ~ 0),
         A29_2_b = case_when(as.numeric(A29_2) > 2 ~ 1, TRUE ~ 0),
         A29_3_b = case_when(A29_3 == '2' ~ 1, TRUE ~ 0)) %>% 
  group_by(A5_8_b, A7_17_b, A9_12_b, A29_1_b, A29_2_b, A29_3_b) %>% 
  mutate(att_checks=A5_8_b+A7_17_b+A9_12_b, trust_data=A29_1_b+A29_2_b+A29_3_b) %>% 
  mutate(type = case_when(att_checks >= 2 & trust_data >= 2 ~ 1, TRUE ~ 0))