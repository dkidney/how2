create table if not exists my_table (
    colname1 varchar,
    colname2 double
)
with (format = 'PARQUET')
;

insert into my_table
values
('a', 1.0),
('b', 2.0),
('c', 3.0),
;