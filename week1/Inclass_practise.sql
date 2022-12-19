SELECT stat_cd, sum(tran_ammt) as total
FROM cards_ingest.tran_fact
group by stat_cd

SELECT stat_cd,tran_date, MAX(tran_ammt) as maximum, MIN(tran_ammt) as minimum
FROM cards_ingest.tran_fact
group by stat_cd, tran_date

SELECT SUM(tran_ammt) as total
FROM cards_ingest.tran_fact
WHERE tran_ammt >10000

SELECT stat_cd, SUM(tran_ammt) as total
FROM cards_ingest.tran_fact
group by stat_cd
having SUM(tran_ammt)>10000

SELECT stat_cd, sum(tran_ammt) as total
FROM cards_ingest.tran_fact
group by stat_cd

SELECT stat_cd,tran_date, MAX(tran_ammt) as maximum, MIN(tran_ammt) as minimum
FROM cards_ingest.tran_fact
group by stat_cd, tran_date

SELECT SUM(tran_ammt) as total
FROM cards_ingest.tran_fact
WHERE tran_ammt >10000

SELECT stat_cd, SUM(tran_ammt) as total
FROM cards_ingest.tran_fact
WHERE CUST_ID = 'cust_104'
group by stat_cd
having SUM(tran_ammt)>10000

SELECT cust_id as cst_id
FROM cards_ingest.tran_fact
WHERE CST_ID = 'cust_104'

SELECT COALESCE(stat_cd,'TX'), sum(tran_ammt) as total
FROM cards_ingest.tran_fact
group by stat_cd
having SUM(tran_ammt)>10000


SELECT * 
FROM cards_ingest.tran_fact
WHERE STAT_CD IS NOT NULL
ORDER BY 
LIMIT 


truncate table cards_ingest.tran_fact;

INSERT INTO cards_ingest.tran_fact
	(tran_id, cust_id, stat_cd, tran_ammt, tran_date) VALUES
	(102020, 'cust_101', 'NY', 125,to_date('2022-01-01','yyyy-mm-dd')),
	(102021, 'cust_101', 'NY', 5125,to_date('2022-01-01','yyyy-mm-dd')),
    (102022, 'cust_102', 'CA', 6125,to_date('2022-01-01','yyyy-mm-dd')),
    (102023, 'cust_103', 'CA', 7145,to_date('2022-01-01','yyyy-mm-dd')),
    (102024, 'cust_104', 'TX', 1023,to_date('2022-01-01','yyyy-mm-dd')),
    (102025, 'cust_101', 'NY', 670,to_date('2022-01-03','yyyy-mm-dd')),
	(102026, 'cust_101', 'NY', 5235,to_date('2022-01-03','yyyy-mm-dd')),
    (102027, 'cust_102', 'CA', 61255,to_date('2022-01-04','yyyy-mm-dd')),
    (102028, 'cust_103', 'CA', 7345,to_date('2022-01-04','yyyy-mm-dd')),
    (102029, 'cust_104', 'TX', 1023,to_date('2022-01-05','yyyy-mm-dd')),
    (102030, 'cust_109', NULL, 1023,to_date('2022-01-05','yyyy-mm-dd')),
    (102031, 'cust_104',Null, 1023,to_date('2022-01-05','yyyy-mm-dd')),
    (102031, 'cust_107','TX', 4000,to_date('2022-01-05','yyyy-mm-dd')),
    (102031, 'cust_107','CA', 7000,to_date('2022-02-05','yyyy-mm-dd'));
	
	drop table cards_ingest.cust_dim_details;
	
	create table cards_ingest.cust_dim_details (
    cust_id varchar(10),
    state_cd varchar(2),
    zip_cd varchar(5),
    cust_first_name  varchar(20),
    cust_last_name  varchar(20),
    start_date date,
    end_date date,
    active_flag varchar(1)
);

truncate table cards_ingest.cust_dim_details;

insert into cards_ingest.cust_dim_details
(cust_id,state_cd,zip_cd , cust_first_name, cust_last_name, start_date,end_date,active_flag)
VALUES
('cust_101','NY','08922', 'Mike', 'doge',to_date('2022-01-01','yyy-mm-dd'),to_date('2029-01-01','yyy-mm-dd'),'Y'),
('cust_102','CA','04922', 'sean', 'lan',to_date('2022-01-01','yyy-mm-dd'),to_date('2029-01-01','yyy-mm-dd'),'Y'),
('cust_103','CA','05922', 'sachin', 'ram',to_date('2022-01-01','yyy-mm-dd'),to_date('2029-01-01','yyy-mm-dd'),'Y'),
('cust_104','TX','08942', 'bill', 'kja',to_date('2022-01-01','yyy-mm-dd'),to_date('2029-01-01','yyy-mm-dd'),'Y'),
('cust_105','CA','08122', 'Douge', 'lilly',to_date('2022-01-01','yyy-mm-dd'),to_date('2029-01-01','yyy-mm-dd'),'Y'),
('cust_106','CA','08322', 'hence', 'crow',to_date('2022-01-01','yyy-mm-dd'),to_date('2029-01-01','yyy-mm-dd'),'Y'),
('cust_107','TX','08722', 'Mike', 'doge',to_date('2022-01-01','yyy-mm-dd'),to_date('2029-02-01','yyy-mm-dd'),'Y'),
('cust_107','NY','02122', 'Mike', 'doge',to_date('2022-02-03','yyy-mm-dd'),to_date('2022-01-01','yyy-mm-dd'),'N');



1.Give me all details from transaction tale and zip_cd from dimension table.
2. Sum of tran_ammt by zip_cd
3. Give me top 5 customer [ (first name+ last name) is customer] by tran_ammt [highest is first] join on cust_id
SELECT CONCAT(CD.cust_first_name, ' ', CD.cust_last_name) as customer,
SUM(TF.tran_ammt) as total
FROM cards_ingest.tran_fact TF
join cards_ingest.cust_dim_details CD on TF.cust_id = CD.CUST_ID
GROUP by customer
ORDER BY total DESC
LIMIT 5

4. Give me the all cols from tran_fact [ I don't need state_cd is null] first five records [ lower to highest]

