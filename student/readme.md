# Visualizing Student Data using R Studio

## Overview

This project performs exploratory data analysis and visualization on student majors, registration, and payments using RStudio. The process involves merging datasets, generating visual insights, and summarizing key financial data.

---

## Datasets

- **`course.xlsx`**  
  Contains details about majors offered, their unique instance ID, start and end dates, and the cost associated with each course.

- **`registration.xlsx`**  
  Contains financial details such as each student's total cost, balance due, and their payment plan status.

- **`student.xlsx`**  
  Contains demographic and contact information for each student.

---

## Libraries Used

- **`dplyr`** - For data manipulation  
- **`ggplot2`** - For data visualization  
- **`readxl`** - For reading Excel files  
- **`tidyr`** - For data tidying and reshaping  
- **`scales`** - For formatting axis labels in plots  
- **`ggcorrplot`** - For visualizing correlation matrices  
- **`wordcloud`** - For generating word cloud visualizations  
- **`RColorBrewer`** - For enhancing color palettes in graphs  
- **`plotly`** - For creating interactive visualizations

---

## Key Features

### Data Merging
- Performed **left joins** to merge registration, student, and course datasets by `Student_ID` and `Instance_ID`.

### Extracting Birth Year
- Converted `Birth Date` into the correct date format and extracted the **birth year** for analysis.

---

## Visualizations

- **Bar Chart** – Number of students in each major  
  ![Rplot](https://github.com/user-attachments/assets/b192d5d9-1e4a-47f4-8826-992bd25420ca)

- **Histogram** – Distribution of student birth years  
  ![Rplot01](https://github.com/user-attachments/assets/b4c5501e-c766-4efb-a65f-aaf71c5085d4)

- **Grouped Bar Chart** – Total cost per major by payment plan  
  ![Rplot02](https://github.com/user-attachments/assets/f0641ddb-44fd-4409-ae51-6efe2c9ae3e9)

- **Line Chart** – Total balance due per major by payment plan  
  ![Rplot03](https://github.com/user-attachments/assets/af3039cb-997e-415b-af69-9aac13892cdc)

---

## How to Run

1. **Install the required R libraries** using the following command:

```r
install.packages(c("dplyr", "ggplot2", "readxl", "tidyr", "scales", 
                   "ggcorrplot", "wordcloud", "RColorBrewer", "plotly"))
