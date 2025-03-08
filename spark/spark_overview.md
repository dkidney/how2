# spark: overview

> Apache Spark is Apache Spark is a unified analytics engine for large-scale data processing.

## links

https://spark.apache.org/docs/3.5.4/

https://sparkbyexamples.com/

https://www.datacamp.com/tutorial/pyspark-tutorial-getting-started-with-pyspark

https://www.ibm.com/think/topics/apache-spark

## general

* open source, scalable, massively parallel, in-memory execution environment for running analyics applications

* in-memory layer that sits above multiple data stores where data can be loaded into memory and analyzed in parallel across a cluster

* distributes data across the cluster and processes the data in parallel 

* data can be stored on the local file system, hdfs, s3, sql and nosql databases

## RDDs

* **Resilient distrbuted dataset**

* Fundamental data structure

* Can handle both structured and unstructured data

* Immutable distributed collection of objects - can contain any type of Python, Java, or Scala objects, including user-defined classes.

* Partitioned - i.e. the data is divided into logical chunks that can be processed in parallel on different nodes

## dataframes

* an abstraction built on top of RDDs

* can be used with spark SQL

* supports multiple data sources and programming languages

* can process both structured and unstructured data

* can perform operations on the data e.g. select, filter, etc.

## configuration

cluster

driver

workers / executors
