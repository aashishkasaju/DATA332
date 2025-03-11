# Fish and Kelp Data Analysis using R Studio

## Overview

This project focuses on exploratory data analysis and visualization of fish populations and kelp fronds using RStudio. The analysis involves data filtering, joining datasets, and generating visual and tabular insights to summarize the relationship between fish populations and kelp environments.

---

## Datasets

- **`fish.csv`**  
  Contains information about fish species, including their common names, total counts, observation years, and sites.

- **`kelp_fronds.xlsx`**  
  Contains data related to kelp fronds, including counts per site and year.

---

## Libraries Used

- **`ggplot2`** - For creating data visualizations  
- **`dplyr`** - For data manipulation and filtering  
- **`tidyverse`** - A collection of R packages for data science  
- **`readxl`** - For reading Excel files  
- **`here`** - For setting up project directories  
- **`kableExtra`** - For creating and styling HTML tables

---

## Key Features

### Data Filtering
- Filtered fish data by specific species, year, or site.  
- Applied numeric conditions to filter fish based on total count.  
- Used pattern matching to filter species names using `str_detect()`.

### Data Joining
- Performed **full joins** to combine all records from both datasets.  
- Used **left joins** to keep all kelp records and match fish data where available.  
- Applied **inner joins** to include only the records that exist in both datasets.

### Data Wrangling Sequence
- Filtered the fish dataset for a specific year and site.  
- Joined the dataset with kelp data.  
- Created a calculated column `fish_per_frond` to understand fish density per kelp frond.

---

## Visualizations and Tables

- **Filtered Datasets** – Created subsets based on species, counts, and conditions.  
- **Joined Datasets** – Combined fish and kelp data for in-depth analysis.  
- **HTML Table** – Generated formatted and styled tables using `kable` and `kableExtra`.

---

## How to Run

1. **Install the required R libraries** using the following command:

```r
install.packages(c("ggplot2", "dplyr", "tidyverse", "readxl", "here", "kableExtra"))
