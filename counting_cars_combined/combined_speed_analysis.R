
# Load required libraries
library(readxl)
library(dplyr)
library(ggplot2)

# Read the main group data
main_data <- read_excel("cars_count.xlsx")

# Read additional datasets
car_data <- read.csv("Car Data Collection.csv")
counting_final <- read.csv("counting_cars_final.csv")
nisrine_data <- read.csv("Data_Counting_Cars.csv")

# Standardize the relevant columns: Speed and Time
main_data_clean <- main_data %>%
  rename(Speed = speed, Time = time)

car_data_clean <- car_data %>%
  rename(Speed = Speed, Time = `Time of the day`) %>%
  select(Speed, Time)

counting_final_clean <- counting_final %>%
  rename(Speed = mph, Time = `hr:min`) %>%
  select(Speed, Time)

nisrine_data_clean <- nisrine_data %>%
  rename(Speed = `Speed (mph)`, Time = Time) %>%
  select(Speed, Time)

# Combine all cleaned datasets
combined_data <- bind_rows(
  main_data_clean,
  car_data_clean,
  counting_final_clean,
  nisrine_data_clean
)

# Ensure Speed is numeric
combined_data$Speed <- as.numeric(combined_data$Speed)

# Summary statistics
min_speed <- min(combined_data$Speed, na.rm = TRUE)
max_speed <- max(combined_data$Speed, na.rm = TRUE)
mean_speed <- mean(combined_data$Speed, na.rm = TRUE)

cat("Min Speed:", min_speed, "\n")
cat("Max Speed:", max_speed, "\n")
cat("Mean Speed:", mean_speed, "\n")

# Plotting speed distribution
ggplot(combined_data, aes(x = Speed)) +
  geom_histogram(binwidth = 2, fill = "blue", color = "black") +
  labs(title = "Distribution of Vehicle Speeds",
       x = "Speed (mph)", y = "Frequency")
