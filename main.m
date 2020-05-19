X=48000;
[imTrain, labsTrain]= readMNIST("train-images.idx3-ubyte","train-labels.idx1-ubyte",X,0);
Ftrain = zeros(X,288);
for i = 1:X
    im=imbinarize(imTrain(:,:,i));
    %e = bweuler(im);
    Ftrain(i,:) = HOG(im);
end
classifier = fitcecoc(Ftrain, labsTrain);

X = 12000;
[imTest, labsTest]= readMNIST("train-images.idx3-ubyte","train-labels.idx1-ubyte",X,48000);
testF = zeros(X,288);
for i = 1:X
    im=imbinarize(imTest(:,:,i));
    %e = bweuler(im);
    testF(i,:) = HOG(im);
end
predictedLabels = predict(classifier, testF);
confMat = confusionmat(labsTest, predictedLabels);
confusionchart(confMat,[0:1:9],'ColumnSummary','column-normalized','RowSummary','row-normalized');
acc = 0;
for i=1:10
acc=acc+confMat(i,i);
end
acc/120
