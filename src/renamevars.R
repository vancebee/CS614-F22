# MTurk Preprocessing Code

####Clear Environment#####
rm(list=ls())

###############################################################################
#####Loading and Formatting Data###############################################
###############################################################################

wd = 'C:\\Users\\berardi\\Dropbox (Chapman)\\Teaching\\CS614\\Homeless Data'
setwd(wd)

df <- read.csv('homeless_survey_b4rename.csv', header=TRUE)

df$A1_1 = df$Q3
df$A2_1 = df$QID6_1
df$A2_2 = df$Q10_1
df$A2_3 = df$Q10_2
df$A2_4 = df$Q10_3
df$A2_5 = df$Q10_4
df$A2_6 = df$Q10_5
df$A3_1 = df$Q12_1
df$A3_2 = df$Q12_2
df$A4_1 = df$Q14_1
df$A5_1 = df$QID12_1
df$A5_2 = df$QID12_2
df$A5_3 = df$QID12_3
df$A5_4 = df$QID12_4
df$A5_5 = df$QID12_5
df$A5_6 = df$Q22_1
df$A5_7 = df$Q22_2
df$A5_8 = df$Q22_3
df$A5_9 = df$Q22_4
df$A5_10 = df$Q22_5
df$A5_11 = df$Q24_1
df$A5_12 = df$Q24_2
df$A5_13 = df$Q24_3
df$A5_14 = df$Q24_4
df$A5_15 = df$Q24_5
df$A5_16 = df$Q26_1
df$A5_17 = df$Q26_2
df$A5_18 = df$Q26_3
df$A5_19 = df$Q26_4
df$A5_20 = df$Q26_5
df$A5_21 = df$Q28_1
df$A5_22 = df$Q28_2
df$A5_23 = df$Q28_3
df$A5_24 = df$Q28_4
df$A5_25 = df$Q28_5
df$A6_1 = df$Q30_1
df$A6_2 = df$Q30_2
df$A6_3 = df$Q30_3
df$A6_4 = df$Q30_4
df$A6_5 = df$Q30_5
df$A6_6 = df$Q30_6
df$A7_1 = df$Q34_1
df$A7_2 = df$Q34_2
df$A7_3 = df$Q34_3
df$A7_4 = df$Q34_4
df$A7_5 = df$Q34_5
df$A7_6 = df$Q34_6
df$A7_7 = df$Q34_7
df$A7_8 = df$Q34_8
df$A7_9 = df$Q34_9
df$A7_10 = df$Q36_1
df$A7_11 = df$Q36_2
df$A7_12 = df$Q36_3
df$A7_13 = df$Q36_4
df$A7_14 = df$Q36_5
df$A7_15 = df$Q36_6
df$A7_16 = df$Q36_7
df$A7_17 = df$Q36_8
df$A7_18 = df$Q36_9
df$A7_19 = df$Q38_1
df$A7_20 = df$Q38_2
df$A7_21 = df$Q38_3
df$A7_22 = df$Q38_4
df$A7_23 = df$Q38_5
df$A7_24 = df$Q38_6
df$A7_25 = df$Q38_7
df$A7_26 = df$Q38_8
df$A7_27 = df$Q38_9
df$A8_1 = df$QID23_1
df$A8_2 = df$QID23_2
df$A8_3 = df$QID23_3
df$A8_4 = df$QID23_4
df$A8_5 = df$QID23_5
df$A8_6 = df$QID23_6
df$A8_7 = df$QID23_7
df$A8_8 = df$QID23_8
df$A9_1 = df$QID25_1
df$A9_2 = df$QID25_2
df$A9_3 = df$QID25_3
df$A9_4 = df$QID25_4
df$A9_5 = df$QID25_5
df$A9_6 = df$QID25_6
df$A9_7 = df$Q48_1
df$A9_8 = df$Q48_2
df$A9_9 = df$Q48_3
df$A9_10 = df$Q48_4
df$A9_11 = df$Q48_5
df$A9_12 = df$Q48_6
df$A9_13 = df$Q50_1
df$A9_14 = df$Q50_2
df$A9_15 = df$Q50_3
df$A9_16 = df$Q50_4
df$A9_17 = df$Q50_5
df$A9_18 = df$Q50_6
df$A9_19 = df$Q52_1
df$A9_20 = df$Q52_2
df$A9_21 = df$Q52_3
df$A9_22 = df$Q52_4
df$A9_23 = df$Q52_5
df$A9_24 = df$Q52_6
df$A9_25 = df$Q52_7
df$A10_1 = df$Q54_1
df$A10_2 = df$Q54_2
df$A10_3 = df$Q56_1
df$A11_1 = df$QID32_1
df$A11_2 = df$QID32_2
df$A12_3 = df$Q62_1
df$A13_1 = df$Q64_1
df$A13_2 = df$Q64_2
df$A14_1 = df$Q66_1
df$A14_2 = df$Q66_2
df$A14_3 = df$Q66_3
df$A14_4 = df$Q66_4
df$A14_5 = df$Q66_5
df$A15_1 = df$Q68_1
df$A15_2 = df$Q68_2
df$A16_1 = df$Q70_1
df$A16_2 = df$Q72_1
df$A17_1 = df$Q74
df$A18_1 = df$Q76_1
df$A19_1 = df$Q78_1
df$A19_2 = df$Q80_1
df$A19_3 = df$Q82_1
df$A19_4 = df$Q84_1
df$A20_1 = df$Q86_1
df$A20_2 = df$Q88_1
df$A20_3 = df$Q88_2
df$A20_4 = df$Q88_3
df$A20_5 = df$Q88_4
df$A20_6 = df$Q88_5
df$A21_1 = df$Q90_1
df$A22_1 = df$Q92_1
df$A22_2 = df$Q92_2
df$A23_1 = df$Q94_1
df$A24_1 = df$Q96
df$A25_1 = df$Q98
df$A25_2 = df$Q100
df$A25_3 = df$Q102
df$A26_1 = df$Q106_1
df$A27_1 = df$QID57
df$A27_2 = df$QID58
df$A28_1 = df$QID59
df$A28_2 = df$QID60
df$A28_3 = df$Q118
df$A28_4 = df$Q120
df$A28_5 = df$Q126
df$A28_6 = df$Q74.1
df$A28_7 = df$Q128
df$A28_8 = df$Q130
df$A28_9 = df$Q132
df$A28_10 = df$Q134
df$A29_1 = df$QID70
df$A29_2 = df$QID71
df$A29_3 = df$Q142
df$A30_1 = df$Q172

#Delete old Q#s
colnames(df)
df = subset(df, select = -c(18:176))

#Delete rows 1 & 2
df = df[-(1:2),]

df[,c(4,14,15)] = ''

save(df,file = '.\\CS614-F22\\data\\homeless_survey.RData')

# write.csv(df, file = '.\\CS614-F22\\data\\homeless_survey.csv', row.names = F)