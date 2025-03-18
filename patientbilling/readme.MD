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
  - **Reason for Visit by Month**
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

## Visualizations
### 1. Reason for Visit by Month
![Reason for Visit by Month](https://github.com/aashishkasaju/DATA332/blob/26e158f0709c8ed2298e0c30f6d3041bc2fcf37b/patientbilling/month.png)

### 2. Walk-in vs Scheduled Visits by Reason
![Walk-in vs Scheduled](https://github.com/aashishkasaju/DATA332/blob/bc15d87b135db1e8ad6a5d177b2855fcc41507da/patientbilling/walk_in.png)

### 3. Reason for Visit by City/State
![Reason by City](https://github.com/aashishkasaju/DATA332/blob/bc15d87b135db1e8ad6a5d177b2855fcc41507da/patientbilling/city.png)

### 4. Total Invoice Amount by Reason (Stacked by Payment Status)
![Invoice Amount](https://github.com/aashishkasaju/DATA332/blob/bc15d87b135db1e8ad6a5d177b2855fcc41507da/patientbilling/total_invoice.png)

### 5. Average Invoice Amount by Reason
![Avg Invoice](https://github.com/aashishkasaju/DATA332/blob/bc15d87b135db1e8ad6a5d177b2855fcc41507da/patientbilling/avg_invoice.png)
