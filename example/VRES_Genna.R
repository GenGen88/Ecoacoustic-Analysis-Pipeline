library(tidyverse)
library(dplyr)

# import data
data1 <- read.csv("C:\\Users\\gldia\\OneDrive\\Documents\\VRES-Analyser\\example\\report.csv", header=TRUE, stringsAsFactors = FALSE)

# table of just species and time
speciesTimeData <-data.frame(data1$CommonName, data1$date)

# generates just the species name data
speciesData <-data.frame(data1$CommonName)

#generates a table of how many times a species appeared
richness <- speciesData %>% count(data1.CommonName)
colnames(richness) = c("CommonName", "Frequency")

#generates a table of species richness over date
richnessDate <- speciesTimeData %>% group_by(data1$date)%>% count(data1$date)




