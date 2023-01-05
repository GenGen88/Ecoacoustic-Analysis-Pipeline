data <- read.csv("./out/example.csv")
species <- data["Species.Code"]
time <- data["Begin.Time"]

daejun.species <- species == "daejun"

plot(daejun.species)
