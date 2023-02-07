library(tidyverse)
library(GGally)
library(dplyr)
library(pander)

excluded_results <- c("dogdog", "siren1", "t-11031961")

csv_in <- read_csv("./report.csv") %>% tibble()
colnames(csv_in) = c("Selection", "View", "Channel", "BeginTime", "EndTime", "LowFreq", "HighFreq", "SpeciesCode", "CommonName", "Confidence", "date", "season", "isWet")

# there are some animals / objects in the recogniser that we do not want to search for, remove them as part of pre-processing
csv_in <- csv_in %>% filter(!SpeciesCode %in% excluded_results)

# since BirdNet logs results with accuracy < 0.5, we need to discard these results
# season data is also incorrect, so extract this
df <- csv_in %>% filter(Confidence >= 0.0) %>% subset(select = -season)

# add seasonal information to tibble
df <- df %>% mutate(month = 
                      format(
                        as.POSIXct(date)
                        , "%m"
                      )
)

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
dry_winter_biodiversity <- as.numeric(dry_winter_richness / (dry_winter_detections %>% count()))

dry_summer_detections <- ev %>% filter(heat == 3 & isWet == F)
dry_summer_richess <- dry_summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_summer_biodiversity <- as.numeric(dry_summer_richess / (dry_summer_detections %>% count()))

wet_winter_detections <- ev %>% filter(heat == 1 & isWet == T)
wet_winter_richness <- wet_winter_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_winter_biodiversity <- as.numeric(wet_winter_richness / (wet_winter_detections %>% count()))

wet_summer_detections <- ev %>% filter(heat == 3 & isWet == T)
wet_summer_richness <- wet_summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_summer_biodiversity <- as.numeric(wet_summer_richness / (wet_summer_detections %>% count()))

# just seasons biodiversity (both wet + dry)
summer_detections <- ev %>%filter(heat == 3)
summer_richness <- summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
summer_biodiversity <- summer_richness / (summer_richness %>% count()) 

winter_detections <- ev %>% filter(heat==1)
winter_richness <- winter_detections %>% select(SpeciesCode) %>% unique() %>% count()
winter_biodiversity <- winter_richness / (winter_richness %>% count())

results <- bind_rows(
  bind_cols(dry_winter_biodiversity, F),
  bind_cols(dry_summer_biodiversity, F),
  bind_cols(wet_winter_biodiversity, T),
  bind_cols(wet_summer_biodiversity, T)
) %>% tibble()

# make a big table for all results
results <- c(dry_summer_biodiversity * 100, wet_summer_biodiversity, dry_winter_biodiversity * 100, wet_winter_biodiversity * 100)
isWet <- c("dry", "wet", "dry", "wet")
season <- c("summer", "summer", "winter", "winter")

allResults <- tibble(results, isWet, season)

aov(results ~ isWet + season, data = allResults) %>% pander()

lm.2lines <- lm(results ~ isWet:season, data = allResults)

# isolating each point and calculating the biodiversity
season <- c("summer", "winter")
dry <- c(dry_summer_biodiversity * 100, dry_winter_biodiversity * 100)
dry_df <- tibble(dry, season)

wet <- c(wet_summer_biodiversity * 100, wet_winter_biodiversity * 100)
wet_df <- tibble(wet, season)

dry_lm <- lm(dry ~ season, data = dry_df)
wet_lm <- lm(wet ~ season, data = wet_df)

anova(dry_lm)

result_final <- tibble(wet, dry)

chisq.test(result_final, correct = TRUE)
