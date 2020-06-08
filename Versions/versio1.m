X=12000;
[imTrain, labs]= readMNIST("train-images.idx3-ubyte","train-labels.idx1-ubyte",X,48000);
F = zeros(X,288);
for i = 1:X
    im=imbinarize(imTrain(:,:,i));
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
error = find(yfit~=labs);
s = size(error,1);
errorLabeled = cell(s,3);
for i=1:s
    t = error(i);
    errorLabeled{i,1} = imTrain(:,:,t);
    errorLabeled{i,2} = labs(t);
    errorLabeled{i,3} = yfit(t);
end
for i=1:s
    subplot(9,14,i);
    imshow(errorLabeled{i,1}),title("T: " + errorLabeled{i,2} + " G: " + errorLabeled{i,3});
end
sgtitle("Errors, T: True Label, G: Classifier Guess")