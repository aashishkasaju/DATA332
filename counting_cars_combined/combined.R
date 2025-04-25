# Load necessary libraries
install.packages("corrplot")
install.packages("DataExplorer")
library(readxl)
library(dplyr)
library(purrr)
library(readr)
library(janitor)
library(lubridate)
library(tidyverse)
library(ggplot2)
library(corrplot)
library(DataExplorer)

# 1. Read all sheets from data1.xlsx and combine into one
setwd('~/Desktop/DATA332/r_projects/counting_cars_combined')
# 1) DATA1: simple initial/final speeds + difference + body style
d1 <- read_excel("data1.xlsx") %>%
  rename(
    Initial_Speed = Initial_Speed,
    Final_Speed   = Final_Speed,
    Speed_Change  = Difference,
    Car_Type      = Body_Style
  ) %>%
  mutate(
    Observer    = NA_character_,
    Weather     = NA_character_,
    Location    = NA_character_,
    Date        = NA_Date_,
    Source      = "data1.xlsx"
  ) %>%
  select(Initial_Speed, Final_Speed, Speed_Change,
         Car_Type, Weather, Location, Observer, Date, Source)

# 2) DATA2 (speed_counting_cars.xlsx): has init/final, change, type, loc, weather, recorder
d2 <- read_excel("data2.xlsx") %>%
  rename(
    Initial_Speed = init_speed,
    Final_Speed   = final_speed,
    Speed_Change  = speed_change,
    Car_Type      = vehicle_type,
    Location      = location,
    Observer      = recorder,
    Weather       = `weather `
  ) %>%
  mutate(
    Date   = NA_Date_,
    Source = "speed_counting_cars.xlsx"
  ) %>%
  select(Initial_Speed, Final_Speed, Speed_Change,
         Car_Type, Weather, Location, Observer, Date, Source)

# 3) DATA3 (Counting_Cars.csv): rename, parse date, drop extras
d3 <- read_csv("data3.csv") %>%
  rename(
    Initial_Speed = Initial_Read,
    Final_Speed   = Final_Read,
    Speed_Change  = Difference_In_Readings,
    Date          = Date_Recorded,
    Car_Type      = Type_of_Car,
    Observer      = Name
  ) %>%
  mutate(
    Date     = mdy(Date),
    Weather  = Weather,
    Location = Location,
    Source   = "data3.csv"
  ) %>%
  select(Initial_Speed, Final_Speed, Speed_Change,
         Car_Type, Weather, Location, Observer, Date, Source)

# 4) DATA4: single‐speed reading (mph), style, student, date, slow‐down flag
d4 <- read_csv("data4.csv") %>%
  rename(
    Initial_Speed = mph,
    Final_Speed   = mph,
    Car_Type      = vehicle_style,
    Observer      = student,
    Date          = date,
    Weather       = `if_they_slow_down_(YES/ NO)`
  ) %>%
  mutate(
    Initial_Speed = as.numeric(Initial_Speed),
    Final_Speed   = as.numeric(Final_Speed),
    Speed_Change  = NA_real_,
    Date          = mdy(Date),
    Location      = NA_character_,
    Source        = "data4.csv"
  ) %>%
  select(Initial_Speed, Final_Speed, Speed_Change,
         Car_Type, Weather, Location, Observer, Date, Source)

# 5) DATA5 (Diya’s): time‐of‐day, speed, weather, state, color, type, collector
d5 <- read_csv("data5.csv") %>%
  rename(
    Initial_Speed = Speed,
    Final_Speed   = Speed,
    Car_Type      = `Type of Car`,
    Observer      = `Collector Name`,
    Weather       = `Weather `,
    Location      = `Plate State `
  ) %>%
  mutate(
    Speed_Change = NA_real_,
    Date         = mdy(Date),
    Source       = "data5.csv"
  ) %>%
  select(Initial_Speed, Final_Speed, Speed_Change,
         Car_Type, Weather, Location, Observer, Date, Source)

# 6) DATA6 (Nisrine’s): weekday string + date, time, speed
d6 <- read_csv("data6.csv") %>%
  rename(
    Raw_Date      = Date,
    Initial_Speed = `Speed (mph)`,
    Final_Speed   = `Speed (mph)`,
    Observer      = Observer
  ) %>%
  mutate(
    Speed_Change = NA_real_,
    # drop weekday, then parse date
    Date     = mdy(str_remove(Raw_Date, "^[^,]+,\\s*")),
    Car_Type = NA_character_,
    Weather  = NA_character_,
    Location = NA_character_,
    Source   = "data6.csv"
  ) %>%
  select(Initial_Speed, Final_Speed, Speed_Change,
         Car_Type, Weather, Location, Observer, Date, Source)

# bind all six together
combined_car_data <- bind_rows(d1, d2, d3, d4, d5, d6)

# write out
write_csv(combined_car_data, "combined.csv")

combined_car_data <- read_csv("combined.csv")

# Drop the unwanted columns
slim_car_data <- combined_car_data %>%
  select(-Weather, -Location, -Observer, -Date, -Source, -Speed_Change)

# (Optionally) inspect
glimpse(slim_car_data)

# Write out the slimmed file
write_csv(slim_car_data, "new_combined.csv")
