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
sheets1 <- excel_sheets("data1.xlsx")
data1 <- map_df(sheets1, ~
                  read_excel("data1.xlsx", sheet = .x) %>%
                  mutate(source = paste0("data1_", .x))
)

# 2. Read data2.xlsx (assume first sheet)
data2 <- read_excel("data2.xlsx") %>%
  mutate(source = "data2")

# 3. Read CSV files data3.csv through data6.csv
csv_files <- list.files(path = "~/Desktop/DATA332/r_projects/counting_cars_combined", pattern = "data[3-6]\\.csv$", full.names = TRUE)
data_csv <- map_df(csv_files, ~
                     read_csv(.x, guess_max = 10000) %>%
                     mutate(source = basename(.x))
)

# 4. Combine all data frames into one
df_all <- bind_rows(data1, data2, data_csv)

# 5. Clean column names and drop fully empty columns
df_clean <- df_all %>%
  clean_names() %>%
  select(where(~ !all(is.na(.))))

# 6. Type conversions and formatting
#    - Convert any column with 'date' in its name to Date class
#    - Trim whitespace from character columns
#    - Convert blank strings to NA

df_clean <- df_clean %>%
  mutate(across(matches("date"), ~ as_date(.))) %>%
  mutate(across(where(is.character), str_trim)) %>%
  mutate(across(where(is.character), ~ na_if(.x, "")))

# 7. Remove duplicates (if any)
df_clean <- df_clean %>%
  distinct()

# 8. (Optional) Drop or rename any specific columns you deem unnecessary
#    e.g., drop_col1 and drop_col2
# df_clean <- df_clean %>% select(-c(drop_col1, drop_col2))

# 9. Save the combined dataset
write_csv(df_clean, "combined_data.csv")

# View the first few rows
print(head(df_clean))
