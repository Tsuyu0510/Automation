#!
#!/bin/bash
export SQOOP_HOME=/usr/local/sqoop-1.4.6
export HADOOP_HOME=/home/hadoop/hadoop-3.2.0
export HADOOP_HDFS_HOME=$HADOOP_HOME
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HBASE_HOME/bin:$SQOOP_HOME/bin



sqoop job --exec ora2hdfsjob_loadtime_merge_ut

sleep 1m

sqoop job --exec 20230209_3job ## RFDB sqoop job 

sleep 1m

sqoop job --exec 20230215_YTjob ## YTDB sqoop job

sleep 1m

sqoop job --exec 20230216_RF_EC_ORDERWORK_ITEM_job ## RFDB sqoop job boxname

sleep 1m

sqoop job --exec 20230216_YT_EC_ORDERWORK_ITEM_job ## YTDB sqoop job boxname 



sqoop export --connect jdbc:mysql://172.17.11.76:3306/db02 --username root --password Tdc202106 --table o2o_table_likerealtime_2 --export-dir '/user/hadoop/oracle_test/test202211_7/*' --update-key PARENTID,ESHOPID,PER_TRNO,MANAGECODE --update-mode allowinsert  

sleep 1m

sqoop export --connect jdbc:mysql://172.17.11.76:3306/EC --username root --password Tdc202106 --table RF_volume --export-dir '/user/hadoop/sqlserver_test/20230209_3/*' --update-key DISTR_NO,LINE_NO,DCMS_BATCH_ID,PER_TRNO --update-mode allowinsert

sleep 1m

sqoop export --connect jdbc:mysql://172.17.11.76:3306/EC --username root --password Tdc202106 --table YT_volume --export-dir '/user/hadoop/sqlserver_test/20230215_YT/*' --update-key DISTR_NO,LINE_NO,DCMS_BATCH_ID,PER_TRNO --update-mode allowinsert

sleep 1m

sqoop export --connect jdbc:mysql://172.17.11.76:3306/EC --username root --password Tdc202106 --table  RF_EC_ORDERWORK_ITEM_TDC --export-dir '/user/hadoop/sqlserver_test/RF_20230216_EC_ORDERWORK_ITEM_TDC/*' --update-key PER_TRNO,MANAGECODE --update-mode allowinsert

sleep 1m

sqoop export --connect jdbc:mysql://172.17.11.76:3306/EC --username root --password Tdc202106 --table  YT_EC_ORDERWORK_ITEM_TDC --export-dir '/user/hadoop/sqlserver_test/YT_20230216_EC_ORDERWORK_ITEM_TDC/*' --update-key PER_TRNO,MANAGECODE --update-mode allowinsert


#####END########



