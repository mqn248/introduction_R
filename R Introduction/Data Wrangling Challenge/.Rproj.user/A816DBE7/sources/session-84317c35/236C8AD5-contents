install.packages("tidyverse")
library(tidyverse)

#import the data 
household_sample <- read_csv("~/Documents/R Introduction/L4H_sample_data-main/sample_data/L4H_household_baseline_sample.csv")
individual_sample <- read_csv("~/Documents/R Introduction/L4H_sample_data-main/sample_data/L4H_individual_baseline_sample.csv")
mother_sample <- read_csv("~/Documents/R Introduction/L4H_sample_data-main/sample_data/L4H_mother_baseline_sample.csv")

#clean column names (janitor)
install.packages("janitor") 
library(janitor)
household_clean <- clean_names(household_sample)
individual_clean <- clean_names(individual_sample)
mother_clean <- clean_names(mother_sample)

#Filter data in baseline household data where the hh_eligible is 1
library(dplyr)
hh_household <- filter( household_clean, hh_eligible == 1)

#Merge the datasets
individual_nzero <- individual_clean |>
  rename(number_0 = number)
individual_mother <- full_join(individual_nzero,mother_clean,by = "number_0")
data_merge <- full_join(individual_mother,household_clean,by = "household_id")

#Recode:
recode_merged <- data_merge |>
  mutate(reason_for_ineligibility = recode(reason_for_ineligibility, "1" = "No adult occupier >16 years", "2" = "Withdrawal", "3" = "Other reason" )) |>
  mutate(rspntgndr = recode(rspntgndr, "1" = "Male", "2" = "Female")) |>
  mutate(h_hfrml_eductn = recode(h_hfrml_eductn, "1" = "Not completed Primary school", "2" = "Primary school", "3" = "Secondary school", "4" = "College graduate", "5" = "Madrassa", "6" = "Other")) |>
  mutate(rspndtmarital = recode(rspndtmarital, "1"="Single", "2"="Married monogamous", "3"="Married polygamous", "4"="Divorced/ separated", "5"="Widow or widower")) |>
  mutate(rspndt_eductn = recode(rspndt_eductn, "1" = "No formal education", "2" = "Primary school", "3" = "Secondary school", "4" = "College graduate", "5" = "Madrassa", "6" = "Other")) |>
  mutate(maincme = recode(maincme,"1"="Sale of livestock & livestock products", "2"="Sale of crops", "3"="Trading/business", "4"="Employment (salaried income)", "5"="Sale of personal assets", "6"="Remittance", "7"="Other"))

# Separate the Variables:
separate_merged <- recode_merged |>
  separate(lvstckown, c("lvstckown1", "lvstckown2", "lvstckown3", "lvstckown4", "lvstckown5", "lvstckown6", "lvstckown7", "lvstckown8", "lvstckown9", "lvstckown10", "lvstckown11", "lvstckown12", "lvstckown13", "lvstckown14", "lvstckown15"), " ") |>
  separate(herdynamics, c("herdynamics1", "herdynamics2", "herdynamics3", "herdynamics4", "herdynamics5", "herdynamics6", "herdynamics7"), " ")

#Create Study Arms
library(dplyr)
addedcol_merged <- separate_merged |>
  mutate(study_arm = case_when(
    village.x%in%c("Lependera", "Gobb Arbelle", "Nahgan-ngusa", "Sulate", "Saale-Sambakah", "Namarei", "Manyatta Lengima", "Lokoshula", "TubchaDakhane", "Rengumo-Gargule") ~ "Study arm 1",
    village.x%in%c("Galthelian-Torrder", "Uyam  village", "Galthelan Elemo", "Nebey", "Rongumo_kurkum", "Urawen_Kurkum", "Eisimatacho", "Manyatta K.A.G", "Ltepes Ooodo", "Lorokushu, Marti", "Manyatta Juu West/East", "Lbaarok1") ~ "Study arm 2",
    TRUE ~ "Study arm 3"
  ))

#Create Herd Dynamics
herd_dynamics1 <- addedcol_merged |>
  select("interview_date.x", "household_id", "study_arm", "cwsbrth", "shpbrth", "goatsbrth", "cmlsbrth", "calves_death", "bulls_death", "cows_death", "sheep_death", "msheep_death", "fsheep_death", "goats_death", "mgoats_death", "fgoats_death", "camels_death", "mcamels_death", "fcamels_death", "cowsgft", "sheepgfts", "goatsgft", "cmlsgft", "cowsgvnout", "sheepgvnout", "goatsgvnout", "cmlsgvnout")
#Create monthyear
herd_dynamics2 <- herd_dynamics1 |>
  mutate(monthyear = format(interview_date.x, "%Y-%m"))

#Calculate animal stats for study_arm & monthyear & make subset
herd_dynamics3 <- herd_dynamics2 |>
  group_by(study_arm, monthyear) |>
  select(monthyear, study_arm, cwsbrth, shpbrth, goatsbrth, cmlsbrth, calves_death, bulls_death, cows_death, sheep_death, msheep_death, fsheep_death, goats_death, mgoats_death, fgoats_death, camels_death, mcamels_death, fcamels_death, cowsgft, sheepgfts, goatsgft, cmlsgft, cowsgvnout, sheepgvnout, goatsgvnout, cmlsgvnout) |>
  mutate(across(c(cwsbrth, shpbrth, goatsbrth, cmlsbrth, calves_death, bulls_death, cows_death, sheep_death, msheep_death, fsheep_death, goats_death, mgoats_death, fgoats_death, camels_death, mcamels_death, fcamels_death, cowsgft, sheepgfts, goatsgft, cmlsgft, cowsgvnout, sheepgvnout, goatsgvnout, cmlsgvnout),
                ~as.numeric(recode(.x, "---" = "0")))) |>
  summarise(
    cwbrth_total = sum(cwsbrth, na.rm = TRUE),
    shpbrth_total = sum(shpbrth, na.rm = TRUE),
    goatbrth_total = sum(goatsbrth, na.rm = TRUE),
    cmlbrth_total = sum(cmlsbrth, na.rm = TRUE),
    cwdeath_total = sum(calves_death, bulls_death, cows_death, na.rm = TRUE),
    shpdeath_total = sum(sheep_death, msheep_death, fsheep_death, na.rm = TRUE),
    goatdeath_total = sum(goats_death, mgoats_death, fgoats_death, na.rm = TRUE),
    cmldeath_total = sum(camels_death, mcamels_death, fcamels_death, na.rm = TRUE),
    cwgft_total = sum(cowsgft, na.rm = TRUE),
    shpgft_total = sum(sheepgfts, na.rm = TRUE),
    goatgft_total = sum(goatsgft, na.rm = TRUE),
    cmlgft_total = sum(cmlsgft, na.rm = TRUE),
    cwgvnout_total = sum(cowsgvnout, na.rm = TRUE),
    shpgvnout_total = sum(sheepgvnout, na.rm = TRUE),
    goatgvnout_total = sum(goatsgvnout, na.rm = TRUE),
    cmlgvnout_total = sum(cmlsgvnout, na.rm = TRUE))

#Visualizing
library(ggplot2)
herd_dynamics4 <- herd_dynamics3 |>
  pivot_longer(cols=c("cwbrth_total", "shpbrth_total", "goatbrth_total", "cmlbrth_total", "cwdeath_total", "shpdeath_total", "goatdeath_total", "cmldeath_total", "cwgft_total", "shpgft_total",
                      "goatgft_total", "cmlgft_total", "cwgvnout_total", "shpgvnout_total", "goatgvnout_total", "cmlgvnout_total"), names_to = "Category", values_to = "Quantity") |>
  mutate(Species = case_when(
    Category%in%c("cwbrth_total","cwdeath_total", "cwgft_total", "cwgvnout_total") ~ "Cow",
    Category%in%c("shpbrth_total", "shpdeath_total", "shpgft_total", "shpgvnout_total") ~ "Sheep",
    Category%in%c("goatbrth_total","goatdeath_total", "goatgft_total", "goatgvnout_total") ~"Goat",
    Category%in%c("cmlbrth_total", "cmldeath_total", "cmlgft_total", "cmlgvnout_total") ~ "Camel")) |>
  mutate (Event = case_when(
    Category%in%c("cwbrth_total", "shpbrth_total", "goatbrth_total", "cmlbrth_total") ~ "Birth",
    Category%in%c("cwdeath_total", "shpdeath_total", "goatdeath_total", "cmldeath_total") ~ "Death",
    Category%in%c("cwgft_total", "shpgft_total", "goatgft_total", "cmlgft_total") ~ "Gift",
    Category%in%c("cwgvnout_total", "shpgvnout_total", "goatgvnout_total", "cmlgvnout_total") ~ "Given Away"))

herddynamics_plot <- herd_dynamics4 |>
  ggplot(aes(monthyear, Quantity, color = Species, fill= Species)) + geom_col() + facet_grid("Event") + labs( y="Number of animals", title="Herd Dynamics", x="Time period (year-month)") 
herddynamics_plot






