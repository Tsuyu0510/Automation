#!/bin/bash

#for loop sample code
## linux route

#./darknet detector test /home/learning03/new144_train/obj.data /home/learning03/new144_train/yolov4-tiny-myobj.cfg /home/learning03/new144_train/backup/yolov4-tiny-myobj_best.weights /home/learning03/new144_train/test5/1.jpg -dont_show -ext_output 
date
cd ~
cd darknet

for file in /home/learning03/detect_name_parser/sheetDetect_finish/*.jpg
#for file in /home/learning03/20211227train/20211130test/*.jpg
do
	./darknet detector test /home/learning03/20220720_yolo/obj.data /home/learning03/20220720_yolo/yolov4-tiny-myobj.cfg /home/learning03/20220720_yolo/backup/yolov4-tiny-myobj_best.weights $file -dont_show -ext_output > $file.txt
done 

cd /home/learning03/detect_name_parser/sheetDetect_finish
mv *.txt /home/learning03/detect_name_parser/darknetAuto_finish


cd ~
cd darknet

#/Users/chentsuyu/Desktop/SheetRecognizeProject/20210818_detection_data/$file.txt
 
for file in /home/learning03/detect_name_parser/sheetDetect_finish/*.jpg
do
	./darknet detector test /home/learning03/20211227train/obj.data /home/learning03/20220725_yolo/yolov4-tiny-myobj.cfg /home/learning03/20211227train/backup/yolov4-tiny-myobj_best.weights $file -dont_show -ext_output > $file.txt
done 

cd /home/learning03/detect_name_parser/sheetDetect_finish
mv *.txt /home/learning03/detect_name_parser/darknetAuto_finish_1 ## Second model txt result route 


cd ~
cd darknet

#/Users/chentsuyu/Desktop/SheetRecognizeProject/20210818_detection_data/$file.txt
 
for file in /home/learning03/detect_name_parser/sheetDetect_finish/*.jpg
do
	./darknet detector test /home/learning03/20211227train/obj.data /home/learning03/20220727_yolo/yolov4-tiny-myobj.cfg /home/learning03/20211227train/backup/yolov4-tiny-myobj_best.weights $file -dont_show -ext_output > $file.txt
done 

cd /home/learning03/detect_name_parser/sheetDetect_finish
mv *.txt /home/learning03/detect_name_parser/darknetAuto_finish_2 ## Second model txt result route 
