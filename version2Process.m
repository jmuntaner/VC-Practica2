%version2 Main
X=60000;
[images, labels]= readMNIST("train-images.idx3-ubyte","train-labels.idx1-ubyte",X,0);
z = zeros(X,83);
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
    z(i,:) = [sh, (numRegions-bweuler(imCL)), pixels(im), sideEntries(imBW), labels(i)];
end
trainFeatures = z(1:48000,:);
testFeatures = z(48001:60000,1:82);
testLabels = labels(48001:60000);
[classifier, valacc] = trainClassifierversion2_01(trainFeatures);
predictionLabels = classifier.predictFcn(testFeatures);
confMat = confusionmat(testLabels, predictionLabels);
confusionchart(confMat,[0:1:9],'ColumnSummary','column-normalized','RowSummary','row-normalized');
acc = 0;
for i=1:10
acc=acc+confMat(i,i);
end
acc/(120)