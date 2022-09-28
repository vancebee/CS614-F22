source('src/preprocessdata.R')

#####Solutions to 1-3 on Lecture 4 Hands-On Activity#####

#1#

df %>% ggplot() + geom_histogram(aes(A24_1))

df %>% filter(A24_1<500000) %>% 
  ggplot() + 
  geom_histogram(aes(A24_1))

df %>% filter(A24_1<25000) %>% 
  ggplot(aes(x=A24_1)) + 
  geom_histogram(bins = 12, boundary = 0, color = 'black', fill = 'grey')

# df %>% filter(A24_1<25000) %>% 
#   ggplot(aes(x=A24_1)) + 
#   geom_histogram(aes(y = ..density..), bins = 12, boundary = 0, color = 'black', fill = 'grey')+
#   geom_density(line = 'cyan',fill = 'cyan', alpha = 0.3)

# ggsave(file = '..\\hist.jpg')

#2#

df %>% 
  filter(!is.na(A28_9)) %>%
  ggplot(aes(x=A23_1)) + 
  geom_density(aes(col = A28_9), alpha = 0.25)

# ggsave('..\\density.jpg')

#3#

df %>% 
  mutate(sdmr = rowMeans(select(df, A8_1:A8_8),na.rm=T)) %>%
  group_by(A7_20) %>%
  dplyr::summarize(mu = mean(sdmr, na.rm=T)) %>%
  ggplot(aes(x = A7_20, y = mu)) + 
  geom_bar(stat='identity') + 
  geom_text(aes(label = round(mu,2)), stat='identity',vjust=-0.2) + 
  ylim(0,3.4)

# ggsave(file = '..\\bar.jpg')