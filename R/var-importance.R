library(raster)

files        = list.files("environmental-layers/", pattern='asc', full.names=TRUE)
names(files) = sapply( strsplit(files, "//"), function(x) { x[2] } )
Grids        = raster::stack(files)
stats        = layerStats(Grids, 'pearson', na.rm = TRUE)

