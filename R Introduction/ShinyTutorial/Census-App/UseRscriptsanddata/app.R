# Load Packages
library(maps)
library(mapproj)
library(shiny)

# Load Data & Source Helper
counties <- readRDS("data/counties.rds") 
source("helpers.R")

# Note: percent map is designed to work with the counties data set
# It may not work correctly with other data sets if their row order does
# not exactly match the order in which the maps package plots counties


ui <- page_sidebar(
  title = "censusVis",
  sidebar = sidebar(
    helpText("Create demographic maps with information from the 2010 US Census."),
    selectInput(
      "var",
      label = "Choose a variable to display",
      choices = c("Percent White","Percent Black", "Percent Hispanic", "Percent Asian"),
      selected = "Percent White"
    ),
    sliderInput(
      "range",
      label = "Range of interest:",
      min = 0, 
      max = 100, 
      value = c(0, 100)
    )
  ),
  
  card(plotOutput("map"))
)

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    data <- switch(input$var,  #switch function can transform the output of a select box widget to whatever you like.
                   "Percent White" = counties$white,
                   "Percent Black" = counties$black,
                   "Percent Hispanic" = counties$hispanic,
                   "Percent Asian" = counties$asian
                   )
    color <- switch(input$var,
                    "Percent White" = "darkred",
                    "Percent Black" = "purple",
                    "Percent Hispanic" = "darkgreen",
                    "Percent Asian" = "darkblue"
                    )
    legend <- switch(input$var,
                     "Percent White" = "White %",
                     "Percent Black" = "Black %",
                     "Percent Hispanic" = "Hispanic %",
                     "Percent Asian" = "Asian %"
                     )
    percent_map(data, color, legend, input$range[1], input$range[2])
})
  
}

# Run app ----
shinyApp(ui, server)
