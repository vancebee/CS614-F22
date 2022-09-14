packages <- c("dplyr", "readr", "tibble")
install.packages(setdiff(packages, rownames(installed.packages())))
lapply(packages, require, character.only = TRUE)
source('src/plotter.R', 'src/preprocess.R')
