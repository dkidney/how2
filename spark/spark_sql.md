# spark: sql

> A distributed query engine.

> A Spark module for structured or semi-strucuted data processing.

## links

https://spark.apache.org/docs/latest/sql-programming-guide.html

## principles

### shuffling

* Shuffling is a mechanism Spark uses to redistribute the data across different executors.

* Spark Shuffle is an expensive operation.

* Spark provides `spark.sql.shuffle.partitions` configurations to control the partitions of the shuffle - by tuning this property you can improve Spark performance.

## joins

### shuffle sort-merge join

* The default join implementation (since Spark 2.3).

* Use when both tables are medium to large.

1. Shuffle: both datasets are shuffled so that records with the same join key are on the same worker.

1. Perform a sort-merge join within each partition:

    * Sort: records are sorted by the join key on each partition.
    
    * Merge: the sorted and partitioned data is merged by iterating over the elements and joining rows with the same join key.

1. Combine the results from each partition

### shuffle hash join

1. Shuffle: both datasets are shuffled so that records with the same join key are on the same worker.

1. Perform a standard hash join within each partition:

    * Shuffle:

    * Hash: 

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

### broadcast nested loop join

Nested loop join execution: Each row from the larger table is compared against every row in the broadcasted smaller table using a nested loop

### cross join

* also called a cartesian join

* combines every single row from one table with every single row from another table

* creates all possible combinations between the two tables, without any specific matching criteria.

```python
# cross join is the default if no type is specified
# however this will result in an AnalysisException
# unless spark.sql.crossJoin.enabled is set to True
spark.conf.get("spark.sql.crossJoin.enabled") ## default is False
spark.conf.set("sspark.sql.crossJoin.enabled", True) 
```

## performance optimisation

* Use `coalesce()` to **reduce** the number of partitions.

* Use `repartition()` to **increase** the number of partitions.

* Try to avoid UDFs (i.e. user defined functions) unless existing Spark built-in functions are unavailable.



## sql execution plans

* Use `.explain()` to see the `Physical Plan`


## interpreter

## optimiser