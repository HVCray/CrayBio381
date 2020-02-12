# Working with matrices, lists, and data frames
# 11 Feb. 2020
# HVC 


# ------------------------------------------------------------------------
library(ggplot2)

# Matrices ----------------------------------------------------------------
# a matrix is just an atomic vector reorganized into two dimensions
# Create a matrix using the matrix function

m <- matrix(data=1:12,nrow=4,ncol=3)
print(m)
m <- matrix(data=1:12,row=4)

# use by row=TRUE to change filling direction
m<- matrix(data=1:12,nrow=4,byrow=TRUE)
print(m)

# use dim() function to tell you the dimensions of your matrix. 
dim(m)

# can also change dimensions using dim
dim(m) <- c(6,2)
# product of numbers inside c() must equal the length of the atomic vector
print(m)
# produces two columns and six rows
dim(m) <- c(4,3)
print(m)

# Individual row and column dimensions
nrow(m)
ncol(m)
# will tell you how many rows or columns you have

# length of atomic vector is still there
length(m)
# tells you the length is 12

# Naming matrices
rownames(m) <- c("a","b","c","d")
print(m)
colnames(m) <- LETTERS[1:ncol(m)]
print(m)
rownames(m) <- letters[nrow(m):1] # reverses order
print(m)

# specifying elements within a matrix
# grabbing an entire atomic vector
z <- runif(3)
z[]
# gives you back all the elements

# specifying rows and columns, separated by a comma
m[2,3]
m
# row 2, column 3

# choose row 2 and all of the columns in the matrix
m[2,]
m[,3]
# specify for particular rows or columns

# print everything
print(m)
print(m[])
print(m[,])

# dimnames requires a list
dimnames(m)
# will tell you your dimension names
dimnames(m) <- list(paste("Site",1:nrow(m),sep=""),
                    paste("Species",1:ncol(m),sep="_"))
# transpose a matrix
print(m)
m2 <- t(m)
print(m2)                    

# add a row to a matrix with rbind()
m2 <- rbind(m2,c(10,20,30,40))
print(m2)
rownames(m2)

# call the function to get the atomic vector
rownames(m2)[4] <- "myfix" # rownames creates atomic vector, [] specifies the fourth row
rownames(m2)[5] <- "myfix2"
rownames(m2)
print(m2)

# access rows and columns with names as well as index numbers
m2["myfix","Site3"]
m2[4,3]
m2[c("myfix","Species_1"),c("Site2","Site2")]

# cbind() will add a column to a matrix

my_vec <- as.vector(m)
print(my_vec)


# Lists -------------------------------------------------------------------

# Lists are like atomic vectors (1-dimensional), but each element can hold different things of different types and sizes

my_list <- list(1:10,
                matrix(1:8,nrow=4,byrow=TRUE),
                letters[1:3],
                pi)
str(my_list)                
# Asks about its structure

# try grabbing one of our list components
my_list[4]
# prints off a double bracketed number 1
my_list[4] - 3
# Produces an erro: we called it incorrectly
typeof(my_list[4])
# We are trying to subtract a number from an element of the list
# single brackets always returns a list from a list
# use double brackets
tyopeof(my_list[[4]])
 ## double bracket always extracts a single element of the correct type. 
my_list[[4]] - 3

# if a list has 10 elements, it is like a train with 10 cars
# [[5]] gives me the contents of car #5
# [c(4,5,6)] gives me a little train with cares 4, 5, and 6 linked together. 
# [5] just gives one car: care #5
my_list[[2]][2,2]

# name list items as we create them
my_list2 <- list(Tester=FALSE, 
                 little_m=matrix(runif(9),nrow=3))
print(my_list2)
my_list2$littlem[2,3]
my_list2$little_m
t(my_list2$little_m)
my_list2$kittle_m[2,]
my_list2$little_m[2]

# Using a list to access output from a linear model
y_var <- runif(10)
x_var <- runif(10)
my_model <- lm(y_var~x_var)
qplot(x=x_var, y=y_var)
print(my_model)
summary(my_model)
str(summary(my_model))

# Use the unlist() function to flatten the output
z <- unlist(summary(my_model),recursive=TRUE)
print(z)
# Then just look for what you want to find- coefficient number corresponds to the summary

my_slope <- z$coefficients2
my_pval <- z$coefficients8
print(c(my_slope,my_pval))


# Data Frames -------------------------------------------------------------

# data frame = a list of equal=lengthed vectors, each of which is a column in a data frame. 

# A data frame differs from a matrix only in that different columns may be of different data types

var_a <- 1:12
var_b <- rep(c("Con","LowN","HighN"),each=4)
var_c <- runif(12)
d_frame <- data.frame(var_a,var_b,var_c,stringsAsFactors = FALSE)
print(d_frame)
head(d_frame) # just the first 6 elements to view
str(d_frame)

# Adding a row: multiple data types
new_data <- list(var_a=13,var_b="HighN",var_c=0.668)
str(new_data)
d_frame <- rbind(d_frame,new_data)
print(d_frame)
# Adding a row: set up as a list to add an additional data point so that R can match up types into the correct place. 

# Adding a column: as an atomic vector (all the same data type)
new_var <- runif(nrow(d_frame))
d_frame <- cbind(d_frame,new_var)
head(d_frame)
