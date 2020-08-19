library(raster)

files        = list.files("environmental-layers/", pattern='asc', full.names=TRUE)
names(files) = sapply( strsplit(files, "//"), function(x) { x[2] } )
Grids        = raster::stack(files)
stats        = layerStats(Grids, 'pearson', na.rm = TRUE)

variables_selected = c("bioclim_5.asc", "bioclim_6.asc", "bioclim_13.asc", "bioclim_14.asc", "bioclim_15.asc", "bioclim_18.asc", "bioclim_19.asc", "soil.max.asc", "soil.min.asc")

stats$`pearson correlation coefficient`[variables_selected, variables_selected]
