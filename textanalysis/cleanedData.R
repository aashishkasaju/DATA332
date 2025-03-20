# Load necessary libraries
library(dplyr)        # For data manipulation
library(stringr)      # For data manipulation and visualization
library(tidytext)     # For sentiment analysis
library(tm)           # For text mining (removing punctuation, stopwords, etc.)

# Clean R Environment
rm(list=ls())

# Set Working Directory
setwd('~/Desktop/DATA332/r_projects/textanalysis')

# Load the Dataset
data <- read.csv("Consumer_Complaints.csv", stringsAsFactors = FALSE)

# Data Cleaning: Filter out any rows where the 'Consumer.complaint.narrative' column is NA or empty
clean_data <- data %>% 
  filter(!is.na(Consumer.complaint.narrative) & Consumer.complaint.narrative != "") %>% 
  select(Consumer.complaint.narrative)

# Text Pre-processing:
  # Remove punctuation characters from the 'Consumer.complaint.narrative' column
  # Remove digits from the text
  # Remove extra spaces using str_squish() to normalize the text
clean_data$Consumer.complaint.narrative <- clean_data$Consumer.complaint.narrative %>% 
  str_replace_all("[[:punct:]]", "") %>%  
  str_replace_all("[[:digit:]]", "") %>%  
  str_squish()

# Remove Stopwords: To remove common stopwords (e.g., "a", "the", "and") from the text
clean_data <- clean_data %>% 
  mutate(Consumer.complaint.narrative = removeWords(Consumer.complaint.narrative, stop_words$word))

# Tokenization: Convert the text into individual words
tokens <- clean_data %>% 
  unnest_tokens(word, Consumer.complaint.narrative)

# Remove Unwanted Words: Filter out any unwanted words, such as placeholders (e.g., "XXXX")
tokens <- tokens %>% 
  filter(!str_detect(word, "^x+$"))

# Save the Cleaned Data: Write the cleaned tokens to a new CSV file 'cleaned_consumer_complaints.csv'
write.csv(tokens, "cleaned_consumer_complaints.csv", row.names = FALSE)

print("Data cleaning completed. Cleaned data saved as 'cleaned_consumer_complaints.csv'.")
