X=60000;
[imTrain, labsTrain]= readMNIST("train-images.idx3-ubyte","train-labels.idx1-ubyte",X,0);
Ftrain = zeros(X,288);
for i = 1:X
    im=imbinarize(imTrain(:,:,i));
    %e = bweuler(im);
    Ftrain(i,:) = HOG(im);
end
classifier = fitcecoc(Ftrain, labsTrain);

X = 10000;
[imTest, labsTest]= readMNIST("t10k-images.idx3-ubyte","t10k-labels.idx1-ubyte",X,0);
testF = zeros(X,288);
for i = 1:X
    im=imbinarize(imTest(:,:,i));
    %e = bweuler(im);
    testF(i,:) = HOG(im);
end
predictedLabels = predict(classifier, testF);
confMat = confusionmat(labsTest, predictedLabels);
confusionchart(confMat);
acc = 0;
for i=1:10
acc=acc+confMat(i,i);
end
acc/100
