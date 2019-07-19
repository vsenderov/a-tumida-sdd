# Setup

library(measurements)
library(stringi)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
source("R/functions.R")
setwd("..")

# Convert DwC CSV file to Maxent Format

# Italy

dwc2maxent(
 dwc = "occurrence-data//A-tumida-occurrences-Italy.csv",
 maxent = "maxent-input//A-tumida-occurrences-Italy.maxent"
)

# World is done

# Inspect Data

occurrences_italy <- read.csv(file = "maxent-input//A-tumida-occurrences-Italy.maxent",  header = TRUE, sep = ",")
italy <- map_data("italy")

ggplot() +
  geom_polygon(
    data = italy,
    aes(x=long, y = lat, group = group)
    ) + 
  coord_fixed(1.3) +
  geom_point(
    data = occurrences_italy,
    aes(x = dd_long, y = dd_lat),
    color = "black",
    size = 5
    ) +
  geom_point(
    data = occurrences_italy,
    aes(x = dd_long, y = dd_lat),
    color = "yellow",
    size = 4
    )

# Seems that there are some occurrence way out of Italy, delete them.

occurrences_italy <- occurrences_italy[occurrences_italy$dd.long < 100, ]

write.csv(file = "maxent-input//A-tumida-occurrences-Italy.maxent", x = occurrences_italy, quote = FALSE, row.names = FALSE)



# WORLD

occurrences_world <- read.csv(file = "maxent-input//A-tumida-occurrences-World+Italy.maxent",  header = TRUE, sep = ",",
                              colClasses = c("character", "numeric", "numeric"))
world <- map_data("world")

ggplot() +
  geom_polygon(
    data = world,
    aes(x=long, y = lat, group = group)
  ) + 
  coord_fixed(1.3) +
  geom_point(
    data = occurrences_world,
    aes(x = dd_long, y = dd_lat),
    color = "black",
    size = 5
  ) +
  geom_point(
    data = occurrences_world,
    aes(x = dd_long, y = dd_lat),
    color = "yellow",
    size = 4
  )




## GBIF Occurrences

occurrences_gbif <- read.table(file = "Work/a-tumida-sdd/occurrence-data/0002269-180920211646547.csv", header = TRUE, dec = ".", sep = "\t")
occurrences_gbif <- occurrences_gbif[, c("species", "decimallatitude", "decimallongitude")]

world <- map_data("world")

ggplot() +
  geom_polygon(
    data = world,
    aes(x=long, y = lat, group = group)
  ) + 
  coord_fixed(1.3) +
  geom_point(
    data = occurrences_gbif,
    aes(x = decimallongitude, y = decimallatitude),
    color = "black",
    size = 5
  ) +
  geom_point(
    data = occurrences_gbif,
    aes(x = decimallongitude, y = decimallatitude),
    color = "yellow",
    size = 4
  )
