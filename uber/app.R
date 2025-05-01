# app.R
# Shiny application for Uber 2014 trips analysis with enhanced design
# Libraries
library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(lubridate)
library(leaflet)
library(caret)
library(scales)
library(RColorBrewer)
library(viridis)

# Data URLs on GitHub 
data_url   <- "https://raw.githubusercontent.com/aashishkasaju/DATA332/cf3d0b06534ced80f03569c7b3c21c2c4b43f65d/uber/master_data.rds"
sample_url <- "https://raw.githubusercontent.com/aashishkasaju/DATA332/cf3d0b06534ced80f03569c7b3c21c2c4b43f65d/uber/sample_data.rds"

# Load datasets (download binary then read) 
tmp1 <- tempfile(fileext = ".rds")
download.file(data_url, tmp1, mode = "wb")
uber_raw <- readRDS(tmp1)
unlink(tmp1)

tmp2 <- tempfile(fileext = ".rds")
download.file(sample_url, tmp2, mode = "wb")
uber_sample <- readRDS(tmp2)
unlink(tmp2)

# Train a simple linear model for ride count prediction 
model_df <- uber_raw %>%
  count(Hour, Wday, Month) %>%
  mutate(
    Wday_num  = as.integer(Wday),
    Month_num = as.integer(Month)
  )
set.seed(2025)
pred_model <- train(n ~ Hour + Wday_num + Month_num,
                    data   = model_df,
                    method = "lm")

# UI Definition 
ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel(div("Uber 2014 Trips Explorer", style = "color:#2C3E50;")),
  navbarPage(
    title = NULL,
    tabPanel("By Hour",
             fluidRow(
               column(6, plotOutput("plot_hour", height = "300px")),
               column(6, plotOutput("plot_hour_month", height = "300px"))
             )
    ),
    tabPanel("By Day",
             fluidRow(
               column(6, plotOutput("plot_day", height = "300px")),
               column(6, plotOutput("plot_wday_month", height = "300px"))
             )
    ),
    tabPanel("Monthly & Base",
             fluidRow(
               column(6, plotOutput("plot_month", height = "300px")),
               column(6, plotOutput("plot_base_month", height = "300px"))
             )
    ),
    tabPanel("Heatmaps",
             fluidRow(
               column(6, plotOutput("heat1", height = "300px")),
               column(6, plotOutput("heat2", height = "300px")),
               column(6, plotOutput("heat3", height = "300px")),
               column(6, plotOutput("heat4", height = "300px"))
             )
    ),
    tabPanel("Map",
             leafletOutput("map", height = "600px")
    ),
    tabPanel("Predictor",
             sidebarLayout(
               sidebarPanel(
                 sliderInput("pred_hour", "Hour of Day:", 0, 23, value = 8),
                 selectInput("pred_wday", "Weekday:", choices = levels(uber_raw$Wday)),
                 selectInput("pred_month","Month:", choices = levels(uber_raw$Month)),
                 actionButton("goPred", "Estimate Trips", class = "btn-primary")
               ),
               mainPanel(
                 h4("Prediction Result"),
                 verbatimTextOutput("pred_text")
               )
             )
    )
  )
)

# Server Logic
server <- function(input, output, session) {
  # 1) Trips Every Hour
  output$plot_hour <- renderPlot({
    d <- uber_raw %>% count(Hour) %>% arrange(Hour)
    ggplot(d, aes(Hour, n)) +
      geom_col(fill = brewer.pal(8, "Dark2")[2]) +
      scale_x_continuous(breaks = 0:23) +
      scale_y_continuous(labels = comma) +
      labs(title = "Total Trips by Hour", x = "Hour of Day", y = "Trips") +
      theme_minimal()
  })
  
  # 2) Hourly Patterns by Month
  output$plot_hour_month <- renderPlot({
    d <- uber_raw %>%
      count(Month, Hour) %>%
      mutate(Month = factor(Month, levels = levels(uber_raw$Month)))
    ggplot(d, aes(Hour, n, color = Month)) +
      geom_line(size = 1) +
      scale_color_brewer(palette = "Set1") +
      labs(title = "Hourly Trip Patterns by Month", x = "Hour", y = "Trips") +
      theme_minimal() + theme(legend.position = "bottom")
  })
  
  # 3) Trips by Day of Month
  output$plot_day <- renderPlot({
    d <- uber_raw %>% count(Day) %>% arrange(Day)
    ggplot(d, aes(Day, n)) +
      geom_col(fill = brewer.pal(8, "Set2")[3]) +
      scale_x_continuous(breaks = 1:31) +
      scale_y_continuous(labels = comma) +
      labs(title = "Trips by Day of Month", x = "Day", y = "Trips") +
      theme_minimal()
  })
  
  # 4) Weekday & Month Breakdown
  output$plot_wday_month <- renderPlot({
    d <- uber_raw %>% count(Wday, Month)
    ggplot(d, aes(Wday, n, fill = Month)) +
      geom_col(position = "dodge") +
      scale_fill_viridis_d(option = "C") +
      labs(title = "Weekday Trips by Month", x = NULL, y = "Trips") +
      theme_minimal() + theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # 5) Trips by Month
  output$plot_month <- renderPlot({
    d <- uber_raw %>% count(Month)
    ggplot(d, aes(Month, n)) +
      geom_col(fill = brewer.pal(8, "Set1")[4]) +
      scale_y_continuous(labels = comma) +
      labs(title = "Monthly Trip Totals", x = NULL, y = "Trips") +
      theme_minimal()
  })
  
  # 6) Base vs Month
  output$plot_base_month <- renderPlot({
    d <- uber_raw %>% count(Base, Month)
    ggplot(d, aes(Base, n, fill = Base)) +
      geom_col() + facet_wrap(~Month, ncol = 3) +
      labs(title = "Trips by Base Location and Month", x = NULL, y = "Trips") +
      theme_minimal() + theme(axis.text.x = element_text(angle = 45, hjust = 1),
                              legend.position = 'none')
  })
  
  # Heatmaps
  output$heat1 <- renderPlot({
    d <- uber_raw %>% count(Hour, Wday)
    ggplot(d, aes(Hour, Wday, fill = n)) +
      geom_tile() + scale_fill_viridis_c() +
      labs(title = "Heatmap: Hour vs Weekday") + theme_minimal()
  })
  output$heat2 <- renderPlot({
    d <- uber_raw %>% count(Day, Month)
    ggplot(d, aes(Day, Month, fill = n)) + geom_tile() +
      scale_fill_viridis_c() + labs(title = "Heatmap: Day vs Month") + theme_minimal()
  })
  output$heat3 <- renderPlot({
    d <- uber_raw %>% mutate(WoM = ceiling(Day/7)) %>% count(WoM, Month)
    ggplot(d, aes(WoM, Month, fill = n)) + geom_tile() +
      scale_fill_viridis_c() + labs(title = "Heatmap: Week of Month vs Month") + theme_minimal()
  })
  output$heat4 <- renderPlot({
    d <- uber_raw %>% count(Base, Wday)
    ggplot(d, aes(Wday, Base, fill = n)) + geom_tile() +
      scale_fill_viridis_c() + labs(title = "Heatmap: Base vs Weekday") +
      theme_minimal() + theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  # Leaflet map
  output$map <- renderLeaflet({
    leaflet(uber_sample) %>% addProviderTiles(providers$CartoDB.Positron) %>%
      addCircleMarkers(lng = ~Lon, lat = ~Lat,
                       radius = 3, stroke = FALSE, fillOpacity = 0.6,
                       color = "#2C3E50",
                       clusterOptions = markerClusterOptions())
  })
  
  # Predictor
  ride_est <- eventReactive(input$goPred, {
    hr <- input$pred_hour
    wd <- as.integer(factor(input$pred_wday, levels = levels(uber_raw$Wday)))
    mo <- as.integer(factor(input$pred_month, levels = levels(uber_raw$Month)))
    predict(pred_model, newdata = data.frame(Hour=hr, Wday_num=wd, Month_num=mo))
  })
  output$pred_text <- renderText({
    req(input$goPred)
    paste0("Estimated Trips: ", format(round(ride_est()), big.mark = ","))
  })
}

# Run the App
shinyApp(ui, server)
