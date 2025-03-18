# Patient Billing Analysis

## Project Overview
This project analyzes patient visit data, billing details, and reasons for visits using **R**. The analysis involves merging multiple datasets, cleaning and transforming data, and generating visualizations to uncover trends in **patient visits, invoice amounts, and payment statuses**.

## Datasets Used
- **Billing.xlsx**: Contains invoice details, including amounts and payment statuses.
- **Patient.xlsx**: Includes patient demographics and location information.
- **Visit.xlsx**: Records details such as visit reasons and walk-in status.

## Features
- **Data Cleaning & Transformation**:
  - Convert dates to proper formats and extract **month/year** for trend analysis.
  - Merge datasets using **relational keys (PatientID & VisitID)**.
- **Visualizations**:
  - **Reasons for visits by month**
https://github.com/aashishkasaju/DATA332/blob/d43092787bc290c432caa0d8ecdca3cc35ec82af/patientbilling/month.png
  - **Walk-in vs. scheduled visit breakdown**
  - **Reasons for visits by city/state**
  - **Invoice amounts by reason and payment status**
  - **Average invoice amounts by reason**
- **Insights**:
  - **Walk-in visits** tend to have **higher total invoice amounts** than scheduled visits, possibly due to **urgent or extensive care** requirements.
  - Some **visit reasons** result in **significantly higher invoices**, indicating the need for specialized treatments.

## Setup Instructions
1. Install necessary R packages:
   ```r
   install.packages(c("ggplot2", "dplyr", "tidyverse", "readxl", "tidyr"))
