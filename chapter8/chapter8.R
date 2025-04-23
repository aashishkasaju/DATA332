# The S3 System
num <- 1000000000
print(num)

class(num) <- c("POSIXct", "POSIXt")
print(num)

# Attributes
attributes(deck)
row.names(deck)
levels(deck) <- c("level 1", "level 2", "level 3")
attributes(deck)

# Exercise
play <- function() {
  symbols <- get_symbols()
  print(symbols)
  score(symbols)
}

# New version of play
play <- function() {
  symbols <- get_symbols()
  prize <- score(symbols)
  attr(prize, "symbols") <- symbols
  prize
}

play()
two_play <- play()
two_play

# Generate prize and set its attribute in a step
play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}
three_play <- play()
three_play

# Display slot results
slot_display <- function(prize){
  # Extract symbols
  symbols <- attr(prize, "symbols")
  # Collapse symbols into single string
  symbols <- paste(symbols, collapse = " ")
  # Combine symbol with prize as a regular expression
  # \n is regular expression for new line (i.e. return or enter)
  string <- paste(symbols, prize, sep = "\n$")
  # Display regular expression in console without quotes
  cat(string)
}
slot_display(one_play)

# Generic functions
print(pi)
pi
print(head(deck))
head(deck)

print(play())
play()

# Methods
print
print.POSIXct
print.factor

# Exercise
print.slots <- function(x, ...) {
  slot_display(x)
}
one_play

# Exercise
play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols, class = "slots")
}
class(play())
play()

# Classes
methods(class = "factor")

play1 <- play()
play1

play2 <- play()
play2

c(play1, play2)

play1[1]