sp
================

  - [CRS](#crs)
      - [Geographic / unprojected](#geographic-unprojected)
      - [Projected](#projected)
  - [SpatialPoints](#spatialpoints)
      - [SpatialPointsDataFrame](#spatialpointsdataframe)
  - [SpatialLines](#spatiallines)
      - [SpatialLinesDataFrame](#spatiallinesdataframe)
  - [SpatialPolygons](#spatialpolygons)
      - [SpatialPolygonsDataFrame](#spatialpolygonsdataframe)

-----

## CRS

  - Coordinate Reference System  
  - defines locations on the Earth’s surface  
  - notation used to describe the CRS is called the `proj4string` (from
    the `PROJ.4` library)  
  - the proj4string has several attributes, including:
      - `proj` - projection
      - `datum` - defines origin and direction of axes
      - `ellps` - model for the shape of the earth
  - CRS can also be reference by an EPSG code (European Petroleum Survey
    Group)

### Geographic / unprojected

Latitude/longitde for referencing location on a 3D model of the Earth’s
surface (typically ellipsoidal).

``` r
# google earth - WGS84 (World Geodesic System 1984) lat-long
CRS("+init=epsg:4326")
## CRS arguments:
##  +init=epsg:4326 +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84
## +towgs84=0,0,0
```

``` r
# US federal agencies - NAD83 (North American Datum 1983)
CRS("+init=epsg:4269")
## CRS arguments:
##  +init=epsg:4269 +proj=longlat +datum=NAD83 +no_defs +ellps=GRS80
## +towgs84=0,0,0
```

### Projected

Easting/Northing for referencing location on 2D representations of the
Earth’s surface.

Example projections: Mercator, UTM, Robinson, Lambert, Sinusoidal,
Robinson, Albers.

``` r
# google maps, open street map
CRS("+init=epsg:3857")
## CRS arguments:
##  +init=epsg:3857 +proj=merc +a=6378137 +b=6378137 +lat_ts=0.0
## +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null
## +no_defs
```

``` r
# OSGB36 (Ordnance Survey Great Britain 1936) easting / northing
CRS("+init=epsg:27700")
## CRS arguments:
##  +init=epsg:27700 +proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717
## +x_0=400000 +y_0=-100000 +datum=OSGB36 +units=m +no_defs
## +ellps=airy
## +towgs84=446.448,-125.157,542.060,0.1502,0.2470,0.8421,-20.4894
```

``` r
# utm 30 (UK?)
CRS("+proj=utm +zone=30")
## CRS arguments: +proj=utm +zone=30 +ellps=WGS84
```

``` r
# utm 48 (Cambidia?)
CRS("+proj=utm +zone=48")
## CRS arguments: +proj=utm +zone=48 +ellps=WGS84
```

<https://www.rspatial.org/spatial/6-crs.html>

<https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/OverviewCoordinateReferenceSystems.pdf>

<https://geocompr.robinlovelace.net/spatial-class.html#crs-intro>

<https://proj.org/>

<https://spatialreference.org>

-----

## SpatialPoints

S4 class with three slots:

  - coords
  - bbox
  - proj4string

<!-- end list -->

``` r
coords = cbind(x = round(runif(10), 2), 
               y = round(runif(10), 2))
head(coords)
##         x    y
## [1,] 0.13 0.17
## [2,] 0.53 0.50
## [3,] 0.86 0.14
## [4,] 0.97 0.34
## [5,] 0.53 0.94
## [6,] 0.18 0.87
```

``` r
spoints = SpatialPoints(coords)
spoints
## SpatialPoints:
##          x    y
##  [1,] 0.13 0.17
##  [2,] 0.53 0.50
##  [3,] 0.86 0.14
##  [4,] 0.97 0.34
##  [5,] 0.53 0.94
##  [6,] 0.18 0.87
##  [7,] 0.05 0.16
##  [8,] 0.95 0.28
##  [9,] 0.17 0.20
## [10,] 0.69 0.53
## Coordinate Reference System (CRS) arguments: NA
```

``` r
slotNames(spoints)
## [1] "coords"      "bbox"        "proj4string"
```

``` r
spoints@coords
##          x    y
##  [1,] 0.13 0.17
##  [2,] 0.53 0.50
##  [3,] 0.86 0.14
##  [4,] 0.97 0.34
##  [5,] 0.53 0.94
##  [6,] 0.18 0.87
##  [7,] 0.05 0.16
##  [8,] 0.95 0.28
##  [9,] 0.17 0.20
## [10,] 0.69 0.53
```

``` r
spoints@bbox
##    min  max
## x 0.05 0.97
## y 0.14 0.94
```

``` r
spoints@proj4string
## CRS arguments: NA
```

``` r
plot(spoints, pch = 2, axes = TRUE)
```

![](sp_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

### SpatialPointsDataFrame

``` r
df = data.frame(z = round(5 + rnorm(10), 2))
spoints_df = SpatialPointsDataFrame(spoints, df)
spoints_df
##     coordinates    z
## 1  (0.13, 0.17) 4.52
## 2   (0.53, 0.5) 4.84
## 3  (0.86, 0.14) 6.05
## 4  (0.97, 0.34) 4.88
## 5  (0.53, 0.94) 3.93
## 6  (0.18, 0.87) 6.72
## 7  (0.05, 0.16) 5.28
## 8  (0.95, 0.28) 6.36
## 9   (0.17, 0.2) 4.73
## 10 (0.69, 0.53) 4.97
```

-----

## SpatialLines

### SpatialLinesDataFrame

-----

## SpatialPolygons

``` r
Sr1 = Polygon(cbind(c(2,4,4,1,2),c(2,3,5,4,2)))
Sr2 = Polygon(cbind(c(5,4,2,5),c(2,3,2,2)))
Sr3 = Polygon(cbind(c(4,4,5,10,4),c(5,3,2,5,5)))
Sr4 = Polygon(cbind(c(5,6,6,5,5),c(4,4,3,3,4)), hole = TRUE)

Srs1 = Polygons(list(Sr1), "s1")
Srs2 = Polygons(list(Sr2), "s2")
Srs3 = Polygons(list(Sr3, Sr4), "s3/4")
SpP = SpatialPolygons(list(Srs1,Srs2,Srs3), 1:3)
plot(SpP, col = 1:3, pbg="white")
```

![](sp_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

``` r

grd <- GridTopology(c(1,1), c(1,1), c(10,10))
polys <- as(grd, "SpatialPolygons")
plot(polys)
text(coordinates(polys), labels=row.names(polys))
```

![](sp_files/figure-gfm/unnamed-chunk-17-2.png)<!-- -->

### SpatialPolygonsDataFrame

-----

SpatialGridDataFrameand SpatialPixelsDataFram
