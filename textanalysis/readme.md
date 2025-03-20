
# Text Analysis: Consumer Complaints

### Creator
Aashish Kasaju Shrestha

### Introduction
I will utilize the tidytext package in R Studio to analyze consumer complaints by applying the NRC and Bing lexicons to determine the sentiment polarity of the complaints.

### Dictionary 
The analysis was conducted on the Consumer.complaint.narrative column, which contains consumer complaints in their original format after the data was tidied.

### Data Cleaning
A cleaned version of the original dataset (**df**) was created by filtering out missing values in the **Consumer.complaint.narrative** column and retaining only that column.

### Clean R Environment
rm(list=ls())

### Set Working Directory
setwd('~/Desktop/DATA332/r_projects/textanalysis')

### Load the Dataset
data <- read.csv("Consumer_Complaints.csv", stringsAsFactors = FALSE)

### Data Cleaning: Filter out any rows where the 'Consumer.complaint.narrative' column is NA or empty

```
clean_data <- data %>% 
  filter(!is.na(Consumer.complaint.narrative) & Consumer.complaint.narrative != "") %>% 
  select(Consumer.complaint.narrative)

```

### Text Pre-processing
Remove punctuation characters from the 'Consumer.complaint.narrative' column
Remove digits from the text
Remove extra spaces using str_squish() to normalize the text

```
clean_data$Consumer.complaint.narrative <- clean_data$Consumer.complaint.narrative %>% 
  str_replace_all("[[:punct:]]", "") %>%  
  str_replace_all("[[:digit:]]", "") %>%  
  str_squish()

```

### Remove Stopwords 
To remove common stopwords (e.g., "a", "the", "and") from the text

```
clean_data <- clean_data %>% 
  mutate(Consumer.complaint.narrative = removeWords(Consumer.complaint.narrative, stop_words$word))

```

### Tokenization
Convert the text into individual words

```
tokens <- clean_data %>% 
  unnest_tokens(word, Consumer.complaint.narrative)
```

### Remove some words: 
Filter out any unwanted words, such as placeholders (e.g., "XXXX")
```
df_words <- df_words %>% 
  filter(!str_detect(word, "^x+$"))

```

### Save the Cleaned Data: Write the cleaned tokens to a new CSV file 'cleaned_consumer_complaints.csv'

```
write.csv(tokens, "cleaned_consumer_complaints.csv", row.names = FALSE)


```

### Data Summary
| | Word |
|-|:--: |
|1| received |
|2| capital |
|3| one |
|4| charge |
|5| card |
|6| offer |
|7| applied |
|8| accepted |
|9| limit |
|10| activated |

## Data Analysis

### Bing Lexicon

![bing](https://github.com/user-attachments/assets/080d018c-ff61-441e-b742-507d04edc98d)
* The sentiment scores of consumer complaints vary widely, with most complaints showing negative sentiment.
* A significant number of complaints have highly negative sentiment values, suggesting strong dissatisfaction.
* The high density of negative scores indicates a predominance of negative words in consumer grievances.

### NRC Analysis

![nrc](https://github.com/user-attachments/assets/12e6d526-a6b5-40ac-aad4-1b04c8b9df07)
* Negative emotions such as negative sentiment, sadness, anger, and fear dominate the complaints.
* Trust and positive sentiment are present but significantly lower than negative emotions.
* High anticipation levels may indicate consumers expressing hope for resolution.
* Surprise and joy are the least frequent sentiments, suggesting that very few complaints express positive emotions.

### Word Cloud

![word_cld](https://github.com/user-attachments/assets/1c42e672-577b-48a0-8d4e-18839f933b46)
* Common complaint-related words include "debt," "company," "money," "due," "paid," "letter," "call," and "time", indicating financial disputes as a major concern.
* Frequent mention of "collection," "accounts," "fees," and "charges" suggests issues with billing, debt collection, and financial mismanagement.
* Words like "contact," "request," and "statement" imply that consumers frequently reach out for resolutions but may face communication barriers.

### Conclusion

* Consumer complaints exhibit overwhelmingly negative sentiment, indicating widespread dissatisfaction.
* Financial disputes, debt collection, and billing issues are the most common reasons for complaints.
* Trust and positive sentiment are relatively low, suggesting that companies need to improve customer confidence and satisfaction.
* Consumers frequently mention communication-related terms (e.g., "call," "request," "statement"), implying challenges in resolving issues   with service providers.
* The presence of "anticipation" sentiment suggests that consumers expect resolutions but may not always receive satisfactory responses.
* Companies should focus on improving transparency, communication, and dispute resolution processes to enhance customer satisfaction.









