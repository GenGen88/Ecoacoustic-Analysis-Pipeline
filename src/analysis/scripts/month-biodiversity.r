# install dependencies
library(tidyverse)
library(GGally)
library(dplyr)

csv_in <- read_csv("./analysis_results.csv")

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
DjanObservations <- ev %>% filter(month == "01" & isWet == F)
DjanBiodiversity <- (DjanObservations %>% unique() %>% count()) / (DjanObservations %>% count())

DfebObservations <- ev %>% filter(month == "02" & isWet == F)
DfebBiodiversity <- (DfebObservations %>% unique() %>% count()) / (DfebObservations %>% count())

DmarObservations <- ev %>% filter(month == "03" & isWet == F)
DmarBiodiversity <- (DmarObservations %>% unique() %>% count()) / (DmarObservations %>% count())

DaprObservations <- ev %>% filter(month == "04" & isWet == F)
DaprBiodiversity <- (DaprObservations %>% unique() %>% count()) / (DaprObservations %>% count())

DmayObservations <- ev %>% filter(month == "05" & isWet == F)
DmayBiodiversity <- (DmayObservations %>% unique() %>% count()) / (DmayObservations %>% count())

DjunObservations <- ev %>% filter(month == "06" & isWet == F)
DjunBiodiversity <- (DjunObservations %>% unique() %>% count()) / (DjunObservations %>% count())

DjulObservations <- ev %>% filter(month == "07" & isWet == F)
DjulBiodiversity <- (DjulObservations %>% unique() %>% count()) / (DjulObservations %>% count())

DaugObservations <- ev %>% filter(month == "08" & isWet == F)
DaugBiodiversity <- (DaugObservations %>% unique() %>% count()) / (DaugObservations %>% count())

DsepObservations <- ev %>% filter(month == "09" & isWet == F)
DsepBiodiversity <- (DsepObservations %>% unique() %>% count()) / (DsepObservations %>% count())

DoctObservations <- ev %>% filter(month == "10" & isWet == F)
DoctBiodiversity <- (DoctObservations %>% unique() %>% count()) / (DoctObservations %>% count())

DnovObservations <- ev %>% filter(month == "11" & isWet == F)
DnovBiodiversity <- (DnovObservations %>% unique() %>% count()) / (DnovObservations %>% count())

DdecObservations <- ev %>% filter(month == "12" & isWet == F)
DdevBiodiversity <- (DdecObservations %>% unique() %>% count()) / (DdecObservations %>% count())

# wet sensors
WjanObservations <- ev %>% filter(month == "01" & isWet == T)
WjanBiodiversity <- (WjanObservations %>% unique() %>% count()) / (WjanObservations %>% count())

WfebObservations <- ev %>% filter(month == "02" & isWet == T)
WfebBiodiversity <- (WfebObservations %>% unique() %>% count()) / (WfebObservations %>% count())

WmarObservations <- ev %>% filter(month == "03" & isWet == T)
WmarBiodiversity <- (WmarObservations %>% unique() %>% count()) / (WmarObservations %>% count())

WaprObservations <- ev %>% filter(month == "04" & isWet == T)
WaprBiodiversity <- (WaprObservations %>% unique() %>% count()) / (WaprObservations %>% count())

WmayObservations <- ev %>% filter(month == "05" & isWet == T)
WmayBiodiversity <- (WmayObservations %>% unique() %>% count()) / (WmayObservations %>% count())

WjunObservations <- ev %>% filter(month == "06" & isWet == T)
WjunBiodiversity <- (WjunObservations %>% unique() %>% count()) / (WjunObservations %>% count())

WjulObservations <- ev %>% filter(month == "07" & isWet == T)
WjulBiodiversity <- (WjulObservations %>% unique() %>% count()) / (WjulObservations %>% count())

WaugObservations <- ev %>% filter(month == "08" & isWet == T)
WaugBiodiversity <- (WaugObservations %>% unique() %>% count()) / (WaugObservations %>% count())

WsepObservations <- ev %>% filter(month == "09" & isWet == T)
WsepBiodiversity <- (WsepObservations %>% unique() %>% count()) / (WsepObservations %>% count())

WoctObservations <- ev %>% filter(month == "10" & isWet == T)
WoctBiodiversity <- (WoctObservations %>% unique() %>% count()) / (WoctObservations %>% count())

WnovObservations <- ev %>% filter(month == "11" & isWet == T)
WnovBiodiversity <- (WnovObservations %>% unique() %>% count()) / (WnovObservations %>% count())

WdecObservations <- ev %>% filter(month == "12" & isWet == T)
WdevBiodiversity <- (WdecObservations %>% unique() %>% count()) / (WdecObservations %>% count())

resultsData <- bind_rows(
  bind_cols(1, DjanBiodiversity, F),
  bind_cols(2, DfebBiodiversity, F),
  bind_cols(3, DmarBiodiversity, F),
  bind_cols(4, DaprBiodiversity, F),
  bind_cols(5, DmayBiodiversity, F),
  bind_cols("Jun", DjunBiodiversity, F),
  bind_cols("Jul", DjulBiodiversity, F),
  bind_cols("Aug", DaugBiodiversity, F),
  bind_cols("Sep", DsepBiodiversity, F),
  bind_cols("Oct", DoctBiodiversity, F),
  bind_cols("Nov", DnovBiodiversity, F),
  bind_cols("Dec", DdevBiodiversity, F),
  bind_cols("Jan", WjanBiodiversity, T),
  bind_cols("Feb", WfebBiodiversity, T),
  bind_cols("Mar", WmarBiodiversity, T),
  bind_cols("Apr", WaprBiodiversity, T),
  bind_cols("May", WmayBiodiversity, T),
  bind_cols("Jun", WjunBiodiversity, T),
  bind_cols("Jul", WjulBiodiversity, T),
  bind_cols("Aug", WaugBiodiversity, T),
  bind_cols("Sep", WsepBiodiversity, T),
  bind_cols("Oct", WoctBiodiversity, T),
  bind_cols("Nov", WnovBiodiversity, T),
  bind_cols("Dec", WdevBiodiversity, T),
) %>% tibble()

colnames(resultsData)[1] <- "Month"
colnames(resultsData)[2] <- "Biodiversity"
colnames(resultsData)[3] <- "IsWet"

resultsData %>% ggplot(aes(x = Month, y = Biodiversity, color = IsWet)) + geom_point()
