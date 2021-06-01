from keras.models import Sequential
from keras.layers import Dense, Conv2D, Flatten, MaxPooling2D
from keras.utils import to_categorical
from keras.datasets import mnist
from keras.models import load_model
import struct
from scipy import ndimage
import sys
import numpy as np
from keras import backend as K

def bin_to_float(b):
      """ Convert binary string to a float. """
      f = int(b, 2)  
      return struct.unpack('f', struct.pack('I', f))[0]
def float_to_bin(value):
	#return struct.unpack('Q', struct.pack('d', value))[0]
  #return np.binary_repr(value)
  return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', value))

# max_index_layers = 7
def main():
    kernel0 = np.zeros((3,3,1,2))
    kernel1 = np.zeros((3,3,2,2))
    kernel2 = np.zeros((3,3,2,5))
    kernel3 = np.zeros((3,3,5,5))
    kernel4 = np.zeros((3,3,5,10))
    kernel5 = np.zeros((3,3,10,10))
    kernel_index = 0
    kernel_bias = np.zeros(1)
    #weight1 = np.zeros((196,120))
    #weight2 = np.zeros((120,80))
    #weight1 = np.zeros((25,20))
    #weight2 = np.zeros((20,10))
    weight1 = np.zeros((10,2))
    bias = np.zeros(10)
    index = 1
    model_done = load_model("model.h5")
    model_done.summary()
    for layer in model_done.layers:
        weights = layer.get_weights() # list of numpy arrays
        for i in range(len(weights)):
            kernel_index = 0
            print('---------index '+str(index)+'------------')
            print(weights[i])
            np_weight = np.array(weights[i])
            print(np_weight.shape)
            if(index != 7):
                x , y , z , t = np_weight.shape
            print(np_weight.shape)
            for m in range (t):
                for n in range (z):
                    if(np_weight.shape == kernel0.shape):
                        #x , y , z , t = np_weight.shape
                        with open('kernel{0}.txt'.format(kernel_index),'w') as f:
                            for j in range (x):
                                for k in range (y):
                                    f.write(str(float_to_bin(np_weight[j][k][n][m])))
                                    f.write('\n')
                        f.close
                        kernel_index += 1
                    if(np_weight.shape == kernel1.shape):
                        #x , y , z , t = np_weight.shape
                        with open('kernel1{0}.txt'.format(kernel_index),'w') as f:
                            for j in range (x):
                                for k in range (y):
                                    f.write(str(float_to_bin(np_weight[j][k][n][m])))
                                    f.write('\n')
                        f.close
                        kernel_index += 1
                    if(np_weight.shape == kernel2.shape):
                        #x , y , z , t = np_weight.shape
                        with open('kernel2{0}.txt'.format(kernel_index),'w') as f:
                            for j in range (x):
                                for k in range (y):
                                    f.write(str(float_to_bin(np_weight[j][k][n][m])))
                                    f.write('\n')
                        f.close
                        kernel_index += 1
                    if(np_weight.shape == kernel3.shape):
                        #x , y , z , t = np_weight.shape
                        with open('kernel3{0}.txt'.format(kernel_index),'w') as f:
                            for j in range (x):
                                for k in range (y):
                                    f.write(str(float_to_bin(np_weight[j][k][n][m])))
                                    f.write('\n')
                        f.close
                        kernel_index += 1
                    if(np_weight.shape == kernel4.shape):
                        #x , y , z , t = np_weight.shape
                        with open('kernel4{0}.txt'.format(kernel_index),'w') as f:
                            for j in range (x):
                                for k in range (y):
                                    f.write(str(float_to_bin(np_weight[j][k][n][m])))
                                    f.write('\n')
                        f.close
                        kernel_index += 1
                    if(np_weight.shape == kernel5.shape):
                        #x , y , z , t = np_weight.shape
                        with open('kernel5{0}.txt'.format(kernel_index),'w') as f:
                            for j in range (x):
                                for k in range (y):
                                    f.write(str(float_to_bin(np_weight[j][k][n][m])))
                                    f.write('\n')
                        f.close
                        kernel_index += 1      
            if(np_weight.shape == weight1.shape):
                x , y = np_weight.shape
                for k in range (y):
                    with open('WH0_{0}.txt'.format(k),'w') as f:
                        for j in range (x):
                            f.write(str(float_to_bin(np_weight[j][k])))
                            f.write('\n')
                    f.close
            index += 1
if __name__ == '__main__':
    main()