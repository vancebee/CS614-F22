# module contains functions used for plotting and visualizing data
# simple for now will add more complex funtions in the future

plot_bar <- function(d, col_name){
  plot(table(d[col_name]))
}