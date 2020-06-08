%version1 Main
X=60000;
[images, labels]= readMNIST("train-images.idx3-ubyte","train-labels.idx1-ubyte",X,0);
z = zeros(X,289);
for i = 1:X
    im=images(:,:,i);
    imBW=imbinarize(im);
    z(i,:) = [HOG(imBW), labels(i)];
end
trainFeatures = z(1:48000,:);
testFeatures = z(48001:60000,1:288);
testLabels = labels(48001:60000);
[classifier, valacc] = trainClassifier(trainFeatures);
predictionLabels = classifier.predictFcn(testFeatures);
confMat = confusionmat(testLabels, predictionLabels);
confusionchart(confMat,[0:1:9],'ColumnSummary','column-normalized','RowSummary','row-normalized');
acc = 0;
for i=1:10
acc=acc+confMat(i,i);
end
acc/(120)
error = find(predictionLabels~=testLabels);
s = size(error,1);
errorLabeled = cell(s,3);
for i=1:s
    t = error(i);
    errorLabeled{i,1} = images(:,:,48000+t);
    errorLabeled{i,2} = testLabels(t);
    errorLabeled{i,3} = predictionLabels(t);
end
for i=1:s
    subplot(9,14,i);
    imshow(errorLabeled{i,1}),title("T: " + errorLabeled{i,2} + " G: " + errorLabeled{i,3});
end
sgtitle("Errors, T: True Label, G: Classifier Guess")