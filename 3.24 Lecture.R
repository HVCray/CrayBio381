# ----------------------------------
# Control Structures
# 24 Mar 2020
# HVC
# ----------------------------------

# ----------------------------------
# Logical Operators


# Review of boolean operators ---------------------------------------------
# Simple inequalities: uses logical operators
5 > 3 # produces TRUE

5 < 3 # produces FALSE

5 >= 5 # produces TRUE
5 <= 5 # TRUE
5 == 3 # FLASE
5 != 3 # TRUE: 5 is not equal to 3

# Compound statements use an $ or | statement to evaluate, will produce a boolean value. 
# Use & for "and"
FALSE & FALSE # produces FALSE
FALSE & TRUE  # produces FALSE because & says they must be the same
TRUE & TRUE # produces TRUE because both the same on either side of &
5 > 3 & 1!=2 # TRUE
1 == 2 & 1!=2

# Use | for "or": need only one of the conditions to be met for a true 
FALSE | FALSE # FALSE
FALSE | TRUE # TRUE
TRUE | TRUE
1==2 | 1!=2 # TRUE

# Boolean operatirs work with vectors

1:5 > 3
# F,F,F,T,T

a <- 1:10
b <- 10:1

a > 4 & b > 4
# F,F,F,F,T,T,F,F,F,F

sum( a > 4 & b > 4) # coerces booleans to numeric values

# "long" form evaluates only the first element

#  & evaluate all elements and give a vector of T/F
a < 4 & b > 4

a < 4 && b > 4
# && evaluates only the first comparison that gives a boolean: TRUE because only the first comparison was a true output

# Long form for |: ||
# vector result
a < 4 | b > 4

# single boolean result
a < 4 || b > 4

# xor for exclusive "or" testing of vectors: works for (TRUE FALSE) but not for (FALSE FALSE) or (TRUE TRUE)

a <- c(0,0,1)
b <- c(0,1,1)
xor(a,b) # produces FALSE TRUE FALSE

# by comparison with an ordinary | statement
a | b
# gives FALSE TRUE TRUE



# Set Operations ----------------------------------------------------------

# Boolean algebra on sets of atomic vectors (numeric, logical, or character strings)
# R equivalent of a Venn diagram

a <- 1:7
b <- 5:10

# union function: to get all elements, non-repeating
union(a,b)

# intersection function: to get all common elements
intersect(a,b)

# setdiff function to get distinct elements in a that are not in b
setdiff(a,b)
#setdiff for distinct elements in b that are not in a
setdiff(b,a)

# setequal function to check for identical elements
setequal(a,b)
# returns FALSE if there are no identical elements

# to compare any two objects: 
z <- matrix(1:12,nrow=4,byrow=TRUE)
z1 <- matrix(1:12,nrow=4,byrow=FALSE)
# different element placements

# comparing the matrices: 
# element by element: 
z == z1
# gives boolean to check if the elements are in the same slots

identical(z,z1)
# gives boolean to tell you if the two items are the same

z1 <- z
identical(z,z1)

# %in% is the most useful (equivalent to is.element function)
# Gotelli prefers %in%

 d <- 12
d %in% union(a,b)
# boolean to tell you if it's there or not
# asking "is d part of that set"

is.element(d,union(a,b))
# equivalent but ugly

# tedious piece of code: 
a <- 2
a == 1 | a==2 | a==3
# will work but is cumbersome

# instead: equivalent but simpler
a %in% c(1,2,3)

# check for partial matching with vector comparisons
a <- 1:7

d <- c(10,12)
d %in% union(a,b) # T,F

d %in% a # F,F


# If statements -----------------------------------------------------------

# Anatomy of an if statement: 

# if(condition) expression to be executed
# if condition not met: expression will not be evaluated

# if(condition) expression1 else expression2
# if TRUE: expression 1, if FALSE: expression 2

# if (condition1) expression1 else
# if (condition2) expression2 else
# expression3

# - final unspecified else captures the rst of the unspecified conditions (conditions 1 and 2 are not true, so must run expression 3)
# else statement must appear on the same line as previous expression. 
# instead of single ecpression, you can use curly brackets to execute a sect of lines when the condition is met. {}

z <- signif(runif(1),digits=2)
print(z) # 0.45

# simple if statement with no else
if (z > 0.4) cat(z, "is a bigger than average number","\n")
z <- 0.2
if (z > 0.4) cat(z, "is a bigger than average number","\n")
# Nothing happens because we haven't given it an else statement. 

# Compound if statement with 3 outcomes (2 if statements)
if (z > 0.8) cat(z, "is a large number","\n") else
if (z < 0.2) cat(z, "is a small number","\n") else
{cat(z, "is a number of typical size","\n")
  cat("z^2 =",z^2,"\n")}
# the first two conditions were false so the compound statement (print and squaring) was executed. 
# when z=0.9, executes only the first if condition.

# if statement wants a single boolean value (TRUE or FALSE). If you give it a vector of booleans, it will operate only on the very first element in that vector. 

z <- 1:10

# this doesn't do what you want: 
if (z > 7) print(z)
# Will give a warning message telling you this. 

# Avoid: use subsetting!
print(z[z < 7])


# ifelse function ---------------------------------------------------------

# ifelse(test,yes,no)
# "test" is an object that can be coerced into a logical TRUE/FALSE. 
# "yes" returns values for TRUE elements in the test
# "no" returns values for the FALSE elements in the test

# suppose we have an insect population in which each female lays on average 10.2 eggs, following a Poisson distribution (discrete with simgle parameter lambda=10.2). However, there is a 35% chance of parasitism, in which case no eggs are laid. Here is a random sample of eggs laid for a group of 1000 individuals.

tester <- runif(1000)
eggs <- ifelse(tester > 0.35, rpois(n=1000,lambda=10.2),0)
hist(eggs)

# suppose we have a vector of probability values (perhaps from a simulation). We want to highlight significant values in the vector for plotting. 

pvals <- runif(1000)
z <- ifelse(pvals < 0.025,"lower tail","non-significant")
z[pvals >= 0.975] <- "upper_tail"
table(z)

# Using subsetting: 
z1 <- rep("non_sig",1000)
z1[pvals <= 0.025] <- "lower_tail"
z1[pvals >= 0.0975] <- "upper_tail"
table(z1)


















