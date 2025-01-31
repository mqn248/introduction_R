# Note: percent map is designed to work with the counties data set
# It may not work correctly with other data sets if their row order does
# not exactly match the order in which the maps package plots counties


counties <- readRDS("data/counties.rds")

percent_map <- function(var, color, legend.title, min = 0, max = 100) {
  #var: a column vector from the counties.rds dataset
  #color: any character string you see in the output of colors()
  #legend:A character string to use as the title of the plot’s legend
  #max: A parameter for controlling shade range (defaults to 100)
  #min: A parameter for controlling shade range (defaults to 0)
  # generate vector of fill colors for map
  shades <- colorRampPalette(c("white", color))(100)
  
  # constrain gradient to percents that occur between min and max
  var <- pmax(var, min)
  var <- pmin(var, max)
  percents <- as.integer(cut(var, 100,
                             include.lowest = TRUE, ordered = TRUE))
  fills <- shades[percents]
  
  # plot choropleth map
  map("county", fill = TRUE, col = fills,
      resolution = 0, lty = 0, projection = "polyconic",
      myborder = 0, mar = c(0,0,0,0))
  
  # overlay state borders
  map("state", col = "white", fill = FALSE, add = TRUE,
      lty = 1, lwd = 1, projection = "polyconic",
      myborder = 0, mar = c(0,0,0,0))
  
  # add a legend
  inc <- (max - min) / 4
  legend.text <- c(paste0(min, " % or less"),
                   paste0(min + inc, " %"),
                   paste0(min + 2 * inc, " %"),
                   paste0(min + 3 * inc, " %"),
                   paste0(max, " % or more"))
  
  legend("bottomleft",
         legend = legend.text,
         fill = shades[c(1, 25, 50, 75, 100)],
         title = legend.title)
  
}

percent_map(counties$white, "darkgreen", "% White")

