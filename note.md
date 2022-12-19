# SQL

## WEEK 1

* SELECT
```SQL
  select * from table where col='1000' order by desc limit 5
  select * from( select col from table) a where a.col='AA'
  select count(col) from table group by col having count(col)>1
  select *, SUM(col1) over(partition by col1 order by col2 desc)
```

* CREAT TABLE
  * If "IF NOT EXIST" is present in your queries and the table exists, it will continue execution. 
  * If "IF NOT EXIST" is not present in your queries and the table exists, it will terminate execution.


* INSERT
```SQL
  INSERT INTO <TABLE> (<COLUMNS>) VALUES (<VALUES>)
```
* WHERE 
* GROUP BY
* HAVING
* ORDER BY
* LIMIT


* JOIN
  * cross join
  ```SQL
  SELECT * from table1, table2
  ```
  * inner join
  ```SQL
  SELECT * from table1 a inner join table2 b on a.col=b.col
  ```
  * left join
  ```SQL
  SELECT * from table1 a left join table2 b on a.col=b.col
  ```
  * right join
  ```SQL
  SELECT * from table1 a right join table2 b on a.col=b.col
  ```
  * full outer join
  ```SQL
  SELECT * from table1 a full outer join table2 b on a.col=b.col
  ```
  * In ***INNER JOIN*** inside the ***ON*** clause if you have ***AND*** condition you can use ***WHERE*** clause for the ***AND*** condition. However, in ***OTHER JOIN*** operation is better to use ***AND*** condition inside the ***ON*** clauser

* STRING FUNCTION
  * SUM
  * AVG
  * MAX
  * MIN
  * COUNT
  * COALESCE


* ORDER OF EXECUTION
```SQL
  FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMT
```


* WINDOW FUNCTION
    * RANK
    * DENSE_RANK
    * ROW_NUMBER

* CONSTRAINT
  * Modern architect do not use the constraint because it make the database operation slower

## WEEK 2
* REVIEW WEEK 1 AND SOLVE THE WEEKEND QUESTION
* WITH CLAUSE
  * WITH 
    ```SQL
      TABLE1 AS(SELECT * FROM TABLE)
      TABLE1 AS(SELECT * FROM TABLE)
      select * form table1 join table2
    ```
* WINDOW FUNCTION
    * LAG
    * LEAD
* NULL handelling in better way
  * Always replace the NULL with the **COALESCE** function. Ex, *
  ```SQL
    SELECT COLUMN FROM TABLE WHERE COALESCE(COL,'AA') != COALESCE(COL,'BB') (Instead WHERE COL IS NULL)
  ```