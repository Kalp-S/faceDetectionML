# Face Detection Machine Learning

## Background
This project was an assignment for a 4rth year Computer Vision course. The objective of the assignment revolves around training a machine to detect faces given a set of images.
  
## How does the project work?
The project works by first training an SVM using a set of collected images of faces. The trained SVM is then used to create a sliding window face detector, and coupled with non-maximum suppression is able to make fairly accurate detections with non-overlapping predictions and at various image scales.

## Screenshots:
  ![alt text](https://raw.githubusercontent.com/Kalp-S/faceDetectionML/master/result_screenshot.png "Result")
  
  
## Required Dependencies
- MATLAB 2020b
- Computer Vision Toolbox

Note: To run on your computer, simply execute "detect_class_faces.m" file
