# Load necessary libraries
library(dplyr)        # For data manipulation
library(stringr)      # For data manipulation and visualization
library(tidytext)     # For sentiment analysis
library(tm)           # For text mining (removing punctuation, stopwords, etc.)
library(tidyverse)
# Clean R Environment
rm(list=ls())

# Set Working Directory
setwd('~/Desktop/DATA332/r_projects/textanalysis')

# Load the Dataset
bing <- read.csv("cleaned_consumer_complaints.csv", stringsAsFactors = FALSE)

# Sentiment Analysis using the Bing Lexicon: To classify words as positive or negative and count the occurrences 
sent_bing <- bing %>% 
  inner_join(get_sentiments("bing")) %>%  # Join the dataset with the Bing sentiment lexicon
  count(word, sentiment, sort = TRUE)     # Count positive and negative words for each word


# Sentiment Score Calculation: Comparing the counts of positive and negative words
sent_bing_score <- bing %>% 
  inner_join(get_sentiments("bing")) %>%  # Join the dataset with the Bing sentiment lexicon
  mutate(index = row_number() %/% 80) %>%  # Create an 'index' column to group rows into batches of 80
  count(index, sentiment) %>%             # Count the number of positive and negative words by index
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%  # Reshape data to separate positive and negative counts
  mutate(sentiment_score = positive - negative)  # Calculate the sentiment score (positive - negative)

# Visualization: Creates a bar chart showing sentiment score across grouped complaints
ggplot(sent_bing_score, aes(index, sentiment_score)) +
  geom_col(fill = "darkolivegreen", show.legend = FALSE) +  # Create bar chart with green color for sentiment score
  labs(title = "Consumer Complaint Sentiment Analysis",  # Add title and labels
       x = "Index (Grouped Complaints)",
       y = "Sentiment Score") +
  theme_minimal()  # Apply minimal theme for the chart

# Print a message indicating completion and that charts have been generated
print("Sentiment analysis completed. Charts generated.")