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