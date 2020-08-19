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

# New data

dwc2maxent(
  dwc = "occurrence-data-raw//A-tumida-new-data-2020.dwc.csv",
  maxent = "samples//A-tumida-occurrences-new-data.maxent",
  decimal = TRUE
)

dwc2maxent(
  dwc = "occurrence-data-raw//A-tumida-occurrences-Italy.csv",
  maxent = "samples//test.maxent"
)


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
day_moisture_data_stack = stack(netcdf_sources, varname="sm")

soil_mean = mean(day_moisture_data_stack, na.rm = TRUE)
soil_max <-  max(day_moisture_data_stack, na.rm = TRUE)
soil_min <  -min(day_moisture_data_stack, na.rm = TRUE)

e = extent(-180, 180, -60, 90)

soil_mean = crop(soil_mean, e)
soil_max = crop(soil_max, e)
soil_min = crop(soil_min, e)

writeRaster(x=soil_mean, filename="env-var/soil-mean.asc", format="ascii")

writeRaster(x=soil_min, filename="env-var/soil-min.asc", format="ascii")

writeRaster(x=soil_max, filename="env-var/soil-max.asc", format="ascii")

# World clim data

BClim = resample(getData("worldclim", var="bio", res=10, path="env-var/"),
                 soil_mean)
 
save(soil_mean, soil_max, soil_min, BClim, file = "env-var/environment-data.Rdata")
