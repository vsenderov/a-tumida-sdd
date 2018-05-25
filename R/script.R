library(measurements)
library(stringi)

data <- read.csv2(file = "../data/dataset1.csv", encoding = "UTF-8")
data$decimalLatitude = sapply(data$verbatimLatitude, deg2dec)
data$decimalLongitude = sapply(data$verbatimLongitude, deg2dec)
data$scientificName = rep(x = "aetina_tumida", times = nrow(data))
data <- wide2long(data)

maxent_data = data.frame(species = data$scientificName, "dd long" = data$decimalLongitude, "dd lat" = data$decimalLatitude)
names(maxent_data) = c("species", "dd long", "dd lat")
write.csv(file = "../data/dataset1-maxent.csv", x = maxent_data, quote = FALSE, row.names = FALSE)
