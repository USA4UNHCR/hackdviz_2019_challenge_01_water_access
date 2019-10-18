# usa usage script

### provides starting point for analysis for first-time users of dataset

### removes FIPS noise from usa usage dataset
### produces a series of plots
### will work with new versions of this dataset in csv form as long as they use
### the same variable labeling

library(tidyverse)

us_usage <- read_csv("data/domesticwaterusage_bycounty_us.csv")

us_usage_restricted <- us_usage %>%
  select(-c(STATEFIPS, COUNTYFIPS, FIPS)) %>%
  rename(state = STATE, 
         county = COUNTY, 
         year = YEAR, 
         countypop = "TP-TotPop", 
         ss_pop = "DO-SSPop", 
         ss_ground_withdrawals = "DO-WGWFr",
         ss_surface_withdrawals = "DO-WSWFr",
         total_ss_withdrawals = "DO-WFrTo",
         ss_percap_use = "DO-SSPCp",
         del_from_publicsupply = "DO-PSDel",
         pubsupplied_percap_use = "DO-PSPCp",
         totaluse_with_del = "DO-WDelv")

(plot_state_totalsswithdrawals <- us_usage_restricted %>%
    ggplot(aes(reorder(state, total_ss_withdrawals), total_ss_withdrawals)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))

(plot_state_ssgroundwithdrawals <- us_usage_restricted %>%
    ggplot(aes(reorder(state, ss_ground_withdrawals), ss_ground_withdrawals)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))

(plot_state_sssurfacewithdrawals <- us_usage_restricted %>%
    ggplot(aes(reorder(state, ss_surface_withdrawals), ss_surface_withdrawals)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))

(plot_state_delpubsupp <- us_usage_restricted %>%
    ggplot(aes(reorder(state, del_from_publicsupply), del_from_publicsupply)) +
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))