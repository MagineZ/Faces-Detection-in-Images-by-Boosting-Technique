# STAT 231 Project II Detecting Faces in Images by Boosting Technique
Boosting is a general method for improving the accuracy of any given learning algorithm. One can use it to combine simple or weak classifiers, each performing only slightly better than random guess, to form a strong classifier. One successful example of the Boosting techniques was Face detection.

In this project, I implemented the Adaboost and RealBoost algorithms for frontal human face detection.

## Construction of weak classifiers
![Classifiers]()

About 100k weak classifiers were designed.
The first type is random two rectangles combination with one positive and one negative square.
The second type is two concatenated squares with different sign.
The third type is 3 square with two having the same sign and the other one having differnt sign.
Each filter can change differnt sizes, shape of rectangles, and have transverse or vertical directions.
The hitogram of filterd result of one weak classifer looks like following:

![Histogram_of_Weak_Classifiers]()

The filtered image values are calculated by image integral techniques.
Each weak classifier will tweak the threshold/decision boundary by the average of the 50th percentile filtered values of each face and nonface groups.

