# ----------------------------------
# Randomization tests
# 06 Apr 2020
# HVC
# ----------------------------------
#

# statistical p-value is the probability of obtaining the observed results (or something more extreme) if the null hypothesis were true. p(data|H0)

# The null hypothesis is the hypothesis of "no effect" meaning that variation is caused by measurement error or other unspecified (and less important) sources of variation. 

# Two advantages of randomization tests: 
# 1. Relaxes the assumptions of standard parametric tests: normality, balanced sample sizes, common variance. 
# 2. They give a more intuitive understanding od statistical probability. 

# Steps in a randomization test ---------------------

# 1. Define a metric x as a single number to represent the pattern we are interested in. 

# 2. Calculate x(observed), the metric for the empirical (=observed) data that we start with. (from a real data set!)

# 3. Randomize or "reshuffle" the data. We randomize in a way that would uncouple any association betwee the observed data and their assignmnet to treatment groups. Ideally, randomization only affect the pattern of treatment effects in the data. Other aspects of the data (such as sample sizes) are preserved in the randomization. We are trying to simulate the null hypothesis.

# 4. For this single randomization, calculate x(sim). If the null hypothesis is TRUE, then x(sim) should be a similar value to x(observed). If the null hypothesis is FALSE, x(observed) is very different from x(sim). 

# 5. Repeat steps 3 and 4 many times- typically n=1000. This will let us visualize as a histogram the distribution of x(sim): the distribution of x values when the null hypothesis is true. 

# 6. Estimate the tail probability of the observed metric (or something more extreme) given the null distribution. The probability of x(observed) given H0: p(x(observed)|H0). 

# Preliminaries ---------------------

library(ggplot2)
library(TeachingDemos)

set.seed(100)
char2seed("espresso withdrawal")
options(digits=10) # optional
char2seed("espresso withdrawal",set=FALSE)

# Create treatment groups
trt_group <- c(rep("Control",4),rep("Treatment",5))
print(trt_group)

# Create response variable
z <- c(runif(4) + 1, runif(5) + 10)
print(z)

# Combine vectors into a single data frame
df <- data.frame(trt=trt_group,res=z)
print(df)

# Look at means in the two groups
obs <- tapply(df$res,df$trt,mean)
print(obs)

# Create a simulated data set

# Set up a new data frame based on the old one: 
df_sim <- df
df_sim$res <- sample(df_sim$res) # this randomizes: it reshuffles it. 
print(df_sim)

# Look a the means in the two groups of randomized data
sim <- tapply(df_sim$res,df_sim$trt,mean)
print(sim)




