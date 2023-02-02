library(tidyverse)
library(GGally)
library(dplyr)

csv_in <- read_csv("./analysis_results.csv") %>% tibble()
colnames(csv_in) = c("Selection", "View", "Channel", "BeginTime", "EndTime", "LowFreq", "HighFreq", "SpeciesCode", "CommonName", "Confidence", "date", "season", "isWet")

# since BirdNet logs results with accuracy < 0.5, we need to discard these results
# season data is also incorrect, so extract this
df <- csv_in %>% filter(Confidence >= 0.85) %>% subset(select = -season)

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
dry_winter_biodiversity <- dry_winter_richness / (dry_winter_detections %>% count())

dry_summer_detections <- ev %>% filter(heat == 3 & isWet == F)
dry_summer_richess <- dry_summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_summer_biodiversity <- dry_summer_richess / (dry_summer_detections %>% count())

wet_winter_detections <- ev %>% filter(heat == 1 & isWet == T)
wet_winter_richness <- wet_winter_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_winter_biodiversity <- wet_winter_richness / (wet_winter_detections %>% count())




wet_summer_detections <- ev %>% filter(heat == 3 & isWet == T)
wet_summer_richness <- wet_summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_summer_biodiversity <- wet_summer_richness / (wet_summer_detections %>% count())

results <- bind_rows(
  bind_cols(dry_winter_biodiversity, F),
  bind_cols(dry_summer_biodiversity, F),
  bind_cols(wet_winter_biodiversity, T),
  bind_cols(wet_summer_biodiversity, T)
) %>% tibble()

# rejection region |Z| > 1.96

# using p0 = (x1 + x2) / (n1 + n2)
dry_p0 <- (dry_summer_biodiversity + dry_winter_biodiversity) / ((dry_summer_detections %>% count()) + (dry_winter_detections %>% count()))
dry_x1 <- dry_summer_biodiversity
dry_x2 <- dry_winter_biodiversity
dry_n1 <- dry_summer_detections %>% count()
dry_n2 <- dry_winter_detections %>% count()

# Z = (p1-p2)/sqrt(p0*(1-p0)*(1/n1+1/n2))
dry_Z <- (dry_x1 - dry_x2) / sqrt( dry_p0 * ( 1 - dry_p0 ) * ((1 / dry_n1) + (1 / dry_n2)) )
# 10.70703

wet_p0 <- (wet_summer_biodiversity + wet_winter_biodiversity) / ((wet_summer_detections %>% count()) + (wet_winter_detections %>% count()))
wet_x1 <- wet_summer_biodiversity
wet_x2 <- wet_winter_biodiversity
wet_n1 <- wet_summer_detections %>% count()
wet_n2 <- wet_winter_detections %>% count()

wet_Z <- (wet_x1 - wet_x2) / sqrt( wet_p0 * (1 - wet_p0) * ((1 / wet_n1) + (1 / wet_n2)))

# 0.1150728 !> 1.96



t.test(wet_summer_richness, dry_summer_richess, paired = TRUE, alternative = "two.sided")
