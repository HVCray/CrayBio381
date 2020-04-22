# 3/5/2020
# dplyr II


# Exorting and Importing data ---------------------------------------------
library(dplyr)
data(starwars)

starwars1 <- select(starwars, name:species)
head(starwars1)
# write.table() function
write.table(starwars1, file="StarwarsNamesInfo.csv", row.names = FALSE, sep = ',')

data <- read.csv(file = "StarwarsNamesInfo.csv", header = TRUE, sep = ',', stringsAsFactors = FALSE, comment.char = "#")
head(data)

data <- read.table(file= "StarwarsNamesInfo.csv", header=TRUE, sep= ',', stringsAsFactors = FALSE)
head(data)

# Converting data frame to tibble
class(data)
data <- as_tibble(data)
glimpse(data)
class(data)

# If you're only working in R:
# saveRDS() good for only using R

saveRDS(starwars1, file= "StarWarsTibble")
# This saves the R object directly into your directory

sw <- readRDS("StarWarsTibble")


# More dplyr --------------------------------------------------------------

glimpse(sw)
# Counting NAs
sum(is.na(sw))
# will just give you how many NAs you have in the data set

# how many are not NAs: 
sum(!is.na(sw))
# tells you your sample size after excluding NAs

swSp<- sw %>%
  group_by(species) %>%
  arrange(desc(mass))

# determining sample size in each group
swSp %>%
  summarize(avgMass = mean(mass, na.rm=TRUE), avgHeight = mean(height, na.rm = TRUE), n=n())


# filter out low sample size
swSp %>%
  summarize(avgMass = mean(mass, na.rm=TRUE), avgHeight = mean(height, na.rm = TRUE), n=n()) %>%
  filter(n>=2) %>%
  arrange(desc(n))


# count() helper function
swSp %>%
  count(eye_color) # gives number of individuals with the given eye color (also grouped by species)
swSp %>%
  count(wt=height)
# gives 'weight' (sum)


# Summary Functions -------------------------------------------------------
# you use base R functions a lot

starwarsSummary <- swSp %>%
  summarize(avgHeight = mean(height, na.rm = TRUE), medHeight = median(height, na.rm = TRUE), height_sd = sd(height, na.rm = TRUE), height_IQR = IQR(height, na.rm = TRUE), min_height = min(height, ra.rm = TRUE), first_height = first(height), n=n(), n_eyecolors = n_distinct(eye_color)) %>%
  filter(n >= 2) %>%
  arrange(desc(n))
starwarsSummary


# Grouping and Ungrouping Multiple Variables ------------------------------

# cleaning up to remove NAs
sw2 <- sw[complete.cases(sw),]

sw2groups <- group_by(sw2, species, hair_color)

summarize(sw2groups, n=n())

sw3groups <- group_by(sw2, species, hair_color, gender)
summarize(sw3groups, n=n())

# Ungrouping
sw3groups %>%
  ungroup() %>%
  summarize(n=n())

# Grouping with mutate
# example: standrdize within groups

sw3 <- sw2 %>%
  group_by(species) %>%
  mutate(prop_height = height/sum(height)) %>%
  select(species, height, prop_height)
sw3

sw3 %>%
  arrange(species) # will do in alphabetical order



# Pivot_longer and picot_wider function ---------------------------------------------------
# compare to gather() and spread()
TrtA <- rnorm(n=20,mean=50,sd=10)
TrtB <- rnorm(n=20, mean=45, sd=10)
TrtC <- rnorm(n=20, mean=62, sd=10)
z <- data.frame(TrtA, TrtB, TrtC)
library(tidyr)
print(z)

long_z <- gather(z, Treatment, Data, TrtA:TrtC)
z2 <- z %>%
  pivot_longer(TrtA:TrtC, names_to="Treatment", values_to="Data")
print(z2)
# converts it to 60 rows, 2 columns wide
# better for ANOVA or box plot

# Pivot_wider 
# use: names_from and values_from

vignette("pivot")
