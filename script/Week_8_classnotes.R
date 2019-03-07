#Week 8 class notes

library(lubridate)
library(tidyverse)

load("Data/mauna_loa_met_2001_minute.rda")

as.Date("02-01-1998", format= "%m-%d-%Y")

mdy("01-24-1990")

tm1 <- as.POSIXct("2016-07-24 23:55:26 PDT")

tm1

tm2 <- as.POSIXct("25072016 08:32:07", format= "%d%m%Y %H:%M:%S")
tm2

tm3 <- as.POSIXct("2010-12-01 11:42:03", tz= "GMT")
tm3

#specifying time zone and date format in the same call

tm4 <- as.POSIXct(strptime("2016/04/04 14:47", format= "%Y/%m/%d %H:%M", tz= "America/Los_Angeles"))

tm4

tz(tm4)

Sys.timezone()

#do the same thing with lubridate

ymd_hm("2016/04/04 14:47", tz= "America/Los_Angeles")

ymd_hms("2016-05-04 22:14:11", tz= "GMT")

nfy <- read_csv("Data/2015_NFY_solinst.csv", skip = 12)

View(nfy)

nfy2 <- read_csv("Data/2015_NFY_solinst.csv", skip = 12, col_types = "ccidd")

glimpse(nfy2)

nfy2 <- read_csv("Data/2015_NFY_solinst.csv", skip = 12, col_types = cols(Date=col_date())) #read everything normal except for the date column
#just an example. Not using this one

nfy2$datetime <- paste(nfy2$Date, sep = " ", nfy2$Time)

#also nfy2$datetime <- paste(nfy2$Date," ", nfy2$Time, sep = "")

nfy2$datetime <- ymd_hms(nfy2$datetime, tz = "America/Los_Angeles")

glimpse(nfy2)

summary(mloa_2001)

mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

glimpse(mloa_2001) #datetime is a character - how do we change it into a datetime

mloa_2001$datetime <- ymd_hm(mloa_2001$datetime)

glimpse(mloa_2001)

#Challenge with dplyr & ggplot: remove the NA’s (-99 and -999) in rel_humid, temp_C_2m, windSpeed_m_s.Use dplyr to calculate the mean monthly temperature (temp_C_2m) using the datetime column (HINT: look at lubridate functions like month()) Make a ggplot of the avg monthly temperature Make a ggplot of the daily average temperature for July (HINT: try yday() function with some summarize() in dplyr)

mloa2 <- mloa_2001 %>% 
  filter(rel_humid !=-99, rel_humid !=-999) %>% 
  filter(temp_C_2m !=-99, temp_C_2m !=-999) %>% 
  filter(windSpeed_m_s !=-99, windSpeed_m_s !=-999)

mloa3 <- mloa2 %>% 
  mutate(which_month = month(datetime, label = TRUE)) %>%#label = FALSE would make the months into numeric months i.e. Jan =1
  group_by(which_month) %>% 
  summarise(avg_temp = mean(temp_C_2m))
  
View(mloa3)

mloa3 %>% 
  ggplot()+
  geom_point(aes(x=which_month, y = avg_temp), size = 3, color="blue")+
  geom_line(aes(x=which_month, y= avg_temp, group = 1))
#don't forget to set group = 1

#### Functions #### 

my_sum <- function(a=1,b=2){
  the_sum <- a+b
  return(the_sum)
}

my_sum()

my_sum(a=3,b=7)

#create a function that converts the temp in Kelvin to the temp in Celcius (-273.15 from Kelvin to get celcius)

KtoC <- function(a){
  Celcius <- a - 273.15
  return(Celcius)
}

KtoC(100)

list <- c(8,9,130)

KtoC(list)

#### Iteration ####

#Iterate instead of copy&paste

x <- 1:10

log(x)

# for loops - will repeat some bit of code with a new input value

for(i in 1:10){
  print(i)
}

for (i in 1:10) {
  print(i)
  print(i^2)
}

#we can use the "i" value as an index

for(i in 1:10){
  print(letters[i])
  print(mtcars$wt[i])
}

#make a results vector ahead of time

results <- rep(NA,10)

for(i in 1:10){
  results[i] <- letters[i]
}
results
