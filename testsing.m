tic
[idx, scores] = fscmrmr(trainFeatures(:,1:370),trainFeatures(:,371));
toc
tic 
[coeff,score,latent,tsquared,explained,mu] = pca(trainFeatures);
toc
tic
presentation
toc
tic
l = zeros(100,1);
for i=1:100
    i
    l(i) = guessNumber(images(:,:,i))
    labels(i)
end
toc

X=10000;
[images2, labels2]= readMNIST("t10k-images.idx3-ubyte","t10k-labels.idx1-ubyte",X,0);
z2 = zeros(X,371);
for i = 1:X
    im=images2(:,:,i);
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
    z2(i,:) = [sh, (numRegions-bweuler(imCL)), pixels(im), sideEntries(imBW), HOG(imBW), labels2(i)];
end