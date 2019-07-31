rgdal
================

  - [readOGR](#readogr)
  - [writeOGR](#writeogr)
  - [spTransform](#sptransform)
  - [make\_EPSG](#make_epsg)
  - [projInfo](#projinfo)

-----

> R Geospatial Data Abstraction Library

  - <https://cran.r-project.org/package=rgdal>

-----

### readOGR

-----

### writeOGR

-----

### spTransform

To transform from one CRS to another: newData \<- spTransform(x,
CRS(“+init=epsg:4238”)) or, reference the CRS of another spatial
object: newData \<- spTransform(x, proj4string(OtherData))

-----

### make\_EPSG

Lists all the available EPSG (European Petroleum Survey Group) codes for
CRS proj4strings.

``` r
make_EPSG() %>% as_tibble
## # A tibble: 5,513 x 3
##       code note                          prj4                              
##    <I<int> <I<chr>>                      <I<chr>>                          
##  1    3819 # HD1909                      +proj=longlat +ellps=bessel +towg…
##  2    3821 # TWD67                       +proj=longlat +ellps=aust_SA +no_…
##  3    3824 # TWD97                       +proj=longlat +ellps=GRS80 +towgs…
##  4    3889 # IGRS                        +proj=longlat +ellps=GRS80 +towgs…
##  5    3906 # MGI 1901                    +proj=longlat +ellps=bessel +towg…
##  6    4001 # Unknown datum based upon t… +proj=longlat +ellps=airy +no_defs
##  7    4002 # Unknown datum based upon t… +proj=longlat +ellps=mod_airy +no…
##  8    4003 # Unknown datum based upon t… +proj=longlat +ellps=aust_SA +no_…
##  9    4004 # Unknown datum based upon t… +proj=longlat +ellps=bessel +no_d…
## 10    4005 # Unknown datum based upon t… +proj=longlat +a=6377492.018 +b=6…
## # … with 5,503 more rows
```

-----

### projInfo

Lists all the different options for CRS proj4string attributes.

#### proj

``` r
projInfo(type  =  "proj") %>% as_tibble
## # A tibble: 143 x 2
##    name   description                        
##    <fct>  <fct>                              
##  1 aea    Albers Equal Area                  
##  2 aeqd   Azimuthal Equidistant              
##  3 airy   Airy                               
##  4 aitoff Aitoff                             
##  5 alsk   Mod. Stereographic of Alaska       
##  6 apian  Apian Globular I                   
##  7 august August Epicycloidal                
##  8 bacon  Bacon Globular                     
##  9 bipc   Bipolar conic of western hemisphere
## 10 boggs  Boggs Eumorphic                    
## # … with 133 more rows
```

#### datum

``` r
projInfo(type  =  "datum") %>% as_tibble
## # A tibble: 10 x 4
##    name      ellipse  definition                      description          
##    <fct>     <fct>    <fct>                           <fct>                
##  1 WGS84     WGS84    towgs84=0,0,0                   ""                   
##  2 GGRS87    GRS80    towgs84=-199.87,74.79,246.62    Greek_Geodetic_Refer…
##  3 NAD83     GRS80    towgs84=0,0,0                   North_American_Datum…
##  4 NAD27     clrk66   nadgrids=@conus,@alaska,@ntv2_… North_American_Datum…
##  5 potsdam   bessel   towgs84=598.1,73.7,418.2,0.202… Potsdam Rauenberg 19…
##  6 carthage  clrk80i… towgs84=-263.0,6.0,431.0        Carthage 1934 Tunisia
##  7 hermanns… bessel   towgs84=577.326,90.129,463.919… Hermannskogel        
##  8 ire65     mod_airy towgs84=482.530,-130.596,564.5… Ireland 1965         
##  9 nzgd49    intl     towgs84=59.47,-5.04,187.44,0.4… New Zealand Geodetic…
## 10 OSGB36    airy     towgs84=446.448,-125.157,542.0… Airy 1830
```

#### ellps

``` r
projInfo(type  =  "ellps") %>% as_tibble %>% tail
## # A tibble: 6 x 4
##   name    major       ell              description              
##   <fct>   <fct>       <fct>            <fct>                    
## 1 walbeck a=6376896.0 b=6355834.8467   Walbeck                  
## 2 WGS60   a=6378165.0 rf=298.3         WGS 60                   
## 3 WGS66   a=6378145.0 rf=298.25        WGS 66                   
## 4 WGS72   a=6378135.0 rf=298.26        WGS 72                   
## 5 WGS84   a=6378137.0 rf=298.257223563 WGS 84                   
## 6 sphere  a=6370997.0 b=6370997.0      Normal Sphere (r=6370997)
```

#### units

``` r
projInfo(type  =  "units") %>% as_tibble
## # A tibble: 21 x 3
##    id    to_meter name                       
##    <fct> <fct>    <fct>                      
##  1 km    1000.    Kilometer                  
##  2 m     1.       Meter                      
##  3 dm    1/10     Decimeter                  
##  4 cm    1/100    Centimeter                 
##  5 mm    1/1000   Millimeter                 
##  6 kmi   1852.0   International Nautical Mile
##  7 in    0.0254   International Inch         
##  8 ft    0.3048   International Foot         
##  9 yd    0.9144   International Yard         
## 10 mi    1609.344 International Statute Mile 
## # … with 11 more rows
```
