#Uncomment the line below if you haven't yet installed the tidyverse. Make sure your computer is connected to the internet when you do so.
#You only need to do this once.

#install.packages("tidyverse)
library(ggplot2)
library(dplyr)

# Welcome to a demonstration of the central limit theorem

#Let's start with a discrete random variable, call it X
#We'll encode the probability distribution for X into a data.frame using cumulative probability.
#X has six values. Create a dataframe with two columns, where for the ith row, the first column contains the ith value and the the second column contains the probability of x <= i.
#In other words, create a data.frame as so:

# Value 1 | P(X <= 1)
# Value 2 | P(X <= 2)
# Value 3 | P(X <= 3)
# Value 4 | P(X <= 4)
# Value 5 | P(X <= 5)
# Value 6 | P(X <= 6).

#Call it dist, and make sure the last cumulative probability is 1.

#Now, let's pick 500 values using this distribution, grab their sample mean, and do that 200 times. Let's loop!
maincounter <- 1
finalmeans <- data.frame()
while (maincounter <= 1000){
  counter = 1
  results <- data.frame()
  while (counter <= 150){
    #Let's start with a random probabilty value.
      prob <- runif(1, min(dist[, 2]), 1)
    #Now, let's pick the maximum element, a, from our distribution with p(x <= a) <= prob
    #There are two ways to do this, to use looping, I could do.
      val <- 0
    #Loop over all rows
      for (i in 1:nrow(dist)){
    #If the cumulative probability is less than the one we chose randomly.
        if (dist[[i,2]] <= prob){
    #Choosing the maximum one of these values.
          if (dist[[i,2]] > val){
            val <- dist[[i,1]]
          }
        }
      }
    #If I wanted to do something a little computationally faster, (and elegant) I could use vectorized operations as so.
      val <- dist[dist[, 2] == max(dist[dist[, 2] <= prob, 2]),1]
    #Now that we've picked a value, let's store it and repeat.
    results <- dplyr::bind_rows(results, data.frame(c(counter), c(val)))
    counter <- counter + 1
  }
  #Let's fix the column names in our results data.frame, to make it easier to use.
  names(results) <- c("Draw", "Value")
  smean <- mean(results$Value)
  finalmeans <- dplyr::bind_rows(finalmeans, data.frame(c(maincounter), c(smean)))
  maincounter <- maincounter + 1
}
names(finalmeans) <- c("Sample", "Mean")