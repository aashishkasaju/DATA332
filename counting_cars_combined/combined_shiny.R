library(shiny)
library(dplyr)
library(ggplot2)
library(lubridate)

# 1. load data from GitHub raw CSV
data_url <- "https://raw.githubusercontent.com/aashishkasaju/DATA332/main/counting_cars_combined/new_combined.csv"
car_data <- read_csv(data_url, show_col_types = FALSE) %>%
  # ensure Car_Type is a factor
  mutate(Car_Type = as.factor(Car_Type),
         # compute speed change here
         Speed_Change = Final_Speed - Initial_Speed)

# 2. UI
ui <- fluidPage(
  titlePanel(" Vehicle Speeds by Car Type"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "carType", "Filter by Car Type:",
        choices  = levels(car_data$Car_Type),
        selected = levels(car_data$Car_Type),
        multiple = TRUE
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Count by Type",    plotOutput("barType")),
        tabPanel("Speed Distribution", plotOutput("histSpeed")),
        tabPanel("Init vs Final",      plotOutput("scatterSpeeds")),
        tabPanel("ΔSpeed by Type",     plotOutput("boxDelta"))
      )
    )
  )
)

# 3. Server
server <- function(input, output, session) {
  filtered <- reactive({
    car_data %>%
      filter(Car_Type %in% input$carType)
  })
  
  # bar chart: how many observations per car type
  output$barType <- renderPlot({
    ggplot(filtered(), aes(x = Car_Type)) +
      geom_bar() +
      labs(title = "Count of Observations by Car Type",
           x = "Car Type", y = "Count") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # histogram of initial speeds
  output$histSpeed <- renderPlot({
    ggplot(filtered(), aes(x = Initial_Speed)) +
      geom_histogram(bins = 30, alpha = 0.7) +
      labs(title = "Distribution of Initial Speeds",
           x = "Initial Speed (mph)", y = "Count") +
      theme_minimal()
  })
  
  # scatter initial vs final
  output$scatterSpeeds <- renderPlot({
    ggplot(filtered(), aes(x = Initial_Speed, y = Final_Speed, color = Car_Type)) +
      geom_point(alpha = 0.6) +
      labs(title = "Initial vs. Final Speed",
           x = "Initial Speed (mph)", y = "Final Speed (mph)") +
      theme_minimal()
  })
  
  # boxplot of speed change
  output$boxDelta <- renderPlot({
    ggplot(filtered(), aes(x = Car_Type, y = Speed_Change)) +
      geom_boxplot() +
      labs(title = "Speed Change (Final – Initial) by Car Type",
           x = "Car Type", y = "Speed Change (mph)") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}

# 4. launch
shinyApp(ui, server)
