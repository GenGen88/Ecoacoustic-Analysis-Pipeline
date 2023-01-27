library(tidyverse)
library(dplyr)

# import data from VRES example
<<<<<<< HEAD
data1 <- read.csv("C:\\Users\\gldia\\OneDrive\\Documents\\VRES-Analyser\\example\\report.csv", header=TRUE, stringsAsFactors = FALSE)
# import data from ubuntu thing
data1 <- read.csv("C:\\Users\\gldia\\Documents\\report.csv",header=TRUE, stringsAsFactors = FALSE)
# import data from Downloads (Hundon's big csv)
data1 <- read.csv("C:\\Users\\gldia\\Downloads\\analysis_results.csv")
colnames(data1) = c("Selection", "View", "Channel", "BeginTime", "EndTime", "LowFreq", "HighFreq", "Speciescode", "CommonName", "Confidence", "date", "season", "Location")

deleteDuplicates <- data1[!duplicated(data1),]
=======
data1 <- read.csv("./analysis_results.csv", header=TRUE, stringsAsFactors = FALSE)
>>>>>>> 8887a6e9f4bfaea989e01a5cb680d733b05481d8
# filter data to only include data with confidence greater than 0.5
filteredData <- filter(data1, data1$Confidence >0.5)

# table of just species and time
speciesTimeData <-data.frame(filteredData$CommonName, filteredData$date)
colnames(speciesTimeData) = c("CommonName", "Date")

# generates just the species name data
speciesData <-data.frame(filteredData$CommonName)
colnames(speciesData) = c("CommonName")

#generates a table of how many times a species appeared
richness <- speciesData %>% count(filteredData$CommonName)
colnames(richness) = c("CommonName", "Frequency")

#generates a table of species richness over date
richnessDate <- speciesTimeData %>% group_by(filteredData$date)%>% count(filteredData$date)
colnames(richnessDate) = c("Date", "Richness")

# graph richness over time (point form)
ggplot(data=richnessDate, aes(x= Date, y = Richness))+
  geom_point()+
  theme_bw()+
  ggtitle("Species Richness Over Time")
  
# graph richness over time (line??) for top 5?
ggplot(data=richnessDate, aes(x= Date, y = Richness))+
  geom_point()+
  geom_smooth()+
  theme_bw()+
  ggtitle("Species Richness Over Time")

# calculates biodiversity of whole dataset
Diversity <- richness %>%
  select(CommonName, Frequency) %>%
  mutate(n_over_N_squared = ((Frequency / sum(Frequency)^2)),
         Biodiverity = (1-sum(n_over_N_squared)))

# table of just season + commonName
seasons <- data.frame(filteredData$CommonName, filteredData$season)
colnames(seasons) = c("CommonName", "Season")

# table of richness over season
richnessSeason <- seasons %>% group_by(Season) %>% count(Season)
colnames(richnessSeason) = c("Season", "Richness")

# bar graph richness over season
ggplot(data = richnessSeason, aes(x = Season))+
  geom_bar()+
  theme_bw()+
  ggtitle("Species Richness per Season")+
  xlab("Season")+
  ylab("Species Richness")
  
# table commonName and wet v dry (should work with future data)
Location <- data.frame(filteredData$CommonName, filteredData$Location)
colnames(Location) = c("CommonName", "Location")
                            
# table richness + wet/dry
LocationRichness <- Location %>% group_by(Location) %>% count(Location)
colnames(LocationRichness) = c("Location", "Richness")

# isolate wet richness
wetRichness <- filter(LocationRichness, Location == "True")

# calculate biodiversity of wet
wetDiversity <- wetRichness %>%
  select(Location, Richness) %>%
  mutate(n_over_N_squared = ((Richness / sum(Richness)^2)),
         Biodiverity = (1-sum(n_over_N_squared)))
# isolate just biodiversity
wetBiodiveristy <- wetDiversity %>% group_by(Biodiversity)

# isolate dry richness
dryRichness <- filter(LocationRichness, Location == "False")
# calculate biodiversity of Dry
dryDiversity <- dryRichness %>%
  select(Location, Richness) %>%
  mutate(n_over_N_squared = ((Richness / sum(Richness)^2)),
         Biodiverity = (1-sum(n_over_N_squared)))
# isolate just biodiversity
dryBiodiveristy <- dryDiversity %>% group_by(Biodiversity)

# merge wet and dry biodiversity table??
MergedBiodiversity <- merge.data.frame(wetBiodiveristy, dryBiodiveristy, by = "Biodiversity")

# bar graph richness over wet/dry
ggplot(data = MergedBiodiversity, aes(x = Location))+
  geom_bar()+
  ggtitle("Biodiveresity by Sensor Location")+
  theme_bw()+
  xlab("Location")+
  ylab("Biodiversity")

# biodiversity??
n <- richness$Frequency
N <- sum(richness$Frequency)
returnValue(N)
returnValue(n)
parms <- c(n,N)
calculate_biodiversity <- function(parms){
  n <- parms[1]
  N <- parms[2]
  # function
  biodiversity <- 1-(sum((n/N)^2))
  returnValue(biodiversity)
}
calculate_biodiversity(parms)

