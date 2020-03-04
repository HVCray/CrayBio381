### Manipulating data using dplyr
### HVC
### 3/4/2020


# What is dplyr? ----------------------------------------------------------
# new-ish package that provides a set of tools for manipulating data
# part of the tidyverseL collection of packages that share philosophy, grammar, and data structure
# specifically written to be fast
# indivudual functions that correspond to the most common operations
# easier to figure out what you want to do with your data

library(dplyr)

### Core Verbs
# filter() # rows
# arrange()
# select() # columns
# summarize() and group_by()
# mutate()



data(starwars)
class(starwars)
# "tbl" is specific to tidyverse: tibble is a modern take on data frames- dropped the frustrating parts of data frames- ex. changing variable names, input type, etc. 

glimpse(starwars)
# tells you number of variables, etc. easier to read than structure() in a data frame
head(starwars)
# tells you the variables and the class of each 

### Cleaning up the data if there are NAs
# complete.cases isn't part of dplyr

starwarsClean <- starwars[complete.cases(starwars[,1:10]),]
is.na(starwarsClean[,1])
anyNA(starwarsClean)
# False means there are no NAs left in the data set

### WHat does data look like now
glimpse(starwarsClean)
head(starwarsClean)


### filter(): allows you to pick or subset observations by their values
### uses >,>=, <, <=, !=, == for comparisons
### logical operators: &, | (or), ! (not)
### filter() automatically excludes NAs

filter(starwarsClean, gender=="male", height<180, height>100) # can use commas, multiple conditions for the same variable: something you can't do in dataframes. 

filter(starwarsClean, eye_color %in% c("blue","brown"))
# %in% uses blue and brown- looks for eye color that is either of those colors, similar to ==

### Arrange: arrange()
# rearranges rows
arrange(starwarsClean, by=height)
# default is ascending order
# for descending order: 
arrange(starwarsClean, by=desc(height))
arrange(starwarsClean, height, desc(mass))
# tie breaker: using mass to break a tie between heights that are the same
# add additional argument to break the ties in preceding column

starwars1 <- arrange(starwars, by=height)
tail(starwars1)
# places missing values at the end 


### SELECT
# select() chooses variables by their names
select(starwarsClean, 1:5)
# use numbers or variable names too: 
select(starwarsClean, name:species)
select(starwarsClean, name:height)
select(starwarsClean, -(films: starships))

# REARRANGE COLUMNS
# using select() function
select(starwarsClean, name, gender, species, everything())
# everything() says everything else goes afterward in the order it's in
# everything is a helper function, useful if you want to move a few variables to the beginning

select(starwarsClean, contains("color"))
# brings up the variables with the word "color" in it

# other helpers: ends_with(), starts_with(), matches (regular expressions), num_range
# not case-sensitive

select(starwarsClean, height, skin_color, films)
# not in clumps

### RENAMING COLUMNS
select(starwars, haircolor = hair_color, films)
# or
rename(starwarsClean, haircolor = hair_color)
# changes hair_color to haircolor

# MUTATE
# creates new variables with functions of existing variables

mutate(starwarsClean, ratio=height/mass)
# can use arithmetic operators: + - * / for an individual observation and an existing one
starwars_lbs <- mutate(starwarsClean, mass_lbs = mass*2.2)
# converts kg to lbs
head(starwars_lbs)
select(starwars_lbs, 1:3, mass_lbs, everything())

# TRANSMUTE
# just keeps the new variable
transmute(starwarsClean, mass_lbs = mass*2.2)
# creates a new data set with just the mutated variable

### SUMMARIZE AND GROUP_BY
 collapses down to a single summary
 
 summarize(starwarsClean, meanHeight = mean(height))

 # working with NAs
 summarize(starwars, meanHeight = mean(height, na.rm=TRUE), TotalNumber = n())
# n() tallies up your total number of observations used to calculate: sample size
 
 summarize(starwarsClean, meanHeight = mean(height), TotalNumber = n())

 starwarsGenders <- group_by(starwars, by=gender) 
head(starwarsGenders)

summarize(starwarsGenders, meanHeight=mean(height, na.rm=TRUE), number=n())



### PIPING
# Piping = used to emphasize a sequence of actions
# lets you take the output of one statement and use it as the input for the next. 
# avoid if you have meaningful intermediate results or if you want to manipulate more than one objcet at a time. 
## Formatting: have a space before the pipe, followed by a new line
# pipe: %>%

starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight = mean(height), number = n())

heightsSW <-starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight = mean(height), number = n())
