# Load necessary libraries
library(dplyr)        # For data manipulation
library(ggplot2)      # For visualizing the data
library(tidyr)        # For reshaping data
library(tidytext)     # For sentiment analysis
library(tidyverse)
# Clean R Environment
rm(list=ls())

# Set Working Directory
setwd('~/Desktop/DATA332/r_projects/textanalysis')

# Load the Dataset
nrc <- read.csv("cleaned_consumer_complaints.csv", stringsAsFactors = FALSE)

# Sentiment Analysis using the NRC Lexicon to classify words into various emotions and count their occurrences
sent_nrc <- nrc %>% 
  inner_join(get_sentiments("nrc")) %>%  # Join the dataset with the NRC sentiment lexicon
  count(sentiment, sort = TRUE)          # Count occurrences of each sentiment type (anger, joy, etc.)

# Visualization: Creates a horizontal bar chart showing the distribution of different sentiments
ggplot(sent_nrc, aes(x = reorder(sentiment, -n), y = n, fill = sentiment)) + 
  geom_col(show.legend = FALSE) +  # Create a bar chart without showing the legend
  coord_flip() +  # Flip the coordinates to make the chart horizontal
  scale_fill_manual(values = c(    # Manually set colors for each sentiment type
    "anger" = "red",
    "fear" = "purple",
    "joy" = "yellow",
    "sadness" = "blue",
    "surprise" = "lightyellow",
    "trust" = "green",
    "disgust" = "gray",
    "anticipation" = "orange"
  )) + 
  labs(title = "NRC Sentiment Analysis",  # Add title and labels
       x = "Sentiment", 
       y = "Count") +
  theme_minimal() +  # Apply minimal theme to the chart
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  # Remove gridlines

# Print a message indicating completion and that charts have been generated
print("Sentiment analysis completed. Charts generated.")