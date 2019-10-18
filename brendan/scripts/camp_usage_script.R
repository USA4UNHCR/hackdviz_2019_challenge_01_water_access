# camp usage script

### provides starting point for analysis for first-time users of dataset

### reduces camp usage dataset to variables with a lot of observations
### produces a series of plots
### will work with new versions of this dataset in csv form as long as they use
### the same variable labeling

library(tidyverse)

camp_usage <- read_csv("data/Water_Usage_In_Camps_Most_Recent_Data.csv")

camp_usage_restricted <- camp_usage %>%
  select("COUNTRY NAME", 
         "EMERGENCY / POST-EMERGENCY", 
         "AVERAGE # LITERS OF POTABLE WATER AVAILABLE PER PERSON PER DAY", 
         "NUMBER OF PERSONS PER USABLE WATER TAP", 
         "% OF WATER QUALITY TESTS AT CHLORINATED COLLECTION LOCATIONS WITH FRC IN THE RANGE 0.2-2MG/L AND TURBIDITY <5NTU5", 
         "NUMBER OF PERSONS PER TOILET/LATRINE", 
         "NUMBER OF PERSONS PER BATH SHELTER/SHOWER", 
         "NUMBER OF PERSONS PER HYGIENE PROMOTER", 
         "REFUGEE POPULATION") %>%
  rename(country = "COUNTRY NAME", 
         emergency_status = "EMERGENCY / POST-EMERGENCY", 
         water_per_person_l = "AVERAGE # LITERS OF POTABLE WATER AVAILABLE PER PERSON PER DAY", 
         persons_per_tap = "NUMBER OF PERSONS PER USABLE WATER TAP", 
         quality_tests = "% OF WATER QUALITY TESTS AT CHLORINATED COLLECTION LOCATIONS WITH FRC IN THE RANGE 0.2-2MG/L AND TURBIDITY <5NTU5",
         persons_per_toilet = "NUMBER OF PERSONS PER TOILET/LATRINE", 
         persons_per_shower = "NUMBER OF PERSONS PER BATH SHELTER/SHOWER", 
         persons_per_hygienepromoter = "NUMBER OF PERSONS PER HYGIENE PROMOTER", 
         refugee_population = "REFUGEE POPULATION")

# water quality tests vs other vars
(plot_tests_toilet <- camp_usage_restricted %>%
    ggplot(aes(quality_tests, persons_per_toilet)) +
    geom_point())
(plot_tests_water <- camp_usage_restricted %>%
    ggplot(aes(quality_tests, water_per_person_l)) +
    geom_point())
(plot_tests_tap <- camp_usage_restricted %>%
    ggplot(aes(quality_tests, persons_per_tap)) +
    geom_point())
(plot_tests_shower <- camp_usage_restricted %>%
    ggplot(aes(quality_tests, persons_per_shower)) +
    geom_point())
(plot_tests_hygiene <- camp_usage_restricted %>%
    ggplot(aes(quality_tests, persons_per_hygienepromoter)) +
    geom_point())
(plot_tests_pop <- camp_usage_restricted %>%
    ggplot(aes(quality_tests, refugee_population)) +
    geom_point())

# plotting the distributions of water per person, ppl per tap etc by country would be illustrative when compared with US
# measure water resource crowdedness by country - persons per xyz with additional measure for water per person
(plot_country_tap <- camp_usage_restricted %>%
    ggplot(aes(reorder(country, log(persons_per_tap)), log(persons_per_tap))) +
    geom_jitter(position = position_jitter(w = .2), 
                alpha = .3) +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))
(plot_country_water <- camp_usage_restricted %>%
    ggplot(aes(country, water_per_person_l)) +
    geom_jitter(position = position_jitter(w = .2), 
                alpha = .3) +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))
(plot_country_pop <- camp_usage_restricted %>%
    ggplot(aes(reorder(country, refugee_population), refugee_population)) +
    geom_jitter(position = position_jitter(w = .2), 
                alpha = .3) +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))
(plot_country_toilet <- camp_usage_restricted %>%
    ggplot(aes(reorder(country, persons_per_toilet), persons_per_toilet)) +
    geom_jitter(position = position_jitter(w = .2), 
                alpha = .3) +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))
(plot_country_hygiene <- camp_usage_restricted %>%
    ggplot(aes(reorder(country, persons_per_hygienepromoter), persons_per_hygienepromoter)) +
    geom_jitter(position = position_jitter(w = .2), 
                alpha = .3) +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))