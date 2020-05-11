function z = fourier(im)
    %figure,imshow(im);
    % binaritzem la imatge i la invertim
    bw = im;
    %figure, imshow(bw),title('Binaritzat')
    % Close
    se = strel('disk',5);
    cl = imclose(bw, se);
    %imshow(cl),title('close');
    % obtenim contorn de la imatge
    ero=imerode(cl,strel('disk',1));
    cont=xor(ero,cl);
    %figure,imshow(cont), title('contorns')
    % obtenim coordenades del contorn
    [fila, col] = find(cl,1); % Busquem el primer píxel
    B = bwtraceboundary(cl,[fila col],'E'); %direccio est a l'atzar
    [mida, ~]=size(B);
    B = resample(B,10,mida);
    B = round(B);
    %figure,imshow(aux),title ('contorns a partir de coordenades')
    % B conté les coordenades
    % Fourier
    mig=mean(B);
    B(:,1)=B(:,1)-mig(1);
    B(:,2)=B(:,2)-mig(2);
    % A complexes
    s= B(:,1) + 1i*B(:,2);
    % Vector dim parell
    [mida, ~]=size(B);
    if(mida/2~=round(mida/2))
        s(end+1,:)=s(end,:); %dupliquem l'ultim
        mida=mida+1;
    end
    z=fft(s);
    z=abs(z);
    %figure,plot(log(z)),title('fourier');
end