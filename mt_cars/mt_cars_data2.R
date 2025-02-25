# Load ggplot2
library(ggplot2)

#Load the mtcars dataset
data (mtcars)

#View the first few rows
head (mtcars)

#Create a table of cylinder counts
cyl_counts <- table (mtcars$cyl)

#Create a bar chart
barplot (cyl_counts,
         main = "Number of Cars by Cylinder Count",
         xlab = "Number of Cylinders",
         ylab = "Count of Cars",
         col = "skyblue",
         border = "black")

# Convert cyl to a factor for categorical plotting
mtcars$cyl <- as.factor(mtcars$cyl)

# Create the bar chart
ggplot(mtcars, aes(x = cyl, fill = cyl)) +
  geom_bar() +
  labs(title = "Number of Cars by Cylinder Count",
       x = "Number of Cylinders",
       y = "Count of Cars") +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal()

geom_bar(stat = "identity")

# Compute mean mpg per cylinder
mpg_by_cyl <- aggregate(mpg ~ cyl, data = mtcars, FUN = mean)
# Create the bar chart
ggplot(mpg_by_cyl, aes(x = cyl, y = mpg, fill = cyl)) +
  geom_bar(stat = "identity") +
  labs(title = "Average MPG by Cylinder Count",
       x = "Number of Cylinders",
       y = "Mean MPG") +
  scale_fill_brewer(palette = "Set1") +
  theme_minimal()