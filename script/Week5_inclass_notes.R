#Week 5 notes

install.packages("tidyverse")

library(tidyverse)

read_csv("Data/portal_data_joined.csv")

surveys <- read_csv("Data/portal_data_joined.csv")

str(surveys)

#"tibble" dataframe
#columns are characters - never converted to factors

#select: use when you want to select columns in a dataframe

select(surveys, plot_id, species_id, weight)

#filter is used for selecting rows

filter(surveys, year == 1995)

surveys2 <- filter(surveys, weight < 5)

surveys_sml <- select(surveys2, species_id, sex, weight)

#pipes %>% on a PC: control-shift-M; MAC: command-shift-M

surveys %>% 
  filter(weight < 5) %>% 
  select(species_id, sex, weight)

#Challenge! Subset "surveys" to include individuals collected before 1995 and retain only the columns year, sex, weight

surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight)

#mutate is used to create new columns

surveys <- surveys %>% 
  mutate(weight_kg = weight/1000) %>% 
  mutate(weight_kg2 = weight_kg * 2)

# "!" <- negating operator i.e. "is not"

surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  summary()

#"complete cases" to filter out allof the NAs

#Challenge! Create a new data frame from the surveys data that meets the following criteria: contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30.

surveys_hf <- surveys %>%
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  filter(!is.na(hindfoot_half)) %>% 
  filter(hindfoot_half < 30) %>% 
  select(species_id, hindfoot_half)

#"group_by" is good for split-apply-combine; "summarize" creates a new dataframe, and is usually used after "group_by"

surveys %>%
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

#mutate adds new columns to an existing dataframe, summarize spits out a new dataframe

surveys %>%
  group_by(sex) %>% 
  mutate(mean_weight = mean(weight, na.rm = TRUE)) %>% View()

surveys %>%
  filter(is.na(weight)) %>% View() #way to view NA within the dataframe

surveys %>%
  group_by(species) %>% 
  filter(is.na(sex)) %>% 
  tally() #tells us where NAs are in species' sex

#you can use group_by with multiple columns

surveys %>%
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% View()

#naN = not a number - probably comes from trying to divide by 0; we need to remove NAs before calculating means

surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% View()

surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE), min_weight = min(weight)) %>% View()

#tally function

surveys %>%
  group_by(sex) %>% 
  tally() %>% View()

surveys %>%
  group_by(sex, species_id) %>% 
  tally() %>% View()

tally_df <- surveys %>%
  group_by(sex, species_id) %>% 
  tally() 

#tally is the same as group_by(something) %>%  summarize(new column = n())

#gathering and spreading

#spread takes data, key column variable, value column variable

surveys_gw <- surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

View(surveys_gw)

surveys_spread <- surveys_gw %>% 
  spread(key = genus, value = mean_weight)

#to fill NAs with 0

surveys_gw %>% 
  spread(genus, mean_weight, fill = 0) %>% View()

#Gathering

surveys_gather <- surveys_spread %>% 
  gather(key = genus, value = mean_weight, -plot_id)


