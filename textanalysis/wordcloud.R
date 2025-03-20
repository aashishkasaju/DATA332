# Load necessary libraries
library(dplyr)        # For data manipulation
library(ggplot2)      # For data visualization
library(syuzhet)      # For sentiment analysis (although not used in this code, included for future use)
library(tidytext)     # For text mining and sentiment analysis
library(wordcloud)    # For creating word clouds

# Clean R Environment
rm(list=ls())

# Set Working Directory
setwd('~/Desktop/DATA332/r_projects/textanalysis')

# Load cleaned data
df_wordcloud <- read.csv("cleaned_consumer_complaints.csv", stringsAsFactors = FALSE)

# Generate Word Cloud:
# Set a random seed for reproducibility of the word cloud output
set.seed(1234)

# Create the word cloud using the 'word' column in the cleaned dataset
# - Set minimum word frequency (min.freq) to 50
# - Limit the maximum number of words displayed (max.words) to 200
# - Use a color palette from the 'brewer.pal' function for styling
wordcloud(words = df_wordcloud$word, 
          min.freq = 50,        # Only words with a frequency of at least 50
          max.words = 200,      # Limit to displaying 200 words
          colors = brewer.pal(8, "Dark2"))  # Use "Dark2" palette for colors
