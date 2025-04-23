library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)
library(stringr)

# Resetting RStudio Environment
rm(list = ls())

# Setting Working Directory
setwd("~/Desktop/DATA332/r_projects/practice/credit_card_transactions")

# Reading the Excel file
df_credit <- read_excel('credit_card_transactions.xlsx', .name_repair = 'universal')

# Extract last 4 digits of card and amount into new columns
df_credit <- df_credit %>%
  mutate(
    Last4Digits = str_extract(Details, "Card: \\*\\*\\*\\*(\\d{4})") %>% str_replace("Card: \\*\\*\\*\\*", ""),
    Amount_clean = as.numeric(gsub("[$,]", "", str_extract(Details, "\\$[0-9,.]+")))
  )

# View the updated data
print(df_credit)