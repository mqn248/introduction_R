library(tidyverse)
data()
library(ggplot2)
ggplot(data= BOD, 
       mapping=aes(x = Time, y = demand))+
  geom_point()

CO2 |>
  ggplot(aes(Treatment, uptake))+
  geom_boxplot()+
  geom_point(alpha =0.5, aes(size= conc, colour = Plant))+
  coord_flip()+
  theme_bw()+
  facet_wrap(~Type)+
  labs(title = "Chilled Vs Non-Chilled")

View(mpg)
mpg |>
  filter(cty <25) |>
  ggplot(aes(displ, cty))+
  geom_point(aes(colour = drv, size = trans), alpha =0.5)+
  geom_smooth(method=lm)+
  facet_wrap(~year, nrow =1)+
  labs(x= "Engine Size", y = "MPG in the city", title = "Fuel efficiency")+
  theme_minimal()

view(starwars)
#height use histogram/density plot for probability
#box plot distribution of the data/violin plot
#for one categorical data can use barplot; for more can use stacked barplot/grouped barplot
#for 2 category and 1 numeric - numeric drives the geometry and the categorical is to disaggregate so can use histo/boxplot and facets are categorical
#for 2 numeric and 1 categorical (height, weight, sex), scatter plot and then disaggregate with the categorical 

#order: data, mapping (aesthetics), geometry
install.packages("gapminder")
library(gapminder)
View(gapminder)
gapmider |>
  filter(continent %in% c ("Africa", "Europe")) |>
  filter(gdpPercap < 30000) |>
  ggplot(aes(gdpPercap, lifeExp, size = pop, color = year))+
  geom_point()+ #geometry
  facet_wrap(~continent)+ #disaggregate by continent
  labs(title= "Life expectancy explained by GDP", x = "GDP per capita", y = "Life expectancy")



#making a map
library(tidyverse)
library(sf)
library(ggthemes)
library(rnaturalearth)
library(rnaturalearthdata)

#world map
#create data object "world"; "ne_countries" comes from r natural earth; return class means it's able to be used w/ SF
world <- ne_countries(scale = "medium", returnclass = "sf")
view(world)

#plotting the dataset
world |>
  ggplot(aes(fill= income_grp))+
  geom_sf()+ #using sf to make the geom
  labs(title= "World Map by Income Group", fill="Income Group")+
  scale_fill_viridis_d()+
  theme_map()+  #gives white background
  theme(legend.position = "right", legend.title = element_text(face="bold"), plot.title = element_text(size= 50, color= "steel blue", hjust =0.5, face="bold"))

#africa map
world |>
  filter(region_un == "Africa") |>
  ggplot()+ #can also but aes here
  geom_sf(aes(fill = pop_est/1e6), color = "white", lwd =0.3)+ #1e6 is so legend is per million, color in lines is white and 0.3 size
  labs(title= "Africa by population size", fill = "Population/n(millions")+
  
  







