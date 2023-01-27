library(tidyverse)
library(GGally)
library(dplyr)

csv_in <- read_csv("./analysis_results.csv") %>% tibble()
colnames(csv_in) = c("Selection", "View", "Channel", "BeginTime", "EndTime", "LowFreq", "HighFreq", "SpeciesCode", "CommonName", "Confidence", "date", "season", "isWet")

# since BirdNet logs results with accuracy < 0.5, we need to discard these results
# season data is also incorrect, so extract this
df <- csv_in %>% filter(Confidence >= 0.8) %>% subset(select = -season)

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

ev <- df %>% mutate(heat =
  case_when(
    month == "12" | month == "01" | month == "02" ~ 3,
  month == "06" | month == "07" | month == "08" ~ 1,
    month == "03" | month == "04" | month == "05" ~ 2,
    month == "09" | month == "10" | month == "11" ~ 2
  )
)

# calculate the biodiversity of wet vs dry
dry_winter_detections <- ev %>% filter(heat == 1 & isWet == F)
dry_winter_richness <- dry_winter_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_winter_biodiversity <- dry_winter_richness / (dry_winter_detections %>% count())

dry_summer_detections <- ev %>% filter(heat == 3 & isWet == F)
dry_summer_richess <- dry_summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_summer_biodiversity <- dry_summer_richess / (dry_summer_detections %>% count())

wet_winter_detections <- ev %>% filter(heat == 1 & isWet == T)
wet_winter_richness <- wet_winter_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_winter_biodiversity <- wet_winter_richness / (wet_winter_detections %>% count())


# genna stuff
wet_winter_
wet_winter_richness2 <- wet_summer_detections select
wet_winter_biodiversity_recalc <- wet_winter_detections %>%
  select(CommonName) %>%
  mutate(n_over_N_squared = ((CommonName / sum(CommonName)^2)),
         Biodiverity = (1-sum(n_over_N_squared)))


wet_summer_detections <- ev %>% filter(heat == 3 & isWet == T)
wet_summer_richness <- wet_summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_summer_biodiversity <- wet_summer_richness / (wet_summer_detections %>% count())

results <- bind_rows(
  bind_cols(dry_winter_biodiversity, F),
  bind_cols(dry_summer_biodiversity, F),
  bind_cols(wet_winter_biodiversity, T),
  bind_cols(wet_summer_biodiversity, T)
) %>% tibble()

# rejection region Z >
dry_p0 <- (dry_summer_biodiversity + dry_winter_biodiversity) / ((dry_summer_detections %>% count()) + (dry_winter_detections %>% count()))
dry_population_Z <- (dry_summer_biodiversity / dry_winter_biodiversity) / (sqrt(dry_p0 * (1 - dry_p0) * (dry_winter_detections %>% count() + dry_summer_detections %>% count())))

# 4.32976 > 1.96

wet_p0 <- (wet_summer_biodiversity + wet_winter_biodiversity) / ((wet_summer_detections %>% count()) + (wet_winter_detections %>% count()))
wet_population_Z <-(wet_summer_biodiversity / wet_winter_biodiversity) / (sqrt(wet_p0) * (1 - wet_p0) * (wet_winter_detections %>% count() + wet_summer_detections %>% count()))

# 0.1150728 !> 0.1150728



t.test(wet_summer_richness, dry_summer_richess, paired = TRUE, alternative = "two.sided")
