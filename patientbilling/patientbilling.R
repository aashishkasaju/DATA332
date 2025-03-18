# Load Necessary Libraries
library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)

# Resetting R Environment
rm(list = ls())

# Setting Working Directory
setwd('~/Desktop/DATA332/r_projects/patientbilling')

# Loading Datasets
billing <- read_excel("Billing.xlsx")
patient <- read_excel("Patient.xlsx")
visit <- read_excel("Visit.xlsx")

# Merging datasets with Relational Keys
visit_patient <- merge(visit, patient, by = "PatientID", all.x = TRUE)
full_data <- merge(visit_patient, billing, by = "VisitID", all.x = TRUE )

# Convert VisitDate and InvoiceDate to Date Format
full_data$VisitDate <- as.Date(full_data$VisitDate)
full_data$InvoiceDate <- as.Date(full_data$InvoiceDate)

# Extract Month and Year
full_data$Month <- format(full_data$VisitDate, "%B")
full_data$Year <- format(full_data$VisitDate, "%Y")

# Sort Months in Correct Format
full_data$Month <- factor(full_data$Month, levels = month.name)

# Reason for Visit by Month
ggplot(full_data, aes(x = Month, fill = Reason)) +
  geom_bar(position = "stack") +
  theme_minimal() + 
  labs(title = "Reason for Visit by Month",
       x = "Month", y = "Number of Visits") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Reason for Visit based on Walk-in or Not
ggplot(full_data, aes(x = factor(WalkIn), fill = Reason)) + 
  geom_bar(position = "stack") +
  theme_minimal() +
  labs(title = "Reason for Visit Based on Walk-in or Not", x = "Walk-in (1 = Yes, 0 = No)", y = "Count")

# Reason for Visit by City/State
ggplot(full_data, aes(x = City, fill = Reason)) +
  geom_bar(position = "stack") +
  theme_minimal() +
  labs(title = "Reason for Visit by City",
       x = "City", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Total Invoice Amount Based on Reason for Visit
ggplot(full_data, aes(x = Reason, y = InvoiceAmt, fill = factor(InvoicePaid))) + 
  geom_bar(stat = "identity", position = "stack") +
  theme_minimal() +
  labs(title = "Total Invoice Amount Based on Reason for Visit", x = "Reason for Visit", y = "Total Invoice Amount", fill = "Paid (1 = Yes, 0 = No)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Additional Insight: Average Invoice Amount by Reason
ggplot(full_data %>% group_by(Reason) %>% summarise(AvgInvoice = mean(InvoiceAmt, na.rm = TRUE)), 
       aes(x = Reason, y = AvgInvoice)) + 
  geom_col(fill = "green") +
  theme_minimal() +
  labs(title = "Average Invoice Amount by Reason for Visit", x = "Reason for Visit", y = "Average Invoice Amount") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Walk-in visits generally result in higher total invoice amounts than scheduled visits, 
# possibly indicating a greater need for urgent or extensive care. Additionally, certain 
# visit reasons correspond to significantly higher invoice amounts, suggesting a demand 
# for specialized treatments or services.
