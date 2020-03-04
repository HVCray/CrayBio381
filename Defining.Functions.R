# Function structure and use
# Feb. 25, 2020
# HVC


#   -----------------------------------------------------------------------

# everything in R is a function
sum(3,2) # a "prefix" function
3+2 # an "operator" but it is actually a function
`+`(3,2) # rewritten as an "infix" function

y <- 3
print(y)

`<-`(yy,3)
print(yy)

# to see the contents of a function, print it
print(read.table)

sd
# print, essentially: gives you the function and how it's calculated
sd(c(3,2))
# call function with parameters
sd() # call function w/o any input, will give an error because needs values put in 

# Anatomy of a user-defined function --------------------------------------

function_name <- function(par_x=default_x,
                          par_y=default_y,
                          par_z=default_z) {
# try to use a verb to name it, assign parameters, short function codes if possible. 
# No complex naming systems
# following { is the function body: lines of r code and annotations, may call other functions or create others within the function. May also create local variables. 
  return(z) # returns from the function a single element
} # then a final curly bracket to end the line of code
function_name
function_name()
function_name(par_x=my_matrix,
              par_y="Order",
              par_z=1:10)

# Stylistic Aspects of Functions ------------------------------------------

# Use prominent hash fenching around your dunction code.
# Give a header with a function name and a description of input and output. 
# Names inside the function can be short because functions should be short and simple: no more than one screen line of text.
# If it's too complex, break it into multiple functions. 
# Provide default values for all input parameters so it can stand on its own and be tested. 
# Make those default values using 1 or more of the random number generators- this way you can test it with multiple data sets. 


# Function 1 --------------------------------------------------------------
#############################################

# FUNCTION: hardy_weinberg
# INPUT: an allele frequency p (0,1)
# OUTPUT: p and the frequencies of genotypes AA, AB and BB. 


#   -----------------------------------------------------------------------

hardy_weinberg <- function(p=runif(1)) {
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- list(p=p,
                  f_AA = f_AA,
                  f_AB = f_AB,
                  f_BB = f_BB)
  return(vec_out)
}
##############################################

hardy_weinberg()
hardy_weinberg(p=0.5)
pp <- 0.6
hardy_weinberg(p=pp)
print(hardy_weinberg)
# just get your code back, ty instead: 
print(hardy_weinberg(p=pp))
# will give you the output

#   -----------------------------------------------------------------------
#############################################

# FUNCTION: hardy_weinberg2
# INPUT: an allele frequency p (0,1)
# OUTPUT: p and the frequencies of genotypes AA, AB and BB. 

# with conditions

hardy_weinberg2 <- function(p=runif(1)) {
  if(p > 1.0 | p < 0.0){
    return("Function failure: p must be </= 1 and >/= 0")
  }
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- list(p=p,
                  f_AA = f_AA,
                  f_AB = f_AB,
                  f_BB = f_BB)
  return(vec_out)
}
##############################################
hardy_weinberg2()
hardy_weinberg(1.1)
# original runs but generates negative values: does not recognize the error because it doesn't have the built-in failsafe. 

hardy_weinberg2(1.1)
# kicks back your error message: but not quite right.
z <- hardy_weinberg2(1.1)
# code will run but when you look at z: gives you the error message
print(z)
# will create problems: so now we learn to use stop() to terminate function for true error trapping. 


# True Error Trapping -----------------------------------------------------
# using stop()

#############################################

# FUNCTION: hardy_weinberg3
# INPUT: an allele frequency p (0,1)
# OUTPUT: p and the frequencies of genotypes AA, AB and BB. 

hardy_weinberg3 <- function(p=runif(1)) {
  if(p > 1.0 | p < 0.0){
    stop("Function failure: p must be </= 1 and >/= 0")
  }
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- list(p=p,
                  f_AA = f_AA,
                  f_AB = f_AB,
                  f_BB = f_BB)
  return(vec_out)
}
###############################################
hardy_weinberg3(1.1)
# will generate the error: true error AND your error message
# assigning to z
z <- hardy_weinberg3(1.1)
# Returns your function failure message. 


# Global vs Local Variables -----------------------------------------------

# glocbal variables are visible in all parts of the code, are declared in the main body of the program. 
# local variables are visible only within the function. Either declared in the function or passed to it through the input parameters. 

# functions can "see" the variables in the global environment but the global environment cannot "see" variables in the function (local) environment. 

# Example: 
my_func <- function(a=3, b=4) {
  z <- a + b
  return(z)
}
my_func_bad <- function(a=3) {
  z <- a + b
  return(z)
}
my_func_bad()
# creating b
b <- 100
my_func_bad()
# now it works because it locally found a and found b globally. 
# Don't program this way because it will behave different dependent on the global environment. 
# always keep your variables local within the function. 

my_func_ok <- function(a=3) {
  bb <- 100
z <- a + bb
return(z)
}
my_func_ok()
# bb defined locally so it runs well. However now in the global environment: 
print(bb)
# get error message because globally bb does not exist, only in the local environment

# More functions ----------------------------------------------------------

##################################
# FUNCTION: fit_linear
# Fits a simple regression line
# INPUT: numeric vectors of predictor (z) and response (y)
# OUTPUT: slope and p-value of the regression line


#   -----------------------------------------------------------------------

fit_linear <- function(x=runif(20),
                       y=runif(20)) {
  my_mod <- lm(y~x)
  my_out <- list(slope=summary(my_mod)$coefficients[2,1],
                 p_val=summary(my_mod)$coefficients[2,4])
  plot(x=x,y=y)
  return(my_out)
}

#   -----------------------------------------------------------------------
fit_linear()


# More Complex Input Value ------------------------------------------------
##################################
# FUNCTION: fit_linear2
# Fits a simple regression line
# INPUT: numeric vectors of predictor (z) and response (y)
# OUTPUT: slope and p-value of the regression line


#   -----------------------------------------------------------------------

fit_linear2 <- function(p=NULL) {
  if(is.null(p)){
    p <- list(x=runif(20),y=runif(20))
  } 
  my_mod <- lm(p$y~p$x)
  my_out <- list(slope=summary(my_mod)$coefficients[2,1],
                 p_val=summary(my_mod)$coefficients[2,4])
  plot(x=p$x,y=p$y)
  return(my_out)
}

# ------------------------------------------------------------------------
fit_linear2()
my_pars <- list(x=1:10, y=runif(10))
fit_linear2(p=my_pars)
fit_linear2(my_pars)
# does the same thing

# use the do.call() to pass a list of paraneters to a function

z <- c(runif(99),NA)
mean(z)
# passes NA because R does not like a missing value
# na.rm takes out NA before calculating
# trim removes the outliers so it removes the values outside of the range are taken as the nearest endpoint. 

mean(x=z,na.rm=TRUE)
mean(x=z,na.rm=TRUE,trim=0.05)
my_list=list(x=z,na.rm=TRUE,trim=0.05)
mean(my_list)
# will throw an error because na.rm and trim are perceived as inputs: look for three different inputs but we only want one input: the numeric. 
# do.call() has only two inputs: the name of the function we want to call and a list of the parameters for that function. 
do.call(mean,my_list)
