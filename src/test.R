source("C:/Users/tnauss/permanent/plygrnd/hessen_species_prediction/SpeciesPrediction/src/00_set_environment.R")

# Read data
ldr = stack(paste0(path_lidar, "test.tiff"))
spc = shapefile(paste0(path_species, "Lucanus/Lucanus_Hessen.shp"))
spg = shapefile(paste0(path_species, "Lucanus/Meldungen_Gutachter.shp"))
osm = shapefile(paste0(path_osm, "gis_osm_landuse_a_free_1.shp"))


# Project files
spg = spTransform(spg, projection(spc))
osm = spTransform(osm, projection(spc))


# Combine species datasets
spg = spTransform(spg, projection(spc))

rmv = which(!names(spg@data) %in% names(spc@data))
spg@data[, rmv] = NULL

spc = rbind(spg, spc)



# Visualization
mapview(spc)
str(osm@data)

# mapview(ldr) + spc

# Extract raster values for observation points
spc = spTransform(spc, projection(ldr))
spc_df = extract(ldr,spc, df = TRUE)
spc_df = cbind(spc_df, spc@data)
spc_df = spc_df[complete.cases(spc_df), ]
str(spc_df)



