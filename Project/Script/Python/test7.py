import keras
from keras.models import Sequential
from keras.layers import Dense, Conv2D, Flatten, MaxPooling2D
from keras.utils import to_categorical
from keras.datasets import cifar10
from keras.models import load_model
import cv2
import sys
import numpy as np
from keras import backend as K
from torch import Tensor
import torch

import matplotlib.pyplot as plt


(X_test, y_test), (X_train, y_train) = cifar10.load_data()
X_train = X_train.reshape(X_train.shape[0],32,32,3)
X_test = X_test.reshape(X_test.shape[0],32,32,3)


X_train = (0.21 * X_train[:,:,:,0]) + (0.72 * X_train[:,:,:,1]) + (0.07 * X_train[:,:,:,2])
X_test = (0.21 * X_test[:,:,:,0]) + (0.72 * X_test[:,:,:,1]) + (0.07 * X_test[:,:,:,2])
X_train = X_train.reshape(X_train.shape[0],32,32,1)
X_test = X_test.reshape(X_test.shape[0],32,32,1)

print(X_train.shape)
print(X_test.shape)

X_train = X_train[-10000:]
X_test = X_test[-60000:]
#abc = X_train[1,:,:]
y_train = y_train[-10000:]
y_test = y_test[-60000:]
#plt.imshow(abc,cmap= 'gray', vmin=0, vmax=255)
#plt.show()
y_train = to_categorical(y_train)
y_test = to_categorical(y_test)

conv = torch.nn.Conv2d(in_channels=1, out_channels=1, kernel_size=3)
conv.weight.shape
print(torch.nn.init._calculate_fan_in_and_fan_out(conv.weight))

model = Sequential()
model.add(Conv2D(32, kernel_size=3, use_bias = False, input_shape=(32,32,1))) #30x30x32
model.add(Conv2D(32, kernel_size = 3, use_bias = False, activation = 'relu'))  #28x28x32
model.add(MaxPooling2D(pool_size = (2, 2), strides = (2, 2), padding = 'valid')) #14x14x32
model.add(Conv2D(64, kernel_size=3, use_bias = False)) #12x12x64
model.add(Conv2D(64, kernel_size = 3, use_bias = False, activation = 'relu'))  #10x10x64
model.add(MaxPooling2D(pool_size = (2, 2), strides = (2, 2), padding = 'valid')) #5x5x64
model.add(Conv2D(128, kernel_size=3, use_bias = False)) #3x3x128
model.add(Conv2D(128, kernel_size = 3, use_bias = False, activation = 'relu'))  #1x1x128
model.add(Flatten())    #128
model.add(Dense(120, activation = 'relu', use_bias = False))
model.add(Dense(80, activation = 'relu', use_bias = False))
model.add(Dense(40, activation = 'relu', use_bias = False))
model.add(Dense(10, activation = 'softmax', use_bias = False))
model.compile(optimizer = 'Adam', loss='categorical_crossentropy', metrics=['accuracy'], )
#print(K.eval(model.optimizer.lr))
#print(K.eval(model.optimizer.beta_1))
K.set_value(model.optimizer.learning_rate, 0.001)
#K.set_value(model.optimizer.momentum, 0.9)
#print(K.eval(model.optimizer.lr))
model.fit(X_train, y_train, validation_data=(X_test, y_test), epochs = 20)
# model_json = model.to_json()  
# with open("model.json", "w") as json_file:
#     json_file.write(model_json)
model.save("model.h5")