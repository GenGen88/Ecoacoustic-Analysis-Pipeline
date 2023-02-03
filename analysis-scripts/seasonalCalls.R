library(tidyverse)
library(GGally)
library(dplyr)

csv_in <- read_csv("./analysis_results.csv") %>% tibble()

# since BirdNet logs results with accuracy < 0.8, we need to discard these results
# season data is also incorrect, so extract this
df <- csv_in %>% filter(Confidence > 0.8) %>% subset(select = -season)

# add seasonal information to tibble
df <- df %>% mutate(month = 
                      format(
                        as.POSIXct(date)
                        , "%m"
                      )
)

# environment variables
# heat = 1 is winter
# heat = 2 is spring or autumn
# heat = 3 is summer

ev <- df %>% mutate(season =
                      case_when(
                        month == "12" | month == "01" | month == "02" ~ "summer",
                        month == "06" | month == "07" | month == "08" ~ "winter",
                        month == "03" | month == "04" | month == "05" ~ "autumn",
                        month == "09" | month == "10" | month == "11" ~ "spring"
                      )
)

# calculate the biodiversity of seasons for each sensor
dry_winter_detections <- ev %>% filter(season == "winter" & isWet == F)
dry_winter_richness <- dry_winter_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_winter_biodiversity <- dry_winter_richness / (dry_winter_detections %>% count())

dry_summer_detections <- ev %>% filter(season == "summer" & isWet == F)
dry_summer_richess <- dry_summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_summer_biodiversity <- dry_summer_richess / (dry_summer_detections %>% count())

dry_autumn_detections <- ev %>% filter(season == "autumn" & isWet == F)
dry_autumn_richess <- dry_autumn_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_autumn_biodiversity <- dry_autumn_richess / (dry_autumn_detections %>% count())

dry_spring_detections <- ev %>% filter(season == "spring" & isWet == F)
dry_spring_richess <- dry_spring_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_spring_biodiversity <- dry_spring_richess / (dry_spring_detections %>% count())

# wet sensor
wet_winter_detections <- ev %>% filter(season == "winter" & isWet == T)
wet_winter_richness <- wet_winter_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_winter_biodiversity <- wet_winter_richness / (wet_winter_detections %>% count())

wet_summer_detections <- ev %>% filter(season == "summer" & isWet == T)
wet_summer_richness <- wet_summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_summer_biodiversity <- wet_summer_richness / (wet_summer_detections %>% count())

wet_autumn_detections <- ev %>% filter(season == "autumn" & isWet == T)
wet_autumn_richess <- wet_autumn_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_autumn_biodiversity <- wet_autumn_richess / (wet_autumn_detections %>% count())

wet_spring_detections <- ev %>% filter(season == "spring" & isWet == T)
wet_spring_richess <- wet_spring_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_spring_biodiversity <- wet_spring_richess / (wet_spring_detections %>% count())

results <- bind_rows(
  bind_cols(dry_winter_biodiversity, "winter", F),
  bind_cols(dry_summer_biodiversity, "summer", F),
  bind_cols(dry_autumn_biodiversity, "autumn", F),
  bind_cols(dry_spring_biodiversity, "spring", F),
  bind_cols(wet_winter_biodiversity, "winter", T),
  bind_cols(wet_summer_biodiversity, "summer", T),
  bind_cols(wet_autumn_biodiversity, "autumn", T),
  bind_cols(wet_spring_biodiversity, "spring", T)
) %>% tibble()
