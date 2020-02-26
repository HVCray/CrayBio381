# Continuous Distributions
# Feb 20, 2020

library(ggplot2)
library(MASS)

# Uniform -----------------------------------------------------------------
qplot(x=runif(n=100,min=1,max=6),
              color=I("black"),
              fill=I("orchid"))

qplot(x=runif(n=1000,min=1,max=6),
      color=I("black"),
      fill=I("orchid"))
qplot(x=sample(1:6,size=1000,replace=TRUE))


# Normal ------------------------------------------------------------------

my_norm <- rnorm(n=100,mean=100,sd=2)
qplot(x=my_norm,
      color=I("black"),
      fill=I("papayawhip"))

# problems with the normal distribution arise when the mean is small 
my_norm <- rnorm(n=100,mean=2,sd=2)
qplot(x=my_norm,
      color=I("black"),
      fill=I("papayawhip"))
# have values below 0, which is sometimes not possible
my_norm <- rnorm(n=100,mean=2,sd=2)
toss_zeroes <- my_norm[my_norm>0]
qplot(x=toss_zeroes,
      color=I("black"),
      fill=I("papayawhip"))
mean(toss_zeroes)
sd(toss_zeroes)


# Gamma -------------------------------------------------------------------

# use for continuous data greater than zero
my_gamma <- rgamma(n=100,shape=1,scale=10)
qplot(x=my_gamma,
      color=I("black"),
      fill=I("aquamarine1"))

# gamma with shape=1 is exponential with the scale = mean
my_gamma <- rgamma(n=110,shape=1,scale=0.1)
qplot(x=my_gamma,
      color=I("black"),
      fill=I("aquamarine1"))

# Increasing the shape parameter makes it look more normal
my_gamma <- rgamma(n=100,shape=20,scale=1)
qplot(x=my_gamma,
      color=I("black"),
      fill=I("aquamarine1"))

# scale parameter changes both the mean and the variance of the distribution
# mean in a gamma distribution = shape*scale
# variance in a gamma = shape*scale^2


# Beta  -------------------------------------------------------------------

# continuous but bounded between 0 and 1- useful for probability models
# analogous to a binomial but with a continuous distributuion of possible values
# p(data|parameters)
# p(parameters|data) = maximum likelihood estimator of parameters

# parameters for beta: shape1 = number of success +1 and shape2 = number of failures + 1

my_beta <- rbeta(n=1000,shape1=50,shape2=50)
qplot(x=my_beta,
      color=I("black"),
      fill=I("pink"))
# beta with three heads and no tails
my_beta <- rbeta(n=1000,shape1=4,shape2=1)
qplot(x=my_beta,
      color=I("black"),
      fill=I("pink"))

# when no data: 
my_beta <- rbeta(n=1000,shape1=1,shape2=1)
qplot(x=my_beta,
      color=I("black"),
      fill=I("pink"))
# produces a uniform distribution that will tell you that all the options will be equally probable. Then can add data and the shape of the beta distribution will adjust. 

my_beta <- rbeta(n=1000,shape1=2,shape2=1)
qplot(x=my_beta,
      color=I("black"),
      fill=I("pink"))
# shape and scake less than 1.0 gives a u-shaped curve
my_beta <- rbeta(n=1000,shape1=0.2,shape2=0.1)
qplot(x=my_beta,
      color=I("black"),
      fill=I("pink"))
# gives probability peaks at both extremes


# Maximum Likelihood Calculations -----------------------------------------

# estimating parameters from data

x <- rnorm(1000,mea=92.5,sd=2.5)
qplot(x=x,
      color=I("black"),
      fill=I("springgreen"))
library(MASS)
fitdistr(x,"normal")
# this is to fit the values to a chosen distribution
# gives you the parameters associated with that type of distribution and a measure of uncertainty: in this case for a normal sistribution, it gives mean and standard deviation.
# problem is that you don't always know which distribution will best fit your data

fitdistr(x,"gamma")
# now simulate using the parameters
x_sim <- rgamma(n=1000,shape=1367,rate=14.81)
qplot(x=x_sim,
      color=I("black"),
      fill=I("springgreen"))

# some data will not fit one distribution exclusively- may be mixed-model. 