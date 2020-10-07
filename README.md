# Face Detection Machine Learning

## Background
This project was an assignment for a 4rth year Computer Vision course. The objective of the assignment revolves around training a machine to detect faces given a set of images.
  
## How does the project work?
The project works by first training an SVM using a set of collected possitive (faces) and negative (not faces) data. A sliding window face detector is used to check regions of every image and couple with the trained SVM as well as, non-maximum suppression, is able to make accurate face detections at multiple scales and lighting conditions with non-overlapping predictions.

## Screenshots:
  ![alt text](https://raw.githubusercontent.com/Kalp-S/faceDetectionML/master/result_screenshot.png "Result")
  
  
## Required Dependencies
- MATLAB 2020b
- Computer Vision Toolbox

Note: To run on your computer, simply execute "detect_class_faces.m" file
