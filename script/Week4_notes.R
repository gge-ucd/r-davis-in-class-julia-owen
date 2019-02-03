#Week 4 Code (1/29/19)
#Completed by me 02/03/19

#First, pull repository from GitHub

#Intro to dataframes

#dataframd - how R stores tables of data
#Every column is a vector  <- all the same type of data i.e. all integers or all characters 

download.file(url = "https://ndownloader.figshare.com/files/2292169",destfile = "Data/portal_data_joined.csv")

surveys <- read.csv(file = "Data/portal_data_joined.csv")

head(surveys)

#head <- every column with the headings and first 6 rows

#let's look at structure


str(surveys)

#dim give you dimensions i.e. number of rows and columns

dim(surveys)
nrow(surveys)
ncol(surveys)

#tail <- opposite of "head" gives the bottom rows of each column

tail(surveys)

#names  <- gives the name of every column printed as a character vector

names(surveys)

#note, rownames are printed as characters
rownames(surveys)

#another really useful one
summary(surveys)

#subsetting dataframes

#subsetting vectors by giving them a location index

animal_vec <- c("mouse","rat","cat")
animal_vec[2]

#dataframes are 2D!

surveys[1,1]

head(surveys)

surveys[2,1]

#[row,column]

surveys[1,6]

surveys[33000,1]

# whole first column
# the output is a VECTOR

surveys[,1]

#using a single number with no column gives us a datafram with one column

surveys[1]

head(surveys)
head(surveys[1])

# pull out the first 3 values in the 6th column
surveys[1:3,6]

animal_vec[c(1,3)]

c(1,3)

# pull out a whole single observation i.e. entire row <- will get back a dataframe

surveys[5,]

# use negative sign to exclude indices

surveys[1:5,-1]

surveys[-10:34786,]

# note: given as a dataframe

surveys[-c(10:34786),]

# use str to check if it's a dataframe or vector

str(surveys[-c(10:34786),])

surveys[c(10,15,20),]

surveys[c(10,15,20,10),]

# more ways to subset

surveys["plot_id"] #single column as dataframe

surveys[,"plot_id"] #single column as a vector

surveys [["plot_id"]] #single column as a vector, we'll come back to using double brackets with lists

surveys$year #single column as a vector

#challenge

#Create a data.frame (surveys_200) containing only the data in row 200 of the surveys dataset

surveys[200,]

surveys_200 <- surveys[200,]

#Notice how nrow() gave you the number of rows in a data.frame?
#Use that number to pull out just that last row in the data frame.

nrow(surveys)

surveys[34786,]

#compare that with what you see as the last row using tail() to make sure it’s meeting expectations.

tail(surveys)

#Pull out that last row using nrow() instead of the row number.

surveys[(nrow(surveys)),]

#Create a new data frame (surveys_last) from that last row.

surveys_last <- surveys[(nrow(surveys)),]

#Use nrow() to extract the row that is in the middle of the data frame. Store the content of this row in an object named surveys_middle.

nrow(surveys)

surveys_middle <- surveys[nrow(surveys)/2,]
surveys_middle

#Combine nrow() with the - notation above to reproduce the behavior of head(surveys), keeping just the first through 6th rows of the surveys dataset.

surveys[-c(7:nrow(surveys)),]

#**end of challenge**

#Finally, factors
# factors are stored as intigers with labels attached to them
#they have a pre-defined set of levels assigned to them

#creating our own factor

sex <- factor(c("male","female","female","male"))
sex

#note: prints as "Levels: female male" <- alphabetical
# females is assigned  "1", male is assigned "2"

class(sex) #factor
typeof(sex) #integer

#levels gives back a character vector of the levels
levels(sex)

levels(surveys$genus)

nlevels(sex)

concentration <- factor(c("high","medium","high","low"))
concentration #again, alphabetical order

#what if we want them in order of level, not alphabetical order

concentration <- factor(concentration,levels = c("low","medium","high"))
concentration

#lets try adding to a factor

concentration <- c(concentration, "very high")
concentration # coerces to characters if you add a factor that doesn't match the current level

#let's make them characters

as.character(sex)

#factors with numeric levels

year_factor <- factor(c(1990, 1923, 1965, 2018))

as.numeric(year_factor)

as.character(year_factor)

#this will actually give us a numeric vector
as.numeric(as.character(year_factor))

#recommended way to get numeric vector
#**LOOK BACK AT THIS**
as.numeric(levels(year_factor))[year_factor]

#why all the factors?
?read.csv
#strings of character vectors defaults as true

surveys_no_factors <- read.csv(file = "Data/portal_data_joined.csv", stringsAsFactors = FALSE)
str(surveys_no_factors)

#renaming factors
sex <- surveys$sex

levels(sex)

levels(sex)[1]

levels(sex)[1] <- "undetermined"
levels(sex)[1]

levels(sex)

head(sex)

#working with dates
library(lubridate)
#install.packages("lubridate") <- put install.packages into console so it doesn't re-install every time you run a script

library(lubridate)

my_date <- ymd("2015-01-01")

my_date
str(my_date)

my_date <- ymd(paste("2015","05","17", sep = "-"))
my_date

paste(surveys$year, surveys$month, surveys$day, sep = "-")

surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
surveys$date

surveys$date[is.na(surveys$date)]
