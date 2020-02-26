# Experimental designs
# 2/20/2020


# Regression analysis -----------------------------------------------------

n <- 50 
# number of observations (rows)
var_a <- runif(n)
# 50 random uniforms (independent variable = var_a)
var_b <- runif(n)
# dependent variable 
var_c <- 5.5 + var_a*10
id <- seq_len(n)
# sets up a noisy linear relationship between var_a and var_c

# creates a sequence from 1 to n if n > 0 
reg_df <- data.frame(id,var_a,var_b,var_c)
str(reg_df)
head(reg_df)

# analysis
reg_model <- lm(var_b~var_a,data=reg_df)
reg_model
# gives you coefficients
str(reg_model)
head(reg_model$residuals)
# first 6 residual values from the fitted model

# summary od model has what we want
summary(reg_model)
# gives intercepts, error, R^2, p-value
summary(reg_model)$coefficients
# gives intercepts
str(summary(reg_model))

z <- unlist(summary(reg_model))

# unlist the results to pull out elements
# bundle observations into lists
print(z)
reg_sum <- list(intercept=z$coefficients1,
                slope=z$coefficients2,
                intercept_p=z$coefficients7,
                slope_p=z$coefficients8,
                r2=z$r.squared)
reg_sum$intercept
# prints out the value for the summary statistics


# Regression plot for data ------------------------------------------------

library(ggplot2)
reg_plot <- ggplot(data=reg_df,
                   aes(x=var_a,y=var_c)) + geom_point() + stat_smooth(method=lm,se=0.95)
print(reg_plot)
# gives a scatterplot with a regression line overlaid at a 95% CI about the uncertainty of the line. 

# Basic ANOVA model -------------------------------------------------------------
n_group <- 3
# number of treatment groups
n_name <- c("Control","Treatment1","Treatment2")
n_size <- c(12,17,9)
n_mean <- c(60,60,60)
n_sd <- c(5,5,5)
t_group <- rep(n_name,n_size)
print(t_group)
table(t_group)
# counts up the numbers in each group. 

id <- 1:(sum(n_size))
res_var <- c(rnorm(n=n_size[1],mean=n_mean[1],sd=n_sd[1]),
           rnorm(n=n_size[2],mean=n_mean[2],sd=n_sd[2]),
rnorm(n=n_size[3],mean=n_mean[3],sd=n_sd[3]))

ano_data <- data.frame(id,t_group,res_var)
str(ano_data)             

# ANOVA model -------------------------------------------------------------

ano_model <- aov(res_var~t_group, data=ano_data)
# ~ means "as a function of.."
print(ano_model)
print(summary(ano_model))
z <- summary(ano_model)
str(z)
aggregate(res_var~t_group,data=ano_data,FUN=mean)
# FUN = function
# breaks res_var into groups of t_group, then apply function.

unlist(z)
unlist(z)[7]
# calls out the particular element you want to extract
ano_sum <- list(Fval=unlist(z)[7],
                probF=unlist(z)[9])
ano_sum
library(ggplot2)
library(MASS)


# ggplot for ANOVA data ---------------------------------------------------

ano_plot <- ggplot(data=ano_data,
                   aes(x=t_group,
                       y=res_var,
                       fill=t_group)) +
                      geom_boxplot()
print(ano_plot)
# to save your work but retain its repeatability
ggsave(filename="Plot2.pdf",plot=ano_plot,device="pdf")
# Saves it to hard drive, will change the plot if you rerun the code with different numbers. 


# Data Frame for Logistic Regression  -------------------------------------
# discrete y variable (0 or 1) and a continuous x variable. 
# sort() command puts things in numeric order
x_var <- sort(rgamma(n=200,shape=5,scale=5))
head(x_var)              
y_var <- sample(rep(c(0,1),each=100),prob=seq_len(200))
# create a vector: 200 total characters, 100 0s followed by 100 1s. 
# prob = weights it so that #s toward the 200th character in the vector length = more likely
head(y_var)
l_reg_data <- data.frame(x_var,y_var)

# Logistic regression code ------------------------------------------------

l_reg_model <- glm(y_var~x_var,
                   data=l_reg_data,
                   family=binomial(link=logit))
# family refers to type of data, link specifies mathematical family
summary(l_reg_model)
summary(l_reg_model)$coefficients


# Basic ggplot of logistic regression data --------------------------------

lreg_plot <- ggplot(data=l_reg_data,
                    aes(x=x_var,y=y_var)) +
            geom_point() +
            stat_smooth(method=glm,
                        method.args=list(family=binomial))
print(lreg_plot)
# the curve gives you the estimated probability of a 1 


# Contingency table data --------------------------------------------------

# in both x and y variables are discrete (=counts) 
# integer counts of different groups
vec_1 <- c(50,66,22)
vec_2 <- c(120,22,30)
data_matrix <- rbind(vec_1,vec_2)
rownames(data_matrix) <- c("Cold","Warm")
colnames(data_matrix) <- c("Aphaenogaster",
                           "Camponotus",
                           "Crematogaster")
str(data_matrix)
print(data_matrix)

# Simple association test -------------------------------------------------

print(chisq.test(data_matrix))


# base R graphics ---------------------------------------------------------

mosaicplot(x=data_matrix,
           col=c("violet","aquamarine3","black"),
           shade=FALSE)
barplot(height=data_matrix,
        beside=TRUE,
        col=c("cornflowerblue","grey","ivory"))

# ggplot graph ------------------------------------------------------------
library(tidyverse)
library(rlang)
library(ggplot2)
d_frame <- as.data.frame(data_matrix)
d_fram <- cbind(d_frame, list(Treatment=c("Cold","Warm")))
d_frame <- gather(d_frame,key=Species,Aphaenogaster:Crematogaster,value=Counts)
head(d_frame)x

p <- ggplot(data=d_frame,
            aes(x=Speces,y=Counts,fill=Treatment))+
  geom_bar(stat="identity",
           position="dpdge",
           color=I("black"))+
  scale_fill_manual(values=c("cornflowerblue","coral"))
print(p)