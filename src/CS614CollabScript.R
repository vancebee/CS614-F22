library(dplyr)
source('src/plotter.R')

#TASK 1

df = load("Downloads/CS614-F22/data/homeless_survey.RData")

df
#reverse coding
for (i in 0:171){
  print(sum(is.na(df[i])))
  }


df[, "A5_1"] = 6- df[, "A5_1"] 


#TASK 2
#numeric variable
library(tidyverse)
library(stringr)

as_tibble(df)


#TASK 3

#Distribution channels, all NA columns (due to all anonymous distribution channels), UserLanguage,status 

checklevels = factor(df$UserLanguage)
levels(checklevels)


checklevels = factor(df$DistributionChannel)
levels(checklevels)



remlist = c(NA, "", "texas","american", "america", "ca", "california", "calfornia", "nevada", "no", "not currently in california", "unite states american", "united state", "united states", "united states of america", "us", "usa", "yes")
df$A28_6[!is.na(as.numeric(df$A28_6))] = NA
#df$A28_6[df$A28_6 == remlist] = NA
df['A28_6'] = lapply(lapply(df['A28_6'], tolower), str_trim)
countylist = lapply(lapply(c(NA, "Alameda "," Alpine "," Amador "," Butte "," Calaveras "," Colusa "," Contra Costa "," Del Norte "," El Dorado "," Fresno "," Glenn "," Humboldt "," Imperial "," Inyo "," Kern "," Kings "," Lake "," Lassen "," Los Angeles "," Madera "," Marin "," Mariposa "," Mendocino "," Merced "," Modoc "," Mono "," Monterey "," Napa "," Nevada "," Orange "," Placer "," Plumas "," Riverside "," Sacramento "," San Benito "," San Bernardino "," San Diego "," San Francisco"," San Joaquin "," San Luis Obispo "," San Mateo "," Santa Barbara "," Santa Clara "," Santa Cruz "," Shasta "," Sierra "," Siskiyou "," Solano "," Sonoma "," Stanislaus "," Sutter "," Tehama "," Trinity "," Tulare "," Tuolumne "," Ventura "," Yolo "," Yuba "), str_trim), tolower)



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
