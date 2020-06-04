function z = pixels(im)
    a = sum(im,1);
    b = sum(im,2)';
    z = [a, b];
end