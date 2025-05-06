# Uber 2014 -2024 Trips Explorer

## Project Structure

```
combine_uber_data.R      # Script to merge and clean raw CSVs
master_data.rds          # Compressed cleaned dataset (uploaded to GitHub)
sample_data.rds          # Sample for leaflet map (uploaded to GitHub)
app.R                    # Shiny application
README.md                # This file
```

## Setup & Dependencies

Install the required R packages:

```r
install.packages(c(
  "shiny", "shinythemes", "dplyr", "ggplot2", "lubridate",
  "leaflet", "caret", "scales", "RColorBrewer", "viridis"
))
```

## Data Preparation

1. Run the data-merge script locally to generate the `.rds` files:

   ```bash
   Rscript combine_uber_data.R
   ```

2. Commit and push **master_data.rds** and **sample_data.rds** to your GitHub repo (under 25 MB each).

## Deploying the Shiny App

1. Ensure `app.R` points to your raw `.rds` URLs on GitHub:

   ```r
   data_url   <- "https://raw.githubusercontent.com/<username>/<repo>/main/master_data.rds"
   sample_url <- "https://raw.githubusercontent.com/<username>/<repo>/main/sample_data.rds"
   ```

2. Deploy with **shinyapps.io** (example):

   ```r
   library(rsconnect)
   rsconnect::deployApp("app.R")
   ```

3. **Live app link:**  
   https://aashishkasaju.shinyapps.io/uber/

## Code Snippets

**Reading & Cleaning Data (combine_uber_data.R)**

```r
uber_raw <- bind_rows(lapply(list.files(...), read.csv))
uber_clean <- uber_raw %>%
  mutate(DateTime = lubridate::mdy_hms(`Date/Time`), ...) %>%
  select(Hour, Day, Wday, Month, Base, Lat, Lon)
saveRDS(uber_clean, "master_data.rds", compress = "xz")
```

**Shiny App UI & Server (app.R)**

```r
ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("Uber 2014 Trips Explorer"),
  navbarPage(
    tabPanel("By Hour", plotOutput("plot_hour")),
    ...
  )
)

server <- function(input, output) {
  output$plot_hour <- renderPlot({
    ggplot(uber_raw %>% count(Hour), aes(Hour, n)) +
      geom_col() + labs(title = "Trips by Hour")
  })
}

shinyApp(ui, server)
```

---
