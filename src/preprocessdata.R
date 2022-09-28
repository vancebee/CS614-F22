###Packages
rm(list=ls())

packages <- c('dplyr', 'plyr', 'readr', 'tibble', 'stringr', 'ggplot2',
              'reshape2')
lapply(packages, require, character.only = TRUE)

###Load Data and Data Guide
load('data/homeless_survey.RData')
dg = read.csv('data/DataGuide.csv')

######################################################
###########HANDS ON ACTIVITY: LECTURE 2###############
######################################################

#####Convert select  variables to numeric
vars2num = dg$ColumnLabel[dg$Type != 'Character'] #Select all non-character vars
vars2num = c('Progress','Duration..in.seconds.',vars2num) #might use Progress and Duration

df[,vars2num] = apply(df[,vars2num],2,as.numeric)
str(df)

#####Reverse coding select variables

to_be_recoded <- dg %>% filter(ReverseCode) %>%
  select(ColumnLabel)

df = df  %>% mutate_at(to_be_recoded$ColumnLabel,
                                    function(x) 6-x)

#####Collapse categories of select demographic variables

#Merge 'nonbinary' and 'prefer not to say'gender selection
df$A28_2 <- plyr::mapvalues(df$A28_2,
                                        from = c("4"),
                                        to = c("3"))

#Create White (1), Hispanic (2), Black (3), Asian (5) & Other (4) Ethnicity 
df$A28_3 <- plyr::mapvalues(df$A28_3,
                                        from = c("4","6","7","8"),
                                        to = c("4","4","4","4"))

#Merge rarely & never levels for frequency see homeless
df$A28_7 <- plyr::mapvalues(df$A28_7,
                                        from = c("4"),
                                        to = c("3"))

#Merge independent, other, and non/apolitical levels
df$A28_9 <- plyr::mapvalues(df$A28_9,
                                        from = c("3","4","5"),
                                        to = c("3","3","3"))

#Create extermely liberal(1), liberal (2), moderate (3), cons.(4), and extremely conservative
df$A28_10 <- plyr::mapvalues(df$A28_10,
                                        from = c("3","4","5", "8"),
                                        to = c("3","3","3","3"))

######################################################
###########HANDS ON ACTIVITY: LECTURE 3###############
######################################################

#####Clean Free Response County Variable

df$A28_6[!is.na(as.numeric(df$A28_6))] = NA #Turn numeric responses into NA
df['A28_6'] = lapply(lapply(df['A28_6'], tolower), str_trim) #make lower case

countylist = lapply(lapply(c(NA, "Alameda "," Alpine "," Amador "," Butte "," Calaveras "," Colusa "," Contra Costa "," Del Norte "," El Dorado "," Fresno "," Glenn "," Humboldt "," Imperial "," Inyo "," Kern "," Kings "," Lake "," Lassen "," Los Angeles "," Madera "," Marin "," Mariposa "," Mendocino "," Merced "," Modoc "," Mono "," Monterey "," Napa "," Nevada "," Orange "," Placer "," Plumas "," Riverside "," Sacramento "," San Benito "," San Bernardino "," San Diego "," San Francisco"," San Joaquin "," San Luis Obispo "," San Mateo "," Santa Barbara "," Santa Clara "," Santa Cruz "," Shasta "," Sierra "," Siskiyou "," Solano "," Sonoma "," Stanislaus "," Sutter "," Tehama "," Trinity "," Tulare "," Tuolumne "," Ventura "," Yolo "," Yuba "), str_trim), tolower)
remlist = c(NA, "", "texas","american", "america", "ca", "california", "calfornia", "nevada", "no", "not currently in california", "unite states american", "united state", "united states", "united states of america", "us", "usa", "yes")

#Turn remlist into NAs and take first two words from response. Remove unecessary suffixes
for (x in 1:length(df$A28_6)){
  if (df$A28_6[x] %in% remlist){
    df$A28_6[x]= NA}
  else{
    if(grepl(" ",df$A28_6[x])){
      df$A28_6[x] =word(df$A28_6[x], 1,2)
    }
    else{
      df$A28_6[x] = word(df$A28_6[x], 1)
    }}
  
  
  df$A28_6[x]= str_remove(df$A28_6[x], "california")
  df$A28_6[x]= str_remove(df$A28_6[x], ",")
  df$A28_6[x]= str_remove(df$A28_6[x], "county")
  df$A28_6[x]= str_remove(df$A28_6[x], " ca")
  
  if (!df$A28_6[x] %in% countylist){
    print(df$A28_6[x])
  }
}

#Assign responses that listed cities to the proper county
df['A28_6'] = lapply(lapply(df['A28_6'], tolower), str_trim)
df$A28_6[df$A28_6 == "la"] = "los angeles"

#map cities
df$A28_6[df$A28_6 %in% c("campbell")] = "santa clara"
df$A28_6[df$A28_6 %in% c("hesperia", "hesper", "upland")] = "san bernardino"
df$A28_6[df$A28_6 %in% c("north ridge", "northridge", "la puenete", "el monte", "tujunga", "glendale", "west covina", "castaic", "bell gardens")] = "los angeles"
df$A28_6[df$A28_6 %in% c("anaheim", "mission viejo")] = "orange"
df$A28_6[df$A28_6 %in% c("moreno valley", "calimesa", "murrieta")] = "riverside"
df$A28_6[df$A28_6 %in% c("oakdale", 'riverbank')] = "stanislaus"
df$A28_6[df$A28_6 %in% c("lakeside", "vista", "eljon", "chula vista")] = "san diego"
df$A28_6[df$A28_6 %in% c("eldorado")] = "el dorado"
df$A28_6[df$A28_6 %in% c("redwood valley")] = "mendocino"
df$A28_6[df$A28_6 %in% c("bakersfield")] = "kern"
df$A28_6[df$A28_6 %in% c("oakland", "hayward")] = "alameda"
df$A28_6[df$A28_6 %in% c("suisun","fairfield", "vallejo")] = "solano"
df$A28_6[df$A28_6 %in% c("san luis")] = "san luis obispo"
df$A28_6[df$A28_6 %in% c("anta barbara")] = "santa barbara"
df$A28_6[df$A28_6 %in% c("redding")] = "shasta"
df$A28_6[df$A28_6 %in% c("danville")] = "contra costa"
df$A28_6[df$A28_6 %in% c("thousand oaks")] = "ventura"

#map counties
df$A28_6[df$A28_6 %in% c("yolo", "san joaquin","calaveras","amador", "el dorado", "butte", "placer", "shasta","butte","humboldt", "marin")] = "sacramento"
df$A28_6[df$A28_6 %in% c("monterey", "santa barbara", "kern", "ventura")] = "san luis obispo"
df$A28_6[df$A28_6 %in% c("sonoma", "mendocino")] = "marin"
df$A28_6[df$A28_6 %in% c("alameda", "contra costa", "solano")] = "san francisco"
df$A28_6[df$A28_6 %in% c("tulare","madera", "kings", "inyo","tuolumne", "merced", "stanislaus", "alpine")] = "fresno"
df$A28_6[df$A28_6 %in% c("san mateo","santa cruz")] = "santa clara"

sort(table(df['A28_6']), decreasing = TRUE)