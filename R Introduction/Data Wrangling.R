# creating an object

object1 <- c(1,2,3,4,5,6,7,8,9,10)

# computing mean
mean(object1)

# computing median
median(object1)

# getting summary stats (minimum, median, mean etc)
summary(object1)

# installing packages
install.packages("tidyverse")

# loading packages
library(tidyverse)

# reading data
dat1 <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
#dat1 is an object
View(dat1)

# getting first 6 rows; last 6 rows (tail)
head(dat1)
tail(dat1)

# getting data structure
str(dat1)

#data types
# integer - whole numbers
# numeric/double - numbers (with decimals)
# character - words (names etc)
# factor - binary 
# date 
# currency

# check class type
class(dat1)

# use the $ to specify a column
mean(dat1$gre) # mean of gre column
summary(dat1$gre) # summary stats of gre column

# pipe ( |>)
# connect lines of code

# recode the admit column (0-deny, 1-accept) old=new
# making a new copy so that you can manipulate 2 and keep 1
dat2 <- dat1 |>
  mutate(admit=recode(admit, "0"="deny", "1"="accept"))

# rename columns (rank-position) new=old
dat3 <- dat1%>%
  rename(position=rank)

# load more data
ideal1 <- read.csv("https://raw.githubusercontent.com/cema-uonbi/R_course/main/ideal1.csv")

# data wrangling tasks
## change CaDOB to date format
## clean column names (rename)
## deal with NA in ReasonLoss column
## recode CalfSex column

# recode CalfSex column (1-male, 2-female)
ideal1a <- ideal1 %>%
  mutate(CalfSex = recode(CalfSex, "1"="male", "2"="female"))

# check column names
colnames(ideal1)

# clean column names (rename CADOB - calf_date_of_birth)
ideal1b <- ideal1 %>%
  rename(calf_date_of_birth = CADOB)
  
  
# column names in R (good coding habits)
## calf.date.of.birth 
## calf_date_of_birth
  
  
# clean column names (janitor)
install.packages("janitor") 

library(janitor)

ideal1c <- ideal1%>%
  clean_names()

# NA values??

# date  formats
## d - 1,2,...,31 (7/8/2023)
## D - 01,02,03,...,31 (07/8/2023)
## m - 1,2,...,12 
## M - 01,02,03,...,12
## b - Jan, Feb,...,Dec 
## B - January, February,...,March
## y - 21,22,...
## Y - 2021, 2022,...

# 3/1/2008 (d/m/Y)
# 2023-08-07 (Y-M-D)

install.packages("lubridate") (as_date())
library(lubridate)

# convert CADOB to date format
ideal1d <- ideal1|>
  dplyr::mutate(CADOB = as.Date(CADOB, format="%d/%m/%Y")) |>
  dplyr::arrange(CADOB) #arrange the data according to the date column

# confirm that CADOB has changed to date format
class(ideal1d$CADOB)

# check sublocations
table(ideal1$sublocation)

# subsetting
# If we wanted data from only one sublocation - Kidera

## using subset
idealkidera <- subset(ideal1, ideal1$sublocation=="Kidera")

## using filter
#idealkidera <- ideal1 |>
  #filter(sublocation == "Kidera")

# load more data 
ideal2 <- read_csv("https://raw.githubusercontent.com/ThumbiMwangi/R_sources/master/ideal2.csv")

# convert VisitDate into date format
ideal2a <- ideal2 %>%
  mutate(VisitDate = as.Date(VisitDate, format="%d/%m/%Y"))

# merging datasets
## left join
## right join
## full join
## inner join

ideal3 <- ideal1 %>% left_join(ideal2, by="CalfID")

# subset data using columns (select)
ideal3a <- ideal3 %>%
  select(CalfID,VisitID,VisitDate, Theileria.spp.,ELISA_mutans, ELISA_parva)

# pivot (make data longer)
ideal3b <- ideal3a %>%
  pivot_longer(cols = c(Theileria.spp., ELISA_mutans, ELISA_parva), names_to = "tests", values_to = "outcome")

# grouping data by CalfID and getting average weight for each calf 
ideal3c <- ideal3 %>%
  group_by(CalfID) %>%
  mutate(avrg_weight = mean(Weight, na.rm = TRUE)) %>%
  ungroup()%>%
  dplyr::select(CalfID, Weight, avrg_weight)

#load more data
dogdemography <- read_csv("https://raw.githubusercontent.com/cema-uonbi/R_course/main/DogcohortDemographics.csv")

# data wrangling tasks
## rename columns
## format interview date (to date format)
## recode logical variables (0-no, 1-yes)
## get average number of household members per village
## get average number of dogs owned per village

# interviewDate = IntDate # format as date 
# householdID = HousehldID # format as character
# villageID = VillageID # format as character (as.character)
# householdMembers = HhMmbrs # format as integer
# ownDogs = OwnDogs # format as logical
# numDogsOwned = DgsOwnd # format as integer (as.numeric)
# adultDogsOwned = AdltDgs # format as integer
# puppiesOwned = Puppies # format as integer
# dogDiedPastMonth = DogDied # format as logical (as.factor)
# numDogsDiedPastMonth = NumDd # format as integer
# dogBitesPastMonth = DogBite # format as logical 

dogdemography1 <- dogdemography %>%
  rename(interviewDate = IntDate 
      , householdID = HousehldID 
      , villageID = VillageID 
      , householdMembers = HhMmbrs
      , ownDogs = OwnDogs 
      , numDogsOwned = DgsOwnd 
      , adultDogsOwned = AdltDgs 
      , puppiesOwned = Puppies 
      , dogDiedPastMonth = DogDied 
      , numDogsDiedPastMonth = NumDd 
      , dogBitesPastMonth = DogBite) %>%
  mutate(interviewDate = as.Date(interviewDate, format="%m/%d/%y")) %>%
  # 0-no, 1-yes, else-NA
  mutate(dogBitesPastMonth = ifelse(dogBitesPastMonth=="0","No", ifelse(dogBitesPastMonth=="1","Yes", NA)))%>%
  mutate(villageID = as.character(villageID)) %>%
  group_by(villageID) %>%
  mutate(avrg_hh_mmbrs=round(mean(householdMembers))) %>%
  mutate(avrg_dogs = round(mean(numDogsOwned))) 
  



# load more data
ideal <- read_csv("https://raw.githubusercontent.com/ThumbiMwangi/R_sources/master/ideal3a.csv")

# summarize reasonsLoss
table(ideal$ReasonsLoss1)

library(tidyverse) # data wrangling
install.packages("ggplot2") 
library(ggplot2) # plotting

# plot
ggplot(data=ideal, aes(x=ReasonsLoss1)) +
  geom_bar() + #specify type of graph
  theme_bw() + # change background theme
  labs(x="Calf status at end of study", 
       y="Number of calves",
       title = "Graph showing Calf status") # add labels
library(dplyr)

# get frequency (count)
calves_sublocation<- ideal |>
  select(sublocation) |>
  group_by(sublocation) |>
  count()


# OR (alternatively)

# get frequency (summarise)
calves_sublocation<- ideal %>%
  select(sublocation) %>%
  group_by(sublocation) %>%
  summarise(freq=n())

# plot frequency
ggplot(calves_sublocation, aes(x=sublocation, y=freq))+
  geom_col()+
  theme_bw()+
  labs(x="Sublocation", y="Frequency")

# flip graph
ggplot(calves_sublocation, aes(x=sublocation, y=freq))+
  geom_col()+
  theme_bw()+
  labs(x="Sublocation", y="Frequency")+
  coord_flip() # flip graph

# reorder
ggplot(calves_sublocation, aes(x=reorder(sublocation, freq), y=freq))+ # reorder 
  geom_col()+
  theme_bw()+
  labs(x="Frequency", y="Sublocation")+
  coord_flip() # flip our graph

# get exact number of calves per sublocation (by removing duplicates)
calves_sublocation1 <- ideal %>%
  select (CalfID, sublocation) %>%
  distinct() %>% # remove duplicates
  group_by(sublocation) %>%
  summarise(number=n()) %>%
  ungroup()
  
ggplot(calves_sublocation1, aes(x=reorder(sublocation, number), y=number))+ 
  geom_col()+
  theme_bw()+
  labs(x="Number of calves", y="Sublocation")+
  coord_flip() 


# summarize by sublocation and gender
calves_gender<- ideal %>%
  select(sublocation, CalfSex) %>%
  mutate(CalfSex=recode(CalfSex, "1"="Male", "2"="Female")) %>%
  group_by(sublocation, CalfSex) %>%
  summarise(freq=n()) %>%
  ungroup()

# visualise the data using a bar graph
ggplot(calves_gender, aes(x=sublocation, y=freq, fill=CalfSex))+ # color the graph by sex
  geom_col()+
  theme_bw()+
  labs(x="Sublocation", y="Frequency")+
  coord_flip() 

# customize colors (from colorbrewer website)
ggplot(calves_gender, aes(x=sublocation, y=freq, fill=CalfSex))+ # color the graph by sex
  geom_col()+
  theme_bw()+
  scale_fill_manual(values = c("#fc8d59", "#91bfdb"))+
  #scale_fill_brewer(palette = "RdYlBu") + 
  labs(x="Sublocation", y="Frequency")+
  coord_flip() 


# summarize by sublocation and gender & get proportions
calves_gender1<- ideal %>%
  select(sublocation, CalfSex) %>%
  mutate(CalfSex=recode(CalfSex, "1"="Male", "2"="Female")) %>%
  group_by(sublocation, CalfSex) %>%
  summarise(freq=n()) %>%
  ungroup() %>%
  group_by(sublocation) %>%
  mutate(proportion=freq/sum(freq)*100)

ggplot(calves_gender1, aes(x=sublocation, y=proportion, fill=CalfSex))+ # color the graph by sex
  geom_col()+
  theme_bw()+
  scale_fill_manual(values = c("#fc8d59", "#91bfdb"))+
  #scale_fill_brewer(palette = "RdYlBu") + 
  labs(x="Sublocation", y="Proportion")+
  coord_flip()

Mumbua <- 0715256757
