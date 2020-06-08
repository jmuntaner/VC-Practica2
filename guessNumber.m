function number = guessNumber(im)
    T = load('.\Classifiers\versio1_0def_model.mat', 'trainedClassifier');
    imBW = imbinarize(im);
    number = T.trainedClassifier.predictFcn(HOG(imBW));
end