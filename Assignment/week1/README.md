Assignment Week 1

- Setup Environment
  + Create Github repo
  + Install Ubuntu 
  + Install Python and Opencv
- Read, write and display video from webcam using opencv
# 1. Setup Environment
## Create Github repo
* [Github repo](https://github.com/phucleminh/PPT)
## Install Ubuntu
Group choose Ubuntu 18.04 and install on a virtual machine.
* [Ubuntu](https://releases.ubuntu.com/18.04/)
## Install Python and Opencv
#### Install Python
 Python 3.6.9 preinstalled within Ubuntu
#### Install opencv
 pip3 install python3-opencv

 
# 2. Read, write, display video from webcam using opencv (script.py)
```
import cv2

capture = cv2.VideoCapture(0)

fourcc = cv2.VideoWriter_fourcc('X','V','I','D')
videoWriter = cv2.VideoWriter('output.avi', fourcc, 10.0, (640,480))

while (True):

    ret, frame = capture.read()

    if ret:
        cv2.imshow('video', frame)
        videoWriter.write(frame)

    if cv2.waitKey(1) == 27:
        break

capture.release()
videoWriter.release()

cv2.destroyAllWindows()
```
RESULT
* [Result](https://github.com/phucleminh/PPT/edit/main/Assignment/week1/output.gif)
