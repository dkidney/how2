Geospatial
================

  - [mapdata](#mapdata)
  - [maps](#maps)
  - [map.scale](#map.scale)
  - [maptools](#maptools)
      - [readShapePoly](#readshapepoly)
  - [osmdata](#osmdata)
  - [sf](#sf)
  - [sp](#sp)
      - [SpatialPolygons](#spatialpolygons)
  - [rgdal](#rgdal)
      - [CRS](#crs)
      - [readOGR](#readogr)
      - [spTransform](#sptransform)
  - [rgeos](#rgeos)
      - [gDIfference](#gdifference)
      - [gDistance](#gdistance)
      - [gIntersection](#gintersection)
      - [gUnionCascaded](#gunioncascaded)

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

### SpatialPolygons

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

-----

## rgeos

### gDIfference

### gDistance

### gIntersection

### gUnionCascaded

-----
