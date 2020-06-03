%testMethod
X=12000;
[imTrain, labsTrain]= readMNIST("train-images.idx3-ubyte","train-labels.idx1-ubyte",X,48000);
z = zeros(X,83);
for i = 1:X
    im=imTrain(:,:,i);
    imBW=imbinarize(im);
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
    z(i,:) = [sh, bweuler(imBW), pixels(im), sideEntries(imBW), labsTrain(i)];
end