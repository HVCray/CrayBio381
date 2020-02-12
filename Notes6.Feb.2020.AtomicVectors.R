# More function and tricks with atomic vectors
# February 6, 2020
# HVC


# Notes -------------------------------------------------------------------

# create atomic vector, specify its mode and length
z <- vector(mode="numeric",length=0)
z <- c(z,5)
print(z)
# This is dynamic sizing. Don't do this in R because it gets really slow. 
# Instead: pre-allocate space to a vector: Preferred way
z <- rep(0,100)
head(z)

# Fill with NA values.
z <- rep(NA,100)
head(z)

typeof(z)
z[1] <- "Washington"
typeof(z)
# This gives it a type "after the fact".

# Assigning regular names without needing to type it all out. 
v_size <- 100
my_vector <- runif(v_size)
my_names <- paste("Species",seq(1:length(my_vector)),sep="")
# Taking the word species and pasting it with the sequence starting at 1 and going to the length of the vector. 
head(my_names)
# Gives out Species1, etc.
names(my_vector) <- my_names
head(my_vector)
# Assigns a number to each Species1, Species2, etc. 
# Can change the number after v_size in like 27 and run the whole chunk again. 

# Repeat Function ---------------------------------------------------------
# Rep function for repeating elements. 
rep(0.5,6)
# Repeats 0.5 6 times.
# In console: type ?rep will bring up help page that will tell you what the inputs are. X considered the first entry, the element or vector you want to repeat. 3 other parameters: times, length out, each. 
rep(x=0.5, times=6)
# Better practice. 
# Will still work if reverse order when define: 
rep(times=6, x=0.5)

my_vec <- c(1,2,3)
rep(x=my_vec, times=2)
rep(x=my_vec,each=2)
# Repeats each element the number of specified times. 
rep(x=my_vec,times=my_vec)
# Repeats the vector elements with eachother: matching them up
rep(x=my_vec, each=my_vec)
# Will give warning message: using 1 as the constant because values aren't matching up. 


# Using sequence function -------------------------------------------------

seq(from=2, t=4) # First way
2:4
# Does the same thing. This is an inline operator. Second way.  
`:`(2,4) # Third way. Does the same thing
seq(from=2, to=4,by=0.5)
# Goes up in increments of by= term
x <- seq(from=2, to=4, length=7)
print(x)
# Length function divides it up into number of chunks 
my_vec <- 1:length(x)
# Not for large numbers. But will do the same. 
# Faster way: 
seq_along(my_vec)
# Preferred way!!!!


# Using random number generator --------------------------------------------

runif(5)
runif(n=5,min=100,max=110)


# Random normal distributions ---------------------------------------------

rnorm(5)
rnorm(n=5,mean=100,sd=30)
library(ggplot2)
z <- runif(1000)
# Generates 1000 random values
qplot(z)
# Gives you a plot of it (non-normal distribution)
z <- rnorm(1000)
qplot(z)
# Gives you a plot of it with a normal distribution


# Sample function ---------------------------------------------------------
# Use sample function to draw random values from an existing vector
long_vec <- seq_len(10)
print(long_vec)
sample(x=long_vec)
# Reorders them randomly
# Sampling w/o replacement
sample(x=long_vec, size=3)

# Sampling with replacement
sample(x=long_vec, size=16,replace=TRUE)
# Some elements occur more than once. When replace not = to TRUE, will give an error because not enough elements. 

# These have all been equally probable
# Now try a weighted sampling

my_weights <- c(rep(20,5), rep(100,5)) # This weights the variables
print(my_weights)
sample(x=long_vec, replace=TRUE,prob=my_weights)


# Sub-setting atomic vectors: techniques -------------------------------------------------------------

z <- c(3.1,9.2,1.3,0.4,7.5)

# First way to subset: with positive index values
z[c(2,3)]
# Pulls out the 2nd and 3rd element of the list
# Or: with negative values
z[-c(1,5)]

# Second way: create a logical vector of conditions for subsetting
z[z<3]
tester <- z<3
print(tester)
z[tester] # coercing tester into integer values

# Third way: which function to find slots
which(z<3)
# tells you which index markers are less than three: gives you position values
z[which(z<3)]
# Does the same thing

# Fourth way: length for relative positioning
 z[-c(length(z):(length(z)-2))]
# negative sign creates an exclusion. Runs max length of sequence to two elements less. 
 
 # Fifth way: using named vector elements
 names(z) <- letters[1:5]
z
# Associates a letter with the values
z[c("b","b")]


# Relational Operators ----------------------------------------------------

# < less than
# > greater than
# <= less than or equals
# >= greater than or equals
# == equal to (single = is an assignment operator, not a logical one)

# Logical Operators -------------------------------------------------------
# ! before a statement converts to "not:
# & an and operator (applies to a vector)
# | is or (for a vector)
# xor(a,b( is a or b, but not a and b
# && is and for first element of vector only
# || is a first element or evaluator

# Examples

x <- 1:5
y <- c(1:3,7,7)
x == 2
# TRUE for second element only
x != 2
# x NOT EQUAL to 2

x ==1 & y ==7
# All false because nothing meets those conditions
x == 1 | y==7
x == 3 | y==3
xor(x==3,y==3)
x == 3 && y == 3


# Subscripting ------------------------------------------------------------

# Subscript with missing values
set.seed(90)
z <- runif(10)
z
z < 0.5
z[z < 0.5] # grabs all elements less than 0.5
which(z < 0.5)
z[which(z< 0.5)]

zD <- c(z,NA,NA)
zD[zD<0.5]
zD[which(zD<0.5)]
# Drops the NAs to make vector shorter: the caveat of using which. Be careful if you want to drop values, use which. If not, use the direct option. 

