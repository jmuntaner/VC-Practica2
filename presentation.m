T = load('.\Classifiers\versio1_0def_model.mat', 'trainedClassifier');
N = 20;
imagesT = zeros(20,20,20);
zTest = zeros(N,288);
for i=1:N
    index = string(i);
    if(i<10)
        index = strcat("0",index);
    end
    filename = strcat('./Exemples/num1',index,'.png');
    imagesT(:,:,i) = imread(filename);
    im = imagesT(:,:,i);
    imBW = imbinarize(im);
    zTest(i,:) = HOG(imBW);
end
predictions = T.trainedClassifier.predictFcn(zTest);
for i = 1:N
    subplot(4,5,i);
    imshow(imagesT(:,:,i)),title("Guess: " + predictions(i));
end