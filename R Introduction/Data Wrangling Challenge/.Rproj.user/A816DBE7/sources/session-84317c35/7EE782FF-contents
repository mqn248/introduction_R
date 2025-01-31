#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(bslib)

#Define UI
#-----------------------------
#ui <- page_sidebar(
 # title = "title panel",
 # sidebar = sidebar("Sidebar", position = "right"),
  #"Main contents"
#)
#-----------------------------
#ui <- page_fluid(
 # layout_sidebar(
   # sidebar = sidebar("Sidebar"),
   # "Main contents"
  #)   
#)
#-----------------------------
#ui <- page_sidebar(
  #title = "title panel",
  #sidebar = sidebar("Sidebar"),
  #card(
    #card_header("Card header"),
    #"Card body"
 # )
#)
#-----------------------------
#ui <- page_sidebar(
  #title = "title panel",
  #sidebar = sidebar("Sidebar"),
  #value_box(
    #title = "Value box",
    #value = 100,
    #showcase = bsicons::bs_icon("bar-chart"),
    #theme = "teal"
  #),
  #card("Card"),
  #card("Another card")
#)
#-----------------------------
#ui <- page_sidebar(
      #title = "My Shiny App",
      #sidebar = sidebar(
        #"Shiny is available on CRAN, so you can install it in the usual way from your R console:",
        #code('install.packages("shiny")'),
      #),
      #card(
        #card_header("Introducing Shiny"),
        #"Shiny is a package from Posit that makes it incredibly easy to build interactive web applications with R.
    #For an introduction and live examples, visit the Shiny homepage (https://shiny.posit.co).",
        #card_image("www/shiny.svg", height = "300px"),
        #card_footer("Shiny is a product of Posit.")
      #)
#)
#-----------------------------
ui <- page_fluid(
  titlePanel("Basic widgets"),
  layout_columns(
    col_width = 3,
    card(
      card_header("Button"),
      actionButton("action", "Button"),
      submitButton("Submit")
    ),
    card(
      card_header("Single checkbox"),
      checkboxInput("checkbox", "Choice A", value = TRUE)
    ),
    card(
      card_header("Checkbox group"),
      checkboxGroupInput(
        "checkGroup",
        "Select all that apply",
        choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
        selected = 1
      )
    ),
    card(
      card_header("Date input"),
      dateInput("date", "Select date", value = "2025-01-01")
    ),
    card(
      card_header("Date range input"),
      dateRangeInput("dates", "Select dates")
    ),
    card(
      card_header("File input"),
      fileInput("file", label = NULL)
    ),
    card(
      card_header("Help text"),
      helpText(
        "Note: help text isn't a true widget,",
        "but it provides an easy way to add text to",
        "accompany other widgets."
      )
    ),
    card(
      card_header("Numeric input"),
      numericInput("num", "Input number", value = 1)
    ),
    card(
      card_header("Radio buttons"),
      radioButtons(
        "radio",
        "Select option",
        choices = list("Choice A" = 1, "Choice B" = 2, "Choice C" = 3),
        selected = 1
      )
    ),
    card(
      card_header("Select box"),
      selectInput(
        "select",
        "Select option",
        choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
        selected = 1
      )
    ),
    card(
      card_header("Sliders"),
      sliderInput(
        "slider1",
        "Set value",
        min = 0,
        max = 100,
        value = 50
      ),
      sliderInput(
        "slider2",
        "Set value range",
        min = 0,
        max = 100,
        value = c(25, 75)
      )
    ),
    card(
      card_header("Text input"),
      textInput("text", label = NULL, value = "Enter text...")
    )
  )
)     

#----------------------------- 
ui <- page_sidebar(
  title = "censusVis",
  sidebar = sidebar(
    helpText(
    "Create demographic maps with information from the 2010 US Census."),
    selectInput(
      "var",
      label = "Choose a variable to display",
      choices = list("Percent White", "Percent Black", "Percent Hispanic", "Percent Asian"),
      selected = "Percent White"
    ),
    sliderInput("range", label = "Range of Interest:", min = 0, max = 100, value = c(0,100))
  )
)
    
#code('install.packages("shiny")'),
#),
#card(
#card_header("Introducing Shiny"),
#"Shiny is a package from Posit that makes it incredibly easy to build interactive web applications with R.
#For an introduction and live examples, visit the Shiny homepage (https://shiny.posit.co).",
#card_image("www/shiny.svg", height = "300px"),
#card_footer("Shiny is a product of Posit.")
#)
#) 
 
#Define Server Logic
server <- function(input, output) {}


#Run the App
shinyApp(ui=ui, server=server)