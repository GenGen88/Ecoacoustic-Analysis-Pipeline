library(tidyverse)
library(GGally)
library(dplyr)

csv_in <- read_csv("./report.csv") %>% tibble()
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

# environment variables
ev <- df %>% mutate(heat =
                      case_when(
                        month == "12" | month == "01" | month == "02" ~ 1, # summer
                        month == "03" | month == "04" | month == "05" ~ 2, # autumn
                        month == "06" | month == "07" | month == "08" ~ 3, # winter
                        month == "09" | month == "10" | month == "11" ~ 4 # spring
                      )
)

# calculate the biodiversity of wet vs dry
dry_summer_detections <- ev %>% filter(heat == 1 & isWet == F)
dry_summer_richess <- dry_summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_summer_biodiversity <- dry_summer_richess / (dry_summer_detections %>% count())

dry_autumn_detections <- ev %>% filter(heat == 2 & isWet == F)
dry_autumn_richness <- dry_autumn_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_autumn_biodiversity <- dry_autumn_richness / (dry_autumn_detections %>% count())

dry_winter_detections <- ev %>% filter(heat == 3 & isWet == F)
dry_winter_richness <- dry_winter_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_winter_biodiversity <- dry_winter_richness / (dry_winter_detections %>% count())

dry_spring_detections <- ev %>% filter(heat == 4 & isWet == F)
dry_spring_richness <- dry_spring_detections %>% select(SpeciesCode) %>% unique() %>% count()
dry_spring_biodiversity <- dry_spring_richness / (dry_spring_detections %>% count())

# wet locations
wet_summer_detections <- ev %>% filter(heat == 1 & isWet == T)
wet_summer_richness <- wet_summer_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_summer_biodiversity <- wet_summer_richness / (wet_summer_detections %>% count())

wet_autumn_detections <- ev %>% filter(heat == 2 & isWet == T)
wet_autumn_richness <- wet_autumn_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_autumn_biodiversity <- wet_autumn_richness / (wet_autumn_detections %>% count())

wet_winter_detections <- ev %>% filter(heat == 3 & isWet == T)
wet_winter_richness <- wet_winter_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_winter_biodiversity <- wet_winter_richness / (wet_winter_detections %>% count())

wet_spring_detections <- ev %>% filter(heat == 4 & isWet == T)
wet_spring_richness <- wet_spring_detections %>% select(SpeciesCode) %>% unique() %>% count()
wet_spring_biodiversity <- wet_spring_richness / (wet_spring_detections %>% count())

# results holds the biodiversity of every season
dataDry <- bind_rows(
  bind_cols("Summer", dry_summer_biodiversity, F),
  bind_cols("Autumn", dry_autumn_biodiversity, F),
  bind_cols("Winter", dry_winter_biodiversity, F),
  bind_cols("Spring", dry_spring_biodiversity, F)
) %>% tibble()
colnames(dataDry)[1] <- "Season";
colnames(dataDry)[2] <- "Biodiversity";
colnames(dataDry)[3] <- "IsWet";

dataWet <- bind_rows(
  bind_cols("Summer", wet_summer_biodiversity, T),
  bind_cols("Autumn", wet_autumn_biodiversity, T),
  bind_cols("Winter", wet_winter_biodiversity, T),
  bind_cols("Spring", wet_spring_biodiversity, T)
) %>% tibble()
colnames(dataWet)[1] <- "Season";
colnames(dataWet)[2] <- "Biodiversity";
colnames(dataWet)[3] <- "IsWet";

data <- full_join(dataDry, dataWet)

data %>% ggplot(aes(x = Season, y = Biodiversity, color = IsWet)) +
  geom_point(size = 4) +
  ggtitle("Ecoacoustic Biodiversity Over Seasons")+
  guides(color=guide_legend(title="Location"))+
  scale_color_hue(labels = c("Dry", "Wet"))

dataWet %>% ggplot(aes(x = Season, y = Biodiversity)) +
  geom_point(size = 4) +
  ggtitle("Ecoacoustic Biodiversity of Wet Sensor Over Seasons")
  
dataDry %>% ggplot(aes(x = Season, y = Biodiversity)) +
  geom_point(size = 4) +
  ggtitle("Ecoacoustic Biodiversity of Dry Sensor Over Seasons")
