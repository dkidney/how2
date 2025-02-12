# spark sql

> A distributed query engine.

> A Spark module for structured data processing.

## configuration

cluster

driver

workers / executors

## principles

### shuffling

* Shuffling is a mechanism Spark uses to redistribute the data across different executors.

* Spark Shuffle is an expensive operation.

* Spark provides `spark.sql.shuffle.partitions` configurations to control the partitions of the shuffle - by tuning this property you can improve Spark performance.

## joins

### shuffle sort-merge join

### sort-merge join

* The default join implementation (since Spark 2.3).

* Both tables are medium to large.

* Three stages

1. Shuffle partitions. 

    * Both tables are sorted on the join key
    * Tables are merged step by step
    * Results are combined

1. Sorting within each partition

1. Join sorted partitions

### shuffle hash join

### broadcast join

* Useful for joining a large table with a smaller one.

* Initially the smaller table is stored on the driver node and is then 'broadcasted' to each executor node - i.e. each executor node holds the entire table in memory (whereas the large table is partitioned across the executor nodes and does not require shuffling). 

* Each worker node then joins the small table to the partition of the larger table.

* Use `spark.sql.autoBroadcastJoinThreshold` to change the threshold for broadcasting. The default is 10MB - i.e. broadcast the small table if <= 10MB.

```python
spark.conf.get("spark.sql.autoBroadcastJoinThreshold") ## default is 10485760 i.e. 10MB
spark.conf.set("spark.sql.autoBroadcastJoinThreshold", 5 * 1024 * 1024) # set to 5MB
```

* Use join hints to make sure that Spark doesn't fail to detet the smaller table (using a hint overrides `spark.sql.autoBroadcastJoinThreshold`).

```sql
SELECT /*+ BROADCAST(small) */ * 
FROM small 
INNER JOIN large
ON small.key = large.key
```

```python
large.join(small.hint("broadcast"), large.key == small.key, "inner")
```

### broadcast hash join

* Does not require data shuffling

* Only applicable when joining a small table to a large one

* Consider using when joining a small table that can fit in the memory of a single Spark executor.

### cartesian join

### broadcast nested loop join

## performance optimisation

* Use `coalesce()` to **reduce** the number of partitions.

* Use `repartition()` to **increase** the number of partitions.

* Try to avoid UDFs (i.e. user defined functions) unless existing Spark built-in functions are unavailable.



## sql execution plans

* Use `.explain()` to see the `Physical Plan`
