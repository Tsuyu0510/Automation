#!
#!/bin/bash
export SQOOP_HOME=/usr/local/sqoop-1.4.6
export HADOOP_HOME=/home/hadoop/hadoop-3.2.0
export HADOOP_HDFS_HOME=$HADOOP_HOME
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HBASE_HOME/bin:$SQOOP_HOME/bin
## oracle -> hdfs 

#sqoop job --create ora2hdfsjob_loadtime_store_merge_2 -- import --map-column-java UPDATE_TIME=java.sql.Timestamp,LOAD_TIME=java.sql.Timestamp --connect jdbc:oracle:thin:@ip:sid --username ******* --password-file /sqoop/pwd/sqoopPWD.pwd --query "SELECT CONCAT(CONCAT(CONCAT(PARENTID,ESHOPID),PER_TRNO),MANAGECODE) AS TOTAL_KEY,PARENTID,ESHOPID,PER_TRNO,MANAGECODE,USER_ID,UPDATE_TIME,FOC_SHIPPINGCODE,ORDERNO,CHK_NO,REV_STNO,ORDERNM,ORDERTEL,ECSUPPLIERNAME,ITEM,ORDER_QTY,STATUS,ACCEPT_QTY,FREE,ITEM_ACCOUNT,SHIPMENTAMOUNT,TMSHIPPINGFEE,FOC_HASTMSHIPPINGFEE,DCMS_HASTMSHIPPINGFEE,CAR_NO,ROUTE,STEP,DIS_NO,PACKAGE,CHAN_NO,SERVICETYPE,PRODNM,DISTYPE,TDC_ARRIVE_DATE,OLD_TDC_ARRIVE_DATE,PLAN_RETURN_DATE,O_DATE,A_DATE,CATEGORY_NO,FOC_PAYBARCODE1,FOC_PAYBARCODE2,FOC_LOGIBARCODE,DCMS_PAYBARCODE1,DCMS_PAYBARCODE2,DCMS_LOGIBARCODE,ORD_STATUS,FOC_BATCH_ID,LOAD_TIME,RE51_LOCK_SEQ,RE51_DCMS_BATCHID,RE52_LOCK_SEQ,RE52_DCMS_BATCHID,FINISH_TIME,PACKDONE_BATCHID,DCMS_PACK_DC,DCMS_DISTR_DC,DCMS_REFUND_DC,DCMS_PACKBOX_TYPE,RE51_HQ_BATCHID,KAPS_PACK_SEQ,RE51_EXCH_BATCHID FROM DCMS.EC_O2OAPI_ORDERSOURCE WHERE LOAD_TIME>TO_DATE('2022-10-03 00:00:00','yyyy-mm-dd hh24:mi:ss') and \$CONDITIONS" --target-dir /user/hadoop/oracle_test/oracle_store_updatetime_store --incremental lastmodified --merge-key TOTAL_KEY --check-column 'LOAD_TIME' --last-value '2022-12-06 12:00:00' -m 1
#sqoop job --create ora2hdfsjob_loadtime_merge_ut -- import --map-column-java UPDATE_TIME=java.sql.Timestamp,LOAD_TIME=java.sql.Timestamp,FINISH_TIME=java.sql.Timestamp --connect jdbc:oracle:thin:@ip:sid --username ******* --password-file /sqoop/pwd/sqoopPWD.pwd --query "SELECT CONCAT(CONCAT(CONCAT(PARENTID,ESHOPID),PER_TRNO),MANAGECODE) AS TOTAL_KEY,PARENTID,ESHOPID,PER_TRNO,MANAGECODE,USER_ID,UPDATE_TIME,FOC_SHIPPINGCODE,ORDERNO,CHK_NO,REV_STNO,ORDERNM,ORDERTEL,ECSUPPLIERNAME,ITEM,ORDER_QTY,STATUS,ACCEPT_QTY,FREE,ITEM_ACCOUNT,SHIPMENTAMOUNT,TMSHIPPINGFEE,FOC_HASTMSHIPPINGFEE,DCMS_HASTMSHIPPINGFEE,CAR_NO,ROUTE,STEP,DIS_NO,PACKAGE,CHAN_NO,SERVICETYPE,PRODNM,DISTYPE,TDC_ARRIVE_DATE,OLD_TDC_ARRIVE_DATE,PLAN_RETURN_DATE,O_DATE,A_DATE,CATEGORY_NO,FOC_PAYBARCODE1,FOC_PAYBARCODE2,FOC_LOGIBARCODE,DCMS_PAYBARCODE1,DCMS_PAYBARCODE2,DCMS_LOGIBARCODE,ORD_STATUS,FOC_BATCH_ID,LOAD_TIME,RE51_LOCK_SEQ,RE51_DCMS_BATCHID,RE52_LOCK_SEQ,RE52_DCMS_BATCHID,FINISH_TIME,PACKDONE_BATCHID,DCMS_PACK_DC,DCMS_DISTR_DC,DCMS_REFUND_DC,DCMS_PACKBOX_TYPE,RE51_HQ_BATCHID,KAPS_PACK_SEQ,RE51_EXCH_BATCHID FROM DCMS.EC_O2OAPI_ORDERSOURCE WHERE LOAD_TIME>TO_DATE('2022-10-03 00:00:00','yyyy-mm-dd hh24:mi:ss') and \$CONDITIONS" --target-dir /user/hadoop/oracle_test/test202211_7 --incremental lastmodified --merge-key TOTAL_KEY --check-column 'UPDATE_TIME' --last-value '2022-12-10 00:00:00' -m 1





sqoop job --exec ora2hdfsjob_loadtime_merge_ut

sleep 1m

sqoop job --exec 20230209_3job ## RFDB sqoop job 

sleep 1m

sqoop job --exec 20230215_YTjob ## YTDB sqoop job

sleep 1m

sqoop job --exec 20230216_RF_EC_ORDERWORK_ITEM_job ## RFDB sqoop job boxname

sleep 1m

sqoop job --exec 20230216_YT_EC_ORDERWORK_ITEM_job ## YTDB sqoop job boxname 



sqoop export --connect jdbc:mysql://ip:port/db02 --username ＊＊＊＊ --password ＊＊＊＊ --table o2o_table_likerealtime_2 --export-dir '/user/hadoop/oracle_test/test202211_7/*' --update-key PARENTID,ESHOPID,PER_TRNO,MANAGECODE --update-mode allowinsert  

sleep 1m

sqoop export --connect jdbc:mysql://ip:port/EC --username ＊＊＊＊ --password ＊＊＊＊ --table RF_volume --export-dir '/user/hadoop/sqlserver_test/20230209_3/*' --update-key DISTR_NO,LINE_NO,DCMS_BATCH_ID,PER_TRNO --update-mode allowinsert

sleep 1m

sqoop export --connect jdbc:mysql://ip:port/EC --username ＊＊＊＊ --password ＊＊＊＊ --table YT_volume --export-dir '/user/hadoop/sqlserver_test/20230215_YT/*' --update-key DISTR_NO,LINE_NO,DCMS_BATCH_ID,PER_TRNO --update-mode allowinsert

sleep 1m

sqoop export --connect jdbc:mysql://ip:port/EC --username ＊＊＊＊ --password ＊＊＊＊ --table  RF_EC_ORDERWORK_ITEM_TDC --export-dir '/user/hadoop/sqlserver_test/RF_20230216_EC_ORDERWORK_ITEM_TDC/*' --update-key PER_TRNO,MANAGECODE --update-mode allowinsert

sleep 1m

sqoop export --connect jdbc:mysql://ip:port/EC --username ＊＊＊＊ --password Tdc202106 --＊＊＊＊  YT_EC_ORDERWORK_ITEM_TDC --export-dir '/user/hadoop/sqlserver_test/YT_20230216_EC_ORDERWORK_ITEM_TDC/*' --update-key PER_TRNO,MANAGECODE --update-mode allowinsert


#####END########



