library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)

# Resetting RStudio Environment
rm(list = ls())

# Setting Working Directory
setwd("~/Desktop/DATA332/r_projects/clean_transactions")

# Reading the Excel file
df_billing <- read_excel('clean_transactions.xlsx')

# Creating a new cleaned Amount column while keeping the original
df_billing <- df_billing %>%
  mutate(Amount_clean = as.numeric(gsub("[$,]", "", Amount)))

# View the updated data
print(df_billing)