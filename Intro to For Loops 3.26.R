# ----------------------------------
# Lecture 19: Control Structures: For loops
# 31 Mar 2020
# HVC
# ----------------------------------

# called a loop because they loop through a set of commands repetitively. 

# Anatomy of a for loops: 
# for (var in seq) { # start of the loop

# body of the for loop

# } # end of for loop

# var is a counter variable that holds the current value of how many times the loops has been run. Current value of the counter in the loops

# seq is an integer vector (or vector of character strings) that defines starting and ending values of the loop.

# use variables 1, j, k for the var(counter)

# HOW NOT TO SET UP A FOR LOOP

my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")
for (i in my_dogs) {
  print(i)
}
# problem: we can only access their names, not their position. 

# HOW TO SET UP A FOR LOOP CORRECTLY

for (i in 1:length(my_dogs)) {
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}
# this give both position and the character string
# one potential hazard: suppose our vector is empty: :

my_bad_dogs <- NULL

for (i in 1:length(my_bad_dogs)) {
  cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}
# first loop counter = 1, second loop counter = 0, not what we wanted. 

# Safer way to code var in the for loop is to use seq_along()

for (i in seq_along(my_dogs)) {
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}
# runs the same. 
# ALSO allows you to run with an empty vector. 
my_bad_dogs <- NULL

for (i in seq_along(my_bad_dogs)) {
  cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}

# seq_along() prevents errors!!

# ALTERNATIVELY: could also define vector length from a constant using seq_len()
zz <- 5
for (i in seq_len(zz)) {
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}
# works just fine. 


# For loop tips -----------------------------------------------------------

# TIP #1: do not change object dimensions inside a loop
# AVOID these functions: cbind(), rbind(), c(), and list
# Slows it WAY down: 

my_dat <- runif(1)
for (i in 2:10) {
  temp <- runif(1)
  my_dat <- c(my_dat,temp) # don't do this!
  cat("loop number =", i, "vector element =", my_dat[i], "\n")
}
print(my_dat)

# if you try to run this with a lot of numbers, it wil be VERY slow.

# TIP #2: do not do things in a loop if you do not need to- be concise. Do only what is necessary. 

# Don't do this: 
for (i in 1:length(my_dogs)) {
  my_dogs[i] <- toupper(my_dogs[i]) 
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}
z <- c("dog","cat","pig")
toupper(z)
# Do the transition to upper-case OUTSIDE the loop like seen above. 

# TIP #3: Do not use a loop if you can vectorize!

my_dat <- seq(1:10)
for (i in seq_along(my_dat)) {
  my_dat[i] <- my_dat[i]+ my_dat[i]^2
  cat("loop number =", i, "vector element=", my_dat[i], "\n")
}
# Runs just fine but this doesn't need a loop to do it. 
# See: 
# No loop needed: 
z <- 1:10
z <- z + z^2
print(z)
# Does this more easily than a for loop. 

# TIP #4: Understand the distinction between the counter variable i, and the vector element that is specified by z[i]. 

z <- c(10,2,4)
for (i in seq_along(z)) {
  cat("i =", i, "z[i] =", z[i], "\n")
}
# i changes 1, 2, 3 and z goes by position in the vector. Are distinct. 

# What is the value of i at the end of the loop?
print(i)
# this gives the final value assigned to it from the last pass through the loop.

# What is the value of z at the end of the loop?
print(z)
# gives your the vector of values out since we didn't change their values, but would give you the resultants. 

# TIP #5: USe next() function to skip certain elements of the for loop

z <- 1:20
# Suppose we want to work ONLY with the odd-numbered elements.

for (i in seq_along(z)) {
  if (i %% 2==0) next
  print(i)
}
# gives you only the odd values.
# next usually used in conjunction with an if statement

# Another way to do this: faster (why?)

z <- 1:20
z_sub <- z[z %% 2!=0] # contrast with logical expression in loop
length(z)
length(z_sub)
for (i in seq_along(z_sub)) {
  cat("i = ", i, "z_sub[i] = ", z_sub[i], "\n")
}
# no next statement but we subsetted the vector initially. Loop is now only half as long because the subsetting is done outside of the loop. 

# Break Function ----------------------------------------------------------
# TIP #6: Use break to set up a conditional to break out of a loop early. 
# creating a simple random walk population model function

# ----------------------------------
# FUNCTION ran_walk
# description: stochastic random walk
# inputs: times = number of time steps
#         n1 = initial population size     #              (=n[1])
#         lambda = finite rate of increase
#         noise_sd = standard deviation of #         a normal distribution with mean 0
# outputs: vector n with popoulation sizes #         > 0 until extinction, then NA 
#         values.
####################################
library(ggplot2)

ran_walk <- function(times=100,
                     n1=50,
                     lambda=1.0,
                     noise_sd=10) { # fxn start
  n <- rep(NA,times) # create output vector
  n[1] <- n1 # initializing starting population size
  noise <- rnorm(n=times, mean=0, sd=noise_sd)
  # creating random noise vector. This is outside the loop.
  for (i in 1:(times - 1)) { # start of for loop
    n[i + 1] <- n[i]*lambda + noise[i]
    if(n[i + 1] <=0) { # start of if statement
      n[i + 1] <- NA
      cat("Population extinction at time", i, "\n")
    break } # end of if statement
  } # end of for loop
  return(n) # end of function

return("Checking...ran_walk")

} # end of ran_walk
# ----------------------------------

# Explore model parameters interactively with simple graphics. 

pop <- ran_walk()
qplot(x=1:100,y=pop,geom="line")

# Checking out performance with no noise
pop <- ran_walk(noise_sd=0)
qplot(x=1:100,y=pop,geom="line")
# gives you a straight line, population doesn't change.

pop <- ran_walk(noise_sd=0, lambda=1.1)
qplot(x=1:100,y=pop,geom="line")
# gives an exponential growth curve

pop <- ran_walk(noise_sd=0, lambda=0.98)
qplot(x=1:100,y=pop,geom="line")
# exponential decrease

# With a little noise
pop <- ran_walk(noise_sd=1, lambda=0.98)
qplot(x=1:100,y=pop,geom="line")
# Same shape but noise adds to short-term dynamics. As noise_sd increases, you get more and more variation and spikes. 


# Double for loops ---------------------

m <- matrix(round(runif(20),digits=2),nrow=5)

# loop over the rows of the matrix
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
}

# Loop over columns
m <- matrix(round(runif(20),digits=2),nrow=5)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)

# Looping over both rows AND columns using a DOUBLE for loop

m <- matrix(round(runif(20),digits=2),nrow=5)
for (i in 1:nrow(m)) { # start outer loop
  for (j in 1:ncol(m)) { # start inner (column) loop
    m[i,j] <- m[i,j] + i + j
  } # end of inner (column) loop
} # end of outer (row) loop
print(m)














