source('src/preprocessdata.R')

require(lme4)
require(lmerTest)
require(broom.mixed)

df  %>% 
  group_by(A28_6_rgn) %>%
  dplyr::summarise(n = n(), mu = mean(A20_3, na.rm=T)) %>%
  filter(!is.na(A28_6_rgn)) %>%
  ggplot() +
  geom_point(aes(x=A28_6_rgn,y=mu, size=n))


regdf = df %>% filter(A28_2 %in% c('Male','Female'))
dv = 'A6_5'

mod1 = lmer(regdf[,dv] ~ A28_2 + A28_10 + A28_3 + scale(A28_4) + A20_3 + A14_2 + (1|A28_6_rgn), data=regdf,REML=F)

summary(mod1)
plot(density(ranef(mod1)[[1]][,1]))

w = which(is.na(regdf[dv])==F & is.na(regdf$A28_6_rgn)==F)
lmmod = lm(regdf[w,dv] ~ A28_2 + A28_10 + A28_3 + scale(A28_4) + A20_3 + A14_2, data=regdf[w,])


 broom::tidy(lmmod)
AIC(mod1,lmmod)
