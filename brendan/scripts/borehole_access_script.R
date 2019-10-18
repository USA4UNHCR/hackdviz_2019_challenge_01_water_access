# borehole data script

### provides starting point for analysis for first-time users of dataset

### reduces borehole dataset to variables with a lot of observations
### produces a series of plots
### will work with new versions of this dataset in csv form as long as they use
### the same variable labeling

library(tidyverse)

borehole_access <- read_csv("data/BoreholeData_LastAccess_Sep2019.csv")

borehole_access_restricted <- borehole_access %>%
  select("Country", 
         "Status",
         "Elevation in meters above sea level", 
         "Depth in m", 
         "Static water level in meters below ground level", 
         "Casing diameter in inch", 
         "Driller's yield in m3/hr", 
         "Daily pumping time in h") %>%
  rename(country = "Country", 
         status = "Status", 
         elevation_m = "Elevation in meters above sea level", 
         depth_m = "Depth in m", 
         static_water_level_m = "Static water level in meters below ground level", 
         casing_diameter_inch = "Casing diameter in inch", 
         drill_yield_m3h = "Driller's yield in m3/hr", 
         daily_pumping_h = "Daily pumping time in h")

# explore dataset
### by country
glimpse(borehole_access_restricted)
(plot_country_pumping <- borehole_access_restricted %>%
    ggplot(aes(country, daily_pumping_h)) +
    geom_point() +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))
(plot_country_elev <- borehole_access_restricted %>%
    ggplot(aes(country, elevation_m)) +
    geom_point() +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))
(plot_country_depth <- borehole_access_restricted %>%
    ggplot(aes(country, depth_m)) +
    geom_point() +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))
(plot_country_staticlevel <- borehole_access_restricted %>%
    ggplot(aes(country, static_water_level_m)) +
    geom_point() +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))
(plot_country_casingdiam <- borehole_access_restricted %>%
    ggplot(aes(country, casing_diameter_inch)) +
    geom_point() +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))
(plot_country_depth <- borehole_access_restricted %>%
    ggplot(aes(country, depth_m)) +
    geom_point() +
    theme(axis.text.x = element_text(angle = 75, hjust = 1)))

### explore relationships between borehole variables - depth through daily pumping
(plot_depth_drillyield <- borehole_access_restricted %>%
    ggplot(aes(depth_m, drill_yield_m3h)) +
    geom_point())
(plot_depth_staticwater <- borehole_access_restricted %>%
    ggplot(aes(depth_m, static_water_level_m)) +
    geom_point())
(plot_depth_casing <- borehole_access_restricted %>%
    ggplot(aes(depth_m, casing_diameter_inch)) +
    geom_point())
(plot_depth_pumping <- borehole_access_restricted %>%
    ggplot(aes(depth_m, daily_pumping_h)) +
    geom_point())
(plot_depth_casing <- borehole_access_restricted %>%
    ggplot(aes(depth_m, casing_diameter_inch)) +
    geom_point())
(plot_drill_pump <- borehole_access_restricted %>%
    ggplot(aes(drill_yield_m3h, daily_pumping_h)) +
    geom_point())
(plot_static_drill <- borehole_access_restricted %>%
    ggplot(aes(static_water_level_m, drill_yield_m3h)) +
    geom_point())