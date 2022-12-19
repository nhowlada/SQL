create table table1(
col1 varchar(10),
col2 varchar(10)
)
insert into table1 values(NULL, 'a')
insert into table1 values(NULL, 'b')

create table table2(
col1 varchar(10),
col2 varchar(10)
)

insert into table2 values(NULL, 'c')

SELECT * FROM TABLE1 T1 INNER JOIN TABLE2 T2 ON T1.COL1=T2.COL1


select *, 
CASE 
WHEN a.cust_id is NULL then 'Data issues'
WHEN b.cust_id is NULL then 'Data issues'
else 'Good data'
END as stae_cd_status

from (
    select cust_id,tran_date, tran_ammt, sum(tran_ammt) over(partition by tran_date), rank() over(partition by tran_date order by tran_ammt desc) as rank_no
    from cards_ingest.tran_fact
    ) a
full outer join cards_ingest.cust_dim_details b on a.cust_id=b.cust_id and (a.tran_date between b.start_date and b.end_date)
where a.rank_no=2