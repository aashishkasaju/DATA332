# Library
library(ggplot2)
library(viridis)
library(hrbrthemes)

# create a dataset
specie <- c(rep("sorgho" , 3) , rep("poacee" , 3) , rep("banana" , 3) , rep("triticum" , 3) )
condition <- rep(c("normal" , "stress" , "Nitrogen") , 4)
value <- abs(rnorm(12 , 0 , 15))
data <- data.frame(specie,condition,value)

# Grouped
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar(position="dodge", stat="identity")

# Stacked
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar(position="stack", stat="identity")

# Stacked + percent
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar(position="fill", stat="identity")

# Small multiple
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_viridis(discrete = T) +
  ggtitle("Studying 4 species..") +
  theme_ipsum() +
  xlab("")

# Graph
ggplot(data, aes(fill=condition, y=value, x=condition)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_fill_viridis(discrete = T, option = "E") +
  ggtitle("Studying 4 species..") +
  facet_wrap(~specie) +
  theme_ipsum() +
  theme(legend.position="none") +
  xlab("")