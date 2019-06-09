sql
================

  - [order by](#order-by)
  - [select](#select)
  - [where](#where)

-----

#### order by

``` sql
SELECT col1
FROM table
ORDER BY col2 DESC;
```

-----

#### select

aggregate functions

``` sql
SELECT 
  AVG(col) as avg, 
  MAX(col) as max, 
  SUM(col) as sum
FROM table;
```

``` sql
SELECT COUNT(col) * 100.0 / COUNT(*) AS asdf
FROM table;
```

-----

#### where

where and or

``` sql
SELECT col1
FROM table
WHERE (col2 = 1 OR col2 = 2)
AND (col3 = 'A' OR col3 = 'B');
```

where between

``` sql
SELECT col1
FROM table
WHERE col2 BETWEEN 1 AND 2; 
--BETWEEN is inclusive, i.e. the beginning and end values are included
```

where in

``` sql
SELECT col1
FROM table
WHERE col2 IN (1, 10, 100);
```

where is

``` sql
-- can also use IS NOT
SELECT col1
FROM table
WHERE col2 IS NULL;
```

where like

``` sql
-- can also use NOT LIKE
SELECT col1
FROM table
WHERE col2 LIKE 'asdf%';
```
