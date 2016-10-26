# STAT 231 Project II Detecting Faces in Images by Boosting Technique
Boosting is a general method for improving the accuracy of any given learning algorithm. One can use it to combine simple or weak classifiers, each performing only slightly better than random guess, to form a strong classifier. One successful example of the Boosting techniques was Face detection.

In this project, I implemented the Adaboost and RealBoost algorithms for frontal human face detection.

## Construction of weak classifiers
![Classifiers](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/classifiers.png)

About 100k weak classifiers were designed.
The first type is random two rectangles combination with one positive and one negative square.
The second type is two concatenated squares with different sign.
The third type is 3 square with two having the same sign and the other one having differnt sign.
Each filter can change differnt sizes, shape of rectangles, and have transverse or vertical directions.
The hitogram of filterd result of one weak classifer looks like following:

![Histogram_of_Weak_Classifiers](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/weak_classifier_histogram.png)

The filtered image values are calculated by image integral techniques.
Each weak classifier will tweak the threshold(decision boundary) by the average of the 50th percentile filtered values of each face and nonface groups.

## AdaBoosting
The Adaptive Boost algorithm was implemented, which can iterative select a weak classifier from the classifier source and then combine them into a weighted sum that represents the final strong classifier. The “adaptive“ way we chose a weak classifier is that, in each iteration we put more focus on data points which are misclassified in previous iteration, tweak the decision boundary between the face and non-face set for each classifier, and then select the classifier which has the highest accuracy into our building strong classifier.
The following is further explaination from course STAT231 by Professor Song-Chun Zhu.
![AdaBosst_1](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_1.png)
![AdaBosst_2](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_2.png)
![AdaBosst_3](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_3.png)
![AdaBosst_4](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_4.png)
![AdaBosst_5](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_5.png)
![AdaBosst_6](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_6.png)
![AdaBosst_7](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_7.png)
![AdaBosst_8](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_8.png)
![AdaBosst_9](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_9.png)
![AdaBosst_10](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_10.png)
![AdaBosst_11](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/ada_boost_11.png)

After implement the Adaboost algorithm to boost the weak classifiers, the first ten classifiers selected are:
![First_Ten_Claasifiers](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/First_Ten_Classifier.png)

The following is the curve of errors, at steps T=0, 10, 50, 100 respectively, of top 1000 weak
classifiers among the pool of weak classifiers in increasing order.

![T_RUN](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/T_run.png)

With T increase, the error of weak classifiers in pool arises and approach to 0.5, because the
Adaboost algorithm put more weight on missclassified samples.

The Adaboost histograms of the positive and negative populations over the F(x) axis and the three
corresponding ROC curves for T=10,50,100.

![T_10](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/T_10.png)
![T_50](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/T_50.png)
![T_100](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/T_100.png)

As T increase, the result final filter F(x) can better seperate positive and negative population. And
the corner of the ROC curve move to left top more.

##Test images
At the end, the final filter derived from T100 adaboost and one image taken at the class was tested.

![Test_image](https://github.com/MagineZ/Faces-Detection-in-Images-by-Boosting-Technique/blob/master/pictures/Test_image.png)

