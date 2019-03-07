#Week 8 homework

library(tidyverse)

am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)

glimpse(am_riv)

# 1. Make a datetime column by using paste to combine the date and time columns; remember to convert it to a datetime!

am_riv$datetime <- paste(am_riv$Date, "", am_riv$Time)
glimpse(am_riv)

am_riv$datetime <- ymd_hms(am_riv$datetime)
glimpse(am_riv)

# 2. Calculate the weekly mean, max, and min water temperatures and plot as a point plot (all on the same graph)

am_riv$week <- week(am_riv$datetime)
glimpse(am_riv)

am_riv_Weekly <- am_riv %>%
  mutate(which_week = week(datetime)) %>% 
  group_by(which_week) %>% 
  summarise(avg_temp=mean(Temperature),max_temp=max(Temperature), min_temp=min(Temperature))

am_riv_Weekly %>% 
  ggplot()+
  geom_point(aes(x=which_week, y = avg_temp), size = 3, color="blue")+
  geom_point(aes(x=which_week, y = max_temp), size = 3, color="red")+
  geom_point(aes(x=which_week, y = min_temp), size = 3, color="green")+
  xlab("Week")+
  ylab("Temperature")+
  theme_classic()

# 3. Calculate the hourly mean Level for April through June and make a line plot (y axis should be the hourly mean level, x axis should be datetime)

am_riv$month <- month(am_riv$datetime)
am_riv$hour <- hour(am_riv$datetime)
glimpse(am_riv)

am_riv_AMJ <- am_riv %>% 
  filter(month == 4 | month==5 | month==6) %>% 
  group_by(hour, month, datetime) %>% 
  summarise(avg_level=mean(Level))

am_riv_AMJ %>% 
  ggplot()+
  geom_line(aes(x=datetime, y=avg_level))+
  ylab("Average Level")+
  xlab("Date")+
  theme_minimal()

#Use the mloa_2001 data set (if you don’t have it, download the .rda file from the resources tab on the website). Remeber to remove the NAs (-99 and -999) and to create a datetime column (we did this in class).

load("Data/mauna_loa_met_2001_minute.rda")

mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

mloa_2001$datetime <- ymd_hm(mloa_2001$datetime)
glimpse(mloa_2001)

mloa2 <- mloa_2001 %>% 
  filter(temp_C_2m !=-99, temp_C_2m !=-999) %>% 
  filter(temp_C_2m !=-99, temp_C_2m !=-999) %>% 
  filter(windSpeed_m_s !=-99, windSpeed_m_s !=-999)

#Then, write a function called plot_temp that returns a graph of the temp_C_2m for a single month. The x-axis of the graph should be pulled from a datetime column (so if your data set does not already have a datetime column, you’ll need to create one!)

mloa2$month <- month(mloa2$datetime)

mloa3 <- mloa2 %>% 
  group_by(month,datetime,temp_C_2m) %>% 
  summarise() #This step is not actually needed - it limits the columns i'm working with to only month, datetime, and temp_C_2m

plot_temp <- function(choose_month, dat=mloa2){
  the_plot <- mloa3 %>% 
    filter(month==choose_month) %>% 
    ggplot()+
    geom_line(aes(x=datetime, y=temp_C_2m))+
    theme_minimal()
  return(the_plot)
}

plot_temp(2)

