library(tidyverse)
library(dplyr)

# import data from VRES example
data1 <- read.csv("C:\\Users\\gldia\\OneDrive\\Documents\\VRES-Analyser\\example\\report.csv", header=TRUE, stringsAsFactors = FALSE)
# import data from ubuntu thing
data1 <- read.csv("C:\\Users\\gldia\\Documents\\report.csv",header=TRUE, stringsAsFactors = FALSE)
filteredData <- filter(data1, data1$Confidence >0.5)

# table of just species and time
speciesTimeData <-data.frame(data1$CommonName, data1$date)
colnames(speciesTimeData) = c("CommonName", "Date")

# generates just the species name data
speciesData <-data.frame(data1$CommonName)
colnames(speciesData) = c("CommonName")

#generates a table of how many times a species appeared
richness <- speciesData %>% count(data1.CommonName)
colnames(richness) = c("CommonName", "Frequency")

#generates a table of species richness over date
richnessDate <- speciesTimeData %>% group_by(data1$date)%>% count(data1$date)
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

 # biodiversity over time????
n <- richness$Frequency
N <- sum(richness$Frequency)
parms <- c(n,N)
calculate_biodiversity <- function(parms){
  n <- parms[1]
  N <- parms[2]
  # function
  biodiversity <- 1-(sum(n/N)^2)
  return(biodiversity)
}
