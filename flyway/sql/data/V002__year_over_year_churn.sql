--psql -h localhost -p XXX -U username db_name "\copy(select * from where id in( 1) ) to 'churn.csv' delimiter ';' csv header;"
