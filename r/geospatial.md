Geospatial
================

  - [geosphere](#geosphere)
      - [distVincentyEllipsoid](#distvincentyellipsoid)
  - [mapdata](#mapdata)
  - [maps](#maps)
  - [map.scale](#map.scale)
  - [maptools](#maptools)
      - [readShapePoly](#readshapepoly)
  - [osmdata](#osmdata)
  - [sf](#sf)
  - [sp](#sp)
      - [SpatialPoints](#spatialpoints)
      - [SpatialLines](#spatiallines)
      - [SpatialPolygons](#spatialpolygons)
      - [SpatialPointsDataFrame](#spatialpointsdataframe)
      - [SpatialLinesDataFrame](#spatiallinesdataframe)
      - [SpatialPolygonsDataFrame](#spatialpolygonsdataframe)
      - [SpatialGridDataFrame](#spatialgriddataframe)
      - [SpatialPixelsDataFrame](#spatialpixelsdataframe)
  - [raster](#raster)
  - [rgdal](#rgdal)
      - [CRS](#crs)
      - [readOGR](#readogr)
      - [spTransform](#sptransform)
      - [writeOGR](#writeogr)
  - [rgeos](#rgeos)
      - [gDIfference](#gdifference)
      - [gDistance](#gdistance)
      - [gIntersection](#gintersection)
      - [gUnionCascaded](#gunioncascaded)

-----

## geosphere

### distVincentyEllipsoid

-----

## mapdata

``` r
library(mapdata)
data(worldHiresMapEnv)
```

-----

## maps

``` r
library(maps)
map(
  "worldHires",
  xlab = "lon",
  ylab = "lat",
  regions = "south africa",
  xlim = c(15, 34),
  ylim = c(-35, -22),
  fill = TRUE,
  col = "grey95",
  mar = c(0, 0, 0, 1)
)
```

## map.scale

-----

## maptools

### readShapePoly

-----

## osmdata

-----

## sf

-----

## sp

### SpatialPoints

### SpatialLines

### SpatialPolygons

### SpatialPointsDataFrame

### SpatialLinesDataFrame

### SpatialPolygonsDataFrame

### SpatialGridDataFrame

### SpatialPixelsDataFrame

-----

## raster

raster brick stack writeRaster projectExtent

-----

## rgdal

### CRS

E.g.

| asdf                 | asdf                    |
| -------------------- | ----------------------- |
| “+init=epsg:27700”   | OSGB easting / northing |
| “+proj=longlat”      | latitude / longitude    |
| “+proj=utm +zone=30” | utm 30 (UK?)            |
| “+proj=utm +zone=48” | utm 48 (Cambidia?)      |

### readOGR

### spTransform

### writeOGR

-----

## rgeos

### gDIfference

### gDistance

### gIntersection

### gUnionCascaded

-----
