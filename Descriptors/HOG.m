function z = HOG(im)
    z = extractHOGFeatures(im,'CellSize',[5 5],'UseSignedOrientation',true,'NumBins',8);
end