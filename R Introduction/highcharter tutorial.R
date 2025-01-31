library(highcharter)
library(shiny)

hc <- highchart() |>
  hc_chart(type = "line") |>
  hc_title(text = "Simple Line Chart") |>
  hc_add_series(data= c(1,2,3,4,5))
hc

#Shiny 
# Define UI for application 
# UI (ui): We use selectInput to create a dropdown for selecting which dataset to display
ui <- fluidPage(
  # Application title
  titlePanel("Interactive Highchart with Select Input"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("dataChoice", 
                  label = "Choose a dataset", 
                  choices = c("Dataset 1", "Dataset 2", "Dataset 3"),
                  selected = "Dataset 1")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      highchartOutput("chart")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  # Reactive expression to return data based on user selection
  # selectedData is a reactive expression that returns different data based on the input.
  selectedData <- reactive({
    if(input$dataChoice == "Dataset 1") {
      return(c(1, 3, 2, 4, 5))
    } else if(input$dataChoice == "Dataset 2") {
      return(c(5, 4, 3, 2, 1))
    } else {
      return(c(1, 1, 2, 3, 5))
    }
  })
  
  # Render the highchart output
  output$chart <- renderHighchart({
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_title(text = paste("Data for", input$dataChoice)) %>%
      hc_add_series(data = selectedData())
  })
} 
 

# Run the application 
shinyApp(ui = ui, server = server)

hc <- highchart() %>%
  hc_chart(type = "line") %>%
  hc_title(text = "Enhanced Tooltip") %>%
  hc_add_series(data = c(1, 3, 2, 4, 5)) %>%
  hc_tooltip(headerFormat = "<b>{point.key}</b><br>", 
             pointFormat = "{series.name}: {point.y}")

hc


#Welcome to Shiny Example
library(shiny)
runExample("01_hello")

