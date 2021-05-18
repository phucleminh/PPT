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
    kernel00 = np.zeros((3,3,1,32))
    kernel01 = np.zeros((3,3,1,32))
    kernel10 = np.zeros((3,3,1,64))
    kernel11 = np.zeros((3,3,1,64))
    kernel20 = np.zeros((3,3,1,128))
    kernel21 = np.zeros((3,3,1,128))
    kernel_index = 0
    kernel_bias = np.zeros(1)
    weight1 = np.zeros((128,120))
    weight2 = np.zeros((120,80))
    weight3 = np.zeros((80,40))
    weight4 = np.zeros((40,10))
    bias = np.zeros(10)
    index = 1
    model_done = load_model("model.h5")
    model_done.summary()
    for layer in model_done.layers:
        weights = layer.get_weights() # list of numpy arrays
        for i in range(len(weights)):
            print('---------index '+str(index)+'------------')
            print(weights[i])
            np_weight = np.array(weights[i])
            # if(np_weight.shape() )
            if(np_weight.shape == kernel00.shape):
                x , y , z , t = np_weight.shape
                with open('kernel0{0}.txt'.format(kernel_index),'w') as f:
                    for j in range (x):
                        for k in range (y):
                            f.write(str(float_to_bin(np_weight[j][k][0][0])))
                            f.write('\n')
                f.close
            if(np_weight.shape == kernel01.shape):
                x , y , z , t = np_weight.shape
                with open('kernel1{0}.txt'.format(kernel_index),'w') as f:
                    for j in range (x):
                        for k in range (y):
                            f.write(str(float_to_bin(np_weight[j][k][0][0])))
                            f.write('\n')
                f.close
            if(np_weight.shape == kernel10.shape):
                x , y , z , t = np_weight.shape
                with open('kernel2{0}.txt'.format(kernel_index),'w') as f:
                    for j in range (x):
                        for k in range (y):
                            f.write(str(float_to_bin(np_weight[j][k][0][0])))
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
            if(np_weight.shape == weight2.shape):
                x , y = np_weight.shape
                for k in range (y):
                    with open('WH1_{0}.txt'.format(k),'w') as f:
                        for j in range (x):
                            f.write(str(float_to_bin(np_weight[j][k])))
                            f.write('\n')
                    f.close
            if(np_weight.shape == weight3.shape):
                x , y = np_weight.shape
                for k in range (y):
                    with open('WH2_{0}.txt'.format(k),'w') as f:
                        for j in range (x):
                            f.write(str(float_to_bin(np_weight[j][k])))
                            f.write('\n')
                    f.close
            if(np_weight.shape == weight4.shape):
                x , y = np_weight.shape
                for k in range (y):
                    with open('WH3_{0}.txt'.format(k),'w') as f:
                        for j in range (x):
                            f.write(str(float_to_bin(np_weight[j][k])))
                            f.write('\n')
                    f.close
            index += 1
if __name__ == '__main__':
    main()