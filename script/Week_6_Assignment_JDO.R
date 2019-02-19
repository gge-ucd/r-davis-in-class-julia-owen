library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp))+
  geom_point()

#1A: make a figure to show how life expectancy has changed over time

summary(gapminder)

ggplot(gapminder, aes(x=year, y=lifeExp, color = continent))+
  geom_point()

#Changed x-axis to year and color colded the continents to better visualize change over time

#1B Look at the following code. What do you think the scale_x_log10() line is doing? What do you think the geom_smooth() line is doing?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#scale_x_log10 places the x-axis on a log scale - makes the data easier to visualize

#geom_smooth adds a regression line - in general, it "aids the eye in seeing patterns in the presence of overplotting

#1C. (Challenge!) Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot? Save this code in your scripts folder and name is w6_assignment_ABC.R with your initials.

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, size = pop)) +
  geom_point(aes(color = continent, alpha = 0.5)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#I changed the point size to equal "pop" 
#When adding "size = pop" to the ggplot script line or the geom_point script line, both methods worked
#I also decreased the alpha to better see overlap 
