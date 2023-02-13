# install dependencies
library(tidyverse)
library(GGally)
library(dplyr)

#csv_in <- read_csv("./analysis_results.csv")

# current csv
csv_in <- read_csv("./report.csv") %>% tibble()

colnames(csv_in) = c("Selection", "View", "Channel", "BeginTime", "EndTime", "LowFreq", "HighFreq", "SpeciesCode", "CommonName", "Confidence", "date", "season", "isWet")

# since BirdNet logs results with accuracy < 0.5, we need to discard these results
# season data is also incorrect, so extract this
evf <- csv_in %>% filter(Confidence >= 0.85) %>% subset(select = -season)

# add seasonal information to tibble
evf <- evf %>% mutate(month = 
  format(as.POSIXct(date), "%m")
)

ev <- evf %>% select("SpeciesCode", "isWet", "month")

# dry sensors
# Observations = Richness
DjanObservations <- ev %>% filter(month == "01" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DjanObservations) = c("SpeciesCode", "Richness")
DjanPrecursor <- DjanObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DjanBiodiversity <- 1-(sum(DjanPrecursor$Numerator)/(sum(DjanPrecursor$Richness)*(sum(DjanPrecursor$Richness)-1)))

DfebObservations <- ev %>% filter(month == "02" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DfebObservations) = c("SpeciesCode", "Richness")
DfebPrecuursor <- DfebObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DfebBiodiversity <- 1-(sum(DfebPrecuursor$Numerator)/(sum(DfebPrecuursor$Richness)*(sum(DfebPrecuursor$Richness)-1)))

DmarObservations <- ev %>% filter(month == "03" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DmarObservations) = c("SpeciesCode", "Richness")
DmarPrecursor <- DmarObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DmarBiodiversity <- 1-(sum(DmarPrecursor$Numerator)/(sum(DmarPrecursor$Richness)*(sum(DmarPrecursor$Richness)-1)))

DaprObservations <- ev %>% filter(month == "04" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DaprObservations) = c("SpeciesCode", "Richness")
DaprPrecursor <- DaprObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DaprBiodiversity <- 1-(sum(DaprPrecursor$Numerator)/(sum(DaprPrecursor$Richness)*(sum(DaprPrecursor$Richness)-1)))

DmayObservations <- ev %>% filter(month == "05" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DmayObservations) = c("SpeciesCode", "Richness")
DmayPrecursor <- DmayObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DmayBiodiversity <- 1-(sum(DmayPrecursor$Numerator)/(sum(DmayPrecursor$Richness)*(sum(DmayPrecursor$Richness)-1)))

DjunObservations <- ev %>% filter(month == "06" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DjunObservations) = c("SpeciesCode", "Richness")
DjunPrecursor <- DjunObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DjunBiodiversity <- 1-(sum(DjunPrecursor$Numerator)/(sum(DjunPrecursor$Richness)*(sum(DjunPrecursor$Richness)-1)))

DjulObservations <- ev %>% filter(month == "07" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DjulObservations) = c("SpeciesCode", "Richness")
DjulPrecursor <- DjulObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DjulBiodiversity <- 1-(sum(DjulPrecursor$Numerator)/(sum(DjulPrecursor$Richness)*(sum(DjulPrecursor$Richness)-1)))

DaugObservations <- ev %>% filter(month == "08" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DaugObservations) = c("SpeciesCode", "Richness")
Daugprecursor <- DaugObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DaugBiodiversity <- 1-(sum(Daugprecursor$Numerator)/(sum(Daugprecursor$Richness)*(sum(Daugprecursor$Richness)-1)))

DsepObservations <- ev %>% filter(month == "09" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DsepObservations) = c("SpeciesCode", "Richness")
DsepPrecursor <- DsepObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DsepBiodiversity <- 1-(sum(DsepPrecursor$Numerator)/(sum(DsepPrecursor$Richness)*(sum(DsepPrecursor$Richness)-1)))

DoctObservations <- ev %>% filter(month == "10" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DoctObservations) = c("SpeciesCode", "Richness")
DoctPrecursor <- DoctObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DoctBiodiversity <- 1-(sum(DoctPrecursor$Numerator)/(sum(DoctPrecursor$Richness)*(sum(DoctPrecursor$Richness)-1)))

DnovObservations <- ev %>% filter(month == "11" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DnovObservations) = c("SpeciesCode", "Richness")
DnovPrecursor <- DnovObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DnovBiodiversity <- 1-(sum(DnovPrecursor$Numerator)/(sum(DnovPrecursor$Richness)*(sum(DnovPrecursor$Richness)-1)))

DdecObservations <- ev %>% filter(month == "12" & isWet == F) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(DdecObservations) = c("SpeciesCode", "Richness")
DdecPrecursor <- DdecObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
DdevBiodiversity <- 1-(sum(DdecPrecursor$Numerator)/(sum(DdecPrecursor$Richness)*(sum(DdecPrecursor$Richness)-1)))

# wet sensors
WjanObservations <- ev %>% filter(month == "01" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WjanObservations) = c("SpeciesCode", "Richness")
WjanPrecursor <- WjanObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WjanBiodiversity <- 1-(sum(WjanPrecursor$Numerator)/(sum(WjanPrecursor$Richness)*(sum(WjanPrecursor$Richness)-1)))

WfebObservations <- ev %>% filter(month == "02" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WfebObservations) = c("SpeciesCode", "Richness")
WfebPrecursor <- WfebObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WfebBiodiversity <- 1-(sum(WfebPrecursor$Numerator)/(sum(WfebPrecursor$Richness)*(sum(WfebPrecursor$Richness)-1)))

WmarObservations <- ev %>% filter(month == "03" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WmarObservations) = c("SpeciesCode", "Richness")
WmarPrecursor <- WmarObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WmarBiodiversity <- 1-(sum(WmarPrecursor$Numerator)/(sum(WmarPrecursor$Richness)*(sum(WmarPrecursor$Richness)-1)))

WaprObservations <- ev %>% filter(month == "04" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WaprObservations) = c("SpeciesCode", "Richness")
WaprPrecursor <- WaprObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WaprBiodiversity <- 1-(sum(WaprPrecursor$Numerator)/(sum(WaprPrecursor$Richness)*(sum(WaprPrecursor$Richness)-1)))

WmayObservations <- ev %>% filter(month == "05" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WmayObservations) = c("SpeciesCode", "Richness")
WmayPrecursor <- WmayObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WmayBiodiversity <- 1-(sum(WmayPrecursor$Numerator)/(sum(WmayPrecursor$Richness)*(sum(WmayPrecursor$Richness)-1)))

WjunObservations <- ev %>% filter(month == "06" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WjunObservations) = c("SpeciesCode", "Richness")
WjunPrecursor <- WjunObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WjunBiodiversity <- 1-(sum(WjunPrecursor$Numerator)/(sum(WjunPrecursor$Richness)*(sum(WjunPrecursor$Richness)-1)))

WjulObservations <- ev %>% filter(month == "07" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WjulObservations) = c("SpeciesCode", "Richness")
WjulPrecursor <- WjulObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WjulBiodiversity <- 1-(sum(WjulPrecursor$Numerator)/(sum(WjulPrecursor$Richness)*(sum(WjulPrecursor$Richness)-1)))

WaugObservations <- ev %>% filter(month == "08" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WaugObservations) = c("SpeciesCode", "Richness")
WaugPrecursor <- WaugObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WaugBiodiversity <- 1-(sum(WaugPrecursor$Numerator)/(sum(WaugPrecursor$Richness)*(sum(WaugPrecursor$Richness)-1)))

WsepObservations <- ev %>% filter(month == "09" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WsepObservations) = c("SpeciesCode", "Richness")
WsepPrecursor <- WsepObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WsepBiodiversity <- 1-(sum(WsepPrecursor$Numerator)/(sum(WsepPrecursor$Richness)*(sum(WsepPrecursor$Richness)-1)))

WoctObservations <- ev %>% filter(month == "10" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WoctObservations) = c("SpeciesCode", "Richness")
WoctPrecursor <- WoctObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WoctBiodiversity <- 1-(sum(WoctPrecursor$Numerator)/(sum(WoctPrecursor$Richness)*(sum(WoctPrecursor$Richness)-1)))

WnovObservations <- ev %>% filter(month == "11" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WnovObservations) = c("SpeciesCode", "Richness")
WnovPrecursor <- WnovObservations %>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WnovBiodiversity <- 1-(sum(WnovPrecursor$Numerator)/(sum(WnovPrecursor$Richness)*(sum(WnovPrecursor$Richness)-1)))

WdecObservations <- ev %>% filter(month == "12" & isWet == T) %>% group_by(SpeciesCode) %>% count(SpeciesCode)
colnames(WdecObservations) = c("SpeciesCode", "Richness")
WdecPrecursor <- WdecObservations%>% select(SpeciesCode, Richness) %>% mutate(Numerator = (Richness * (Richness - 1)))
WdevBiodiversity <- 1-(sum(WdecPrecursor$Numerator)/(sum(WdecPrecursor$Richness)*(sum(WdecPrecursor$Richness)-1)))

resultsData <- bind_rows(
  bind_cols(1, DjanBiodiversity, F),
  bind_cols(2, DfebBiodiversity, F),
  bind_cols(3, DmarBiodiversity, F),
  bind_cols(4, DaprBiodiversity, F),
  bind_cols(5, DmayBiodiversity, F),
  bind_cols(6, DjunBiodiversity, F),
  bind_cols(7, DjulBiodiversity, F),
  bind_cols(8, DaugBiodiversity, F),
  bind_cols(9, DsepBiodiversity, F),
  bind_cols(10, DoctBiodiversity, F),
  bind_cols(11, DnovBiodiversity, F),
  bind_cols(12, DdevBiodiversity, F),
  bind_cols(1, WjanBiodiversity, T),
  bind_cols(2, WfebBiodiversity, T),
  bind_cols(3, WmarBiodiversity, T),
  bind_cols(4, WaprBiodiversity, T),
  bind_cols(5, WmayBiodiversity, T),
  bind_cols(6, WjunBiodiversity, T),
  bind_cols(7, WjulBiodiversity, T),
  bind_cols(8, WaugBiodiversity, T),
  bind_cols(9, WsepBiodiversity, T),
  bind_cols(10, WoctBiodiversity, T),
  bind_cols(11, WnovBiodiversity, T),
  bind_cols(12, WdevBiodiversity, T),
) %>% tibble()

colnames(resultsData)[1] <- "Month"
colnames(resultsData)[2] <- "Biodiversity"
colnames(resultsData)[3] <- "IsWet"

resultsData %>% ggplot(aes(x = Month, y = Biodiversity, color = IsWet)) + 
  geom_point()+
  scale_x_continuous(breaks = seq(1,12, by =1)) + 
  ggtitle("Ecoacoustic Biodiversity Over Months")+
  ylim(0,1)+
  guides(color=guide_legend(title="Location"))+
  scale_color_hue(labels = c("Dry", "Wet"))

## GLM stuff
glm(Month~Biodiversity, data = resultsData, family = "gaussian")

WetResults <- resultsData %>% filter(IsWet == T)
DryResults <- resultsData %>% filter(IsWet == F)

wetGlm <- glm(Month~Biodiversity, data = WetResults, family = "gaussian")
dryGlm <- glm(Month~Biodiversity, data = DryResults, family = "gaussian")

summary(wetGlm)
summary(dryGlm)
