X=12000;
[imTrain, labs]= readMNIST("train-images.idx3-ubyte","train-labels.idx1-ubyte",X,48000);
F = zeros(X,288);
for i = 1:X
    im=imbinarize(imTrain(:,:,i));
    %e = bweuler(im);
    F(i,:) = HOG(im);
end
Z = [F, labs];
yfit = trainedClassifier.predictFcn(F)
confMat = confusionmat(labs, yfit);
confusionchart(confMat,[0:1:9],'ColumnSummary','column-normalized','RowSummary','row-normalized');
acc = 0;
for i=1:10
acc=acc+confMat(i,i);
end
acc/(X/100)