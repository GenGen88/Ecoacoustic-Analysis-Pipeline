# read the report csv
report <- read.csv("./report.csv")

# generate a plot summary
bio.diversity.plot <- report %>% ggplot(aes(x = SpeciesCode)) + geom_bar()

bio.diversity.plot
