/*
//oracle image: 
https://registry.hub.docker.com/u/alexeiled/docker-oracle-xe-11g/

//Log into the container from the command line without ssh
PID=$(docker inspect --format {{.State.Pid}} CONTAINER_NAME_OR_ID) sudo nsenter --target $PID --mount --uts --ipc --net --pid

//Useful queries
select * from v$instance;
select tablespace_name, table_name from user_tables;
select tablespace_name, table_name from dba_tables;
select distinct owner from all_tables;
select tablespace_name, table_name from user_tables where UPPER(table_name) like 'MY%';
show user
conn THE_USER_NAME
*/




/*
Drop all the tables in the right order in case it necessary during the tests
DROP TABLE mythirdtb PURGE;
DROP TABLE mysecondtb PURGE;
DROP TABLE myfirsttb PURGE;
*/


DROP TABLE myfirsttb PURGE;
CREATE TABLE myfirsttb (
         myid      NUMBER(5) PRIMARY KEY,
         myname    VARCHAR2(25) NOT NULL,
         myint     NUMBER(9),
         mydate    DATE DEFAULT (sysdate),
         myfile    BLOB,
         myfloat   NUMBER(7,2)
         );
COMMENT ON TABLE myfirsttb IS 'My first table';

DROP TABLE mysecondtb PURGE;
CREATE TABLE mysecondtb (
         myid         NUMBER(5) PRIMARY KEY,
         myname       VARCHAR2(25) NOT NULL,
         myfirsttb_id NUMBER(5) CONSTRAINT mysecondtb_myfirsttb_fkey REFERENCES myfirsttb(myid)
         );
COMMENT ON TABLE mysecondtb IS 'My second table';

DROP TABLE mythirdtb PURGE;
CREATE TABLE mythirdtb (
         myid         NUMBER(5) PRIMARY KEY,
         myname       VARCHAR2(25) NOT NULL,
         myfirsttb_id NUMBER(5) CONSTRAINT mythirdtb_myfirsttb_fkey REFERENCES myfirsttb(myid)
         );
COMMENT ON TABLE mythirdtb IS 'My third table';



INSERT INTO myfirsttb (myid,myname,myint,mydate,myfile,myfloat) select rownum, '1 is #'||rownum, ROUND(rownum+rownum/2,0),sysdate -rownum +1 ,hextoraw('453d7a34'), rownum+rownum/3 from dual connect by rownum<=100;


INSERT INTO mysecondtb (myid,myname,myint,mydate,myfile,myfloat) select rownum, '2 is #'||rownum, rownum from dual connect by rownum<=100;


INSERT INTO mysecondtb (myid,myname,myint,mydate,myfile,myfloat) select rownum, '3 is #'||rownum, rownum from dual connect by rownum<=100;



quit;
/



