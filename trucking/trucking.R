library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)

# Resetting RStudio Environment
rm(list=ls())

# Set working directory
setwd('~/Desktop/DATA332/r_projects/trucking')

# Load & Union Data
df_truck_0001 <- read_excel('truck data 0001.xlsx', 
                            sheet = 2, skip = 3, .name_repair = "universal")

df_truck_0369 <- read_excel('truck data 0369.xlsx', 
                            sheet = 2, skip = 3, .name_repair = "universal")

df_truck_1226 <- read_excel('truck data 1226.xlsx', 
                            sheet = 2, skip = 3, .name_repair = "universal")

df_truck_1442 <- read_excel('truck data 1442.xlsx', 
                            sheet = 2, skip = 3, .name_repair = "universal")

df_truck_1478 <- read_excel('truck data 1478.xlsx', 
                            sheet = 2, skip = 3, .name_repair = "universal")

df_truck_1539 <- read_excel('truck data 1539.xlsx', 
                            sheet = 2, skip = 3, .name_repair = "universal")

df_truck_1769 <- read_excel('truck data 1769.xlsx', 
                            sheet = 2, skip = 3, .name_repair = "universal")

df_pay <- read_excel('Driver Pay Sheet.xlsx', .name_repair = "universal")

df <- rbind(df_truck_0001, df_truck_0369, df_truck_1226, df_truck_1442, 
            df_truck_1478, df_truck_1539, df_truck_1769)

df <- left_join(df, df_pay, by = c('Truck.ID'))

# Count Locations

# Extract City Names From Both Starting And Delivery Locations
df_starting <- df %>%
  mutate(location = str_trim(gsub(",.*", "", Starting.Location))) %>%  # Get City Before Comma
  count(location, name = "starting_count")

df_delivery <- df %>%
  mutate(location = str_trim(gsub(",.*", "", Delivery.Location))) %>%  # Same For Delivery
  count(location, name = "delivery_count")

# Combine Counts
locations <- full_join(df_starting, df_delivery, by = "location") %>%
  mutate(total = rowSums(select(., starting_count, delivery_count), na.rm = TRUE))

# Calculate Driver Pay

# Group By Driver And Calculate Total Miles And Pay

# Calculate Driver Pay
df_pay <- df %>%
  group_by(Truck.ID, first, last) %>%
  summarize(
    total_miles = sum(Odometer.Ending - Odometer.Beginning, na.rm = TRUE),
    labor_per_mil = first(labor_per_mil),
    .groups = 'drop'
  ) %>%
  mutate(total_pay = total_miles * labor_per_mil)

# Create Bar Chart

ggplot(df_pay, aes(
  x = reorder(paste(first, last), total_pay),  # Order By Pay
  y = total_pay,
  fill = factor(Truck.ID)  # Color By Truck ID
)) +
  geom_col() +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Driver Pay by Total Miles Driven",
    x = "Driver",
    y = "Total Pay ($)",
    fill = "Truck ID"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))