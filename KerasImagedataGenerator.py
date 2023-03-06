import tensorflow as tf
import keras
import shutil
import os
import tensorflow as tf
import keras
from keras.preprocessing.image import ImageDataGenerator,array_to_img,img_to_array,load_img
from keras.models import Sequential
from keras.layers import Convolution2D,MaxPooling2D
from keras.layers import Activation,Dropout,Flatten,Dense 
import numpy as np 

train_fail_datagen = ImageDataGenerator(
	#rescale = 1./255,
	rotation_range= 30,
	vertical_flip = True,
	width_shift_range = 0.2,
	height_shift_range = 0.1,
	horizontal_flip= True,
	shear_range = 0.5
	)
filepath = '/home/learning03/A5Data/Test/Fail'
##load image

for file in os.listdir(filepath):
	#img = Image.open(filepath+'/'+file)
	img = load_img(filepath+'/'+file)
	print (img.size)
	#img.show()

	x = img_to_array(img)
	x= x.reshape((1,)+x.shape)
	print (x)

	i=0
	for batch in train_fail_datagen.flow(x,batch_size = 2,save_to_dir = '/home/learning03/A5Data/Test/Fail',save_prefix = 'gen',save_format='jpg'):
		i+=1
		if i >3:
			break


