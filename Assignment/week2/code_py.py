import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import binascii

#######################################################################
#Chuyen anh RGB sang Gray, sau do chuyen anh Gray sang hexa va luu lai duoi dang file #text
#Tiep theo dua file text qua cho RTL kiem tra
def rgb2gray(rgb):
#Ham chuyen RGB sang Gray = R*0.299 + G*0.587 + B*0.144
    return np.dot(rgb[...,:3], [0.2126, 0.7152, 0.0722]) 

img = mpimg.imread('test.png') #Doc anh luu vao bien img
gray = rgb2gray(img) # Ham rgb2gray cua thu vien matplot, ket qua luu vao bien gray

plt.imshow(gray, cmap = plt.get_cmap('gray')) #Ham output ra image gray

plt.savefig('output_py.png') #Luu anh Grayscale output thanh file .png

filename = 'output_py.png' #Lay anh Grayscale lam input de doc sang text

with open(filename, 'rb') as f:
    content = f.read() #Ham doc anh duoi dang binary

#Ham doc anh tu binary sang hex va luu lai vao file "hex_img.txt"
with open("hex_from_img.txt",'wb') as file_hex:
    file_hex.write(binascii.hexlify(content)) 
    file_hex.close()

with open('txt_to_img.png', 'wb') as image_file:
    image_file.write(content) #Ham chuyen tu hexa sang lai image

########################################################################
#Chuyen file ket qua text nhan tu RTL sang anh gray de so sanh voi anh ban dau
file2 = 'img_rtl_out.txt'
file2.strip()
file2.replace(' ', '')
file2.replace('\n', '')  #Doc file text ket qua tu RTL
data = binascii.a2b_hex(file2) #chuyen file text tu binary sang hexa

with open('image_from_rtl.png', 'w') as image_file:
    image_file2.write(data) #CHuyen file text thanh anh gray
    image_file2.close()
plt.show()
image_file2.show()