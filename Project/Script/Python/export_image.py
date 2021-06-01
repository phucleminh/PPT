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


X_train = X_train[np.isin(y_train, [0,1]).flatten()]
y_train = y_train[np.isin(y_train, [0,1]).flatten()]
X_test = X_test[np.isin(y_test, [0,1]).flatten()]
y_test = y_test[np.isin(y_test, [0,1]).flatten()]


X_train = X_train[-10000:]
X_test = X_test[-60000:]

y_train = y_train[-10000:]
y_test = y_test[-60000:]
y_train = to_categorical(y_train)
y_test = to_categorical(y_test)
print(y_train.shape)
none , x , y , z = X_train.shape
print(y_test[0,:])
#abc = X_test[0,:,:]
#plt.imshow(abc, vmin=0, vmax=255)
#plt.show()
index = 0
number_image = 0
for index in range (3):
    with open('image{0}.txt'.format(index),'w') as f:
         for j in range (x):
            for k in range (y):
                 f.write(str(X_train[number_image][j][k][index]))
                 f.write('\n')
    f.close