X=60000;
[images, labels]= readMNIST("train-images.idx3-ubyte","train-labels.idx1-ubyte",X,0);
z = zeros(X,371);
for i = 1:X
    im=images(:,:,i);
    imBW=imbinarize(im);
    ee = strel('disk',1);
    imCL = imclose(imBW,ee);
    [~, numRegions] = bwlabel(imCL);
    stats = regionprops(imBW,'Area','FilledArea');
    if(size(stats)>1)
        for j=1:size(stats)
            a = stats(j).FilledArea;
            b = stats(j).Area;
            sh = sh + a -b;
        end
    else
        a = stats.FilledArea;
        b = stats.Area;
        sh = a -b;
    end
    z(i,:) = [sh, (numRegions-bweuler(imCL)), pixels(im), sideEntries(imBW), HOG(imBW), labels(i)];
end
trainFeatures = z(1:48000,:);
testFeatures = z(48001:60000,1:370);
testLabels = labels(48001:60000);
tic
[classifier5, valacc] = trainTest(trainFeatures);
toc
tic
predictionLabels = classifier5.predictFcn(testFeatures);
confMat = confusionmat(testLabels, predictionLabels);
confusionchart(confMat,[0:1:9],'ColumnSummary','column-normalized','RowSummary','row-normalized');
acc = 0;
for i=1:10
acc=acc+confMat(i,i);
end
acc/(120)
toc
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
    subplot(9,11,i);
    imshow(errorLabeled{i,1}),title("T: " + errorLabeled{i,2} + " G: " + errorLabeled{i,3});
end
sgtitle("Errors, T: True Label, G: Classifier Guess")
