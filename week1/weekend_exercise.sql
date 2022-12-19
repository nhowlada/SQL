-- Part 1
-- 1. show me all the tran_date,tran_ammt and total tansaction ammount per tran_date
    select tran_date, tran_ammt, sum(tran_ammt) over(partition by tran_date)
    from cards_ingest.tran_fact
-- 2. show me all the tran_date,tran_ammt and total tansaction ammount per tran_date and rank of the transaction ammount desc within per tran_date
    select tran_date, tran_ammt, sum(tran_ammt) over(partition by tran_date), rank() over(partition by tran_date order by tran_ammt desc)
    from cards_ingest.tran_fact
-- Ouput:
-- 2022-01-01,7145.00,19543.00,1
-- 2022-01-01,6125.00,19543.00,2
-- 3. show me all the fields and total tansaction ammount per tran_date and only 2nd rank of the transaction ammount desc within per tran_date
--  (Here you are using he question2 but filtering only for rank 2)
-- Solution:1
    with cte as (
    select tran_date, tran_ammt, sum(tran_ammt) over(partition by tran_date), rank() over(partition by tran_date order by tran_ammt desc) as rank_no
    from cards_ingest.tran_fact
    )
    select * from cte where rank_no=2

-- Solution:2
    select * from (
    select tran_date, tran_ammt, sum(tran_ammt) over(partition by tran_date), rank() over(partition by tran_date order by tran_ammt desc) as rank_no
    from cards_ingest.tran_fact
    ) a
    where a.rank_no=2


-- Part 2

-- 1. Join tran_fact and cust_dim_details on cust_id and tran_dt between start_date and end_date
    select *
    from cards_ingest.tran_fact a
    inner join cards_ingest.cust_dim_details b on a.cust_id=b.cust_id and (a.tran_date between b.start_date and b.end_date)

-- 2. show me all the fields and total tansaction ammount per tran_date and only 2nd rank of the transaction
--  ammount desc within per tran_date(Here you are using he question2 but filtering only for rank 2) and join
--   cust_dim_details on cust_id and tran_dt between start_date and end_date

    select * from (
    select cust_id,tran_date, tran_ammt, sum(tran_ammt) over(partition by tran_date), rank() over(partition by tran_date order by tran_ammt desc) as rank_no
    from cards_ingest.tran_fact
    ) a
    inner join cards_ingest.cust_dim_details b on a.cust_id=b.cust_id and (a.tran_date between b.start_date and b.end_date)
    where a.rank_no=2
-- 3. From question 2 : when stat_cd is not euqal to state_cd then data issues else good data as stae_cd_status
--  [Note NUll from left side is not equal NUll from other side  >> means lets sayd NULL value from fact table if compared
--  to NULL Value to right table then it should be data issues]