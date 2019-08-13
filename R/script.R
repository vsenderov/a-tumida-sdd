# Setup

install.packages(c("measurements", "stringi", "ggplot2", "ggmap", "maps", "mapdata"))

library(measurements)
library(stringi)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
source("functions.R")
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


occurrences_gbif <- read.table(file = "occurrence-data/0002269-180920211646547.csv", header = TRUE, dec = ".", sep = "\t")
occurrences_gbif <- occurrences_gbif[, c("species", "decimallatitude", "decimallongitude")]

occurrences_maxent = data.frame(rep("aetina_tumida", length(occurrences_gbif[[3]])), occurrences_gbif[[3]], occurrences_gbif[[2]])
names(occurrences_maxent)=c("species", "dd_long", "dd_lat")
write.csv(file = "maxent-input/gbif.csv", occurrences_maxent, quote = FALSE, row.names=FALSE)

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


# Soil Moisture Data

library(raster)

soil_moisture_data_dir <- "/home/viktor/Data/soil-moisture"
years <- c(2014, 2015, 2016, 2017, 2018)

netcdf_sources <- list.files(paste(soil_moisture_data_dir, years, sep = "/"), full.names = TRUE)

day_moisture_data <- lapply(netcdf_sources, raster, varname = "sm")

five_year_average <- do.call(mean, c(day_moisture_data, na.rm=TRUE))

writeRaster(x=five_year_average, filename="5year-moisture-mean.asc", format="ascii")
save(five_year_average, file = "moisture-data.Rdata")


day_moisture_data_stack = stack(netcdf_sources, varname="sm")
five_year_max <-max(day_moisture_data_stack, na.rm = TRUE)

writeRaster(x=five_year_max, filename="5year-moisture-max.asc", format="ascii")
save(five_year_average, five_year_max, file = "moisture-data.Rdata")

five_year_min <-min(day_moisture_data_stack, na.rm = TRUE)

writeRaster(x=five_year_min, filename="5year-moisture-min.asc", format="ascii")
save(five_year_average, five_year_max, five_year_min, file = "moisture-data.Rdata")
