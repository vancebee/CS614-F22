source('src/preprocessdata.R')

require(broom)

#################1. t-tests #######################
#Does estimated % of homeless that are white differ by gender
df %>% filter(A28_2 %in% c('Male','Female')) %>% 
       t.test(A14_1~A28_2, data=.)

#Does estimated % of total population that are white (A2_2) differ from estimated %
# of homeless population that are white (A14_1)
t.test(df$A2_2, df$A14_1)

#################2. ANOVA#######################
#Do estimates of homeless drug use differ by political ideology (A28_10)
vars = colnames(df)[143:148]
for(ii in vars){
  print(ii)
  mod = aov(df[,ii]~A28_10, data=df)
  print(tidy(mod)$p.value[1])
}

#Tukey pair-wise comparisons for use of cocainec/crack
m1 = aov(A20_3~A28_10, data=df)
TukeyHSD(m1)

#################3. Chi-Square#######################
#Does opinion on whether gov't spends enough on homeless (A10_3)
#differ by gender or politcal ideology
df2 = df %>% filter(A28_2 %in% c('Male','Female'))
  
tt1 = table(df2$A28_2,df2$A10_3)
chisq.test(tt1)

tt2 = table(df$A28_10,df$A10_3)
chisq.test(tt2)


#################4. Correlation#######################
#Is there a correlation between estimates of race of homeless population 
# and estimates of homeless cocaine/crack use

#Repeat with Kendall 
#For lifetime drug use, change A20_3 to A20_1

racevars = paste0("A14_",1:5)

for(ii in racevars){
  print(ii)
  print(cor(df[,ii],df$A20_1,use = "complete.obs"))
  # print(cor(df[,ii],df$A20_1,use = "complete.obs", method = 'kendall'))
}