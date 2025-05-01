# install.packages(c("tidyverse", "lubridate"))
library(tidyverse)
library(lubridate)

setwd("~/Desktop/DATA332/r_projects/uber")

# 1. Grab all six CSVs from your data/ folder
csv_files <- list.files("data", pattern = "uber-raw-data-.*\\.csv$", full.names = TRUE)

# 2. Read each one into a list
uber_list <- map(csv_files, read_csv)

# 3. Stack them into one data frame
uber_all <- bind_rows(uber_list) %>%
  # 4. Parse the Date/Time column (note the slash!), then extract features
  mutate(
    date_time = mdy_hms(`Date/Time`),
    date      = as_date(date_time),
    hour      = hour(date_time),
    day       = day(date_time),
    wday      = wday(date_time, label = TRUE),
    month     = month(date_time, label = TRUE)
  )

# 5. Quick sanity check
glimpse(uber_all)
