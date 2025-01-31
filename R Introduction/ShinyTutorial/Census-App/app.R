library(shiny)
library(bslib)

# Define UI for application that draws a histogram
ui <- page_sidebar(
  title = "censusVis",
  sidebar = sidebar(
    helpText(
      "Create demographic maps with information from the 2010 US Census."
    ),
    selectInput(
      "var",
      label = "Choose a variable to display",
      choices = 
        c("Percent White", "Percent Black", "Percent Hispanic", "Percent Asian"),
      selected = "Percent White"
      #for actual drop down: unique(aggregate_Risk$diseases)
    ),
    sliderInput(
      "range",
      label = "Range of interest:",
      min = 0,  max = 100, value = c(0, 100)
    )
  ),
  textOutput("selected_var"),
  textOutput("min_max")
)
#Notice that textOutput takes an argument, the character string "selected_var". 
#Each of the *Output functions require a single argument: a character string that Shiny will use as the name of your reactive element. 

# Define server logic 
#output: list-like object that stores instructions for building the R objects in your app
#input: list-like object that stores the current values of all of the widgets in your app. 
##These values will be saved under the names that you gave the widgets in your ui
#server function is run once each time a user visits your app
#render* functions are run many times. Shiny runs them once each time a user change the value of a widget

server <- function(input, output) {
  output$selected_var <- renderText({
    paste("You have selected", input$var) 
    }) #var comes from ui select input
  
  output$min_max <- renderText({
    paste("You have chosen a range that goes from", input$range[1], "to", input$range[2] )
    })
}

# Run the application 
shinyApp(ui, server)
#shinyApp function is run once, when you launch your app