I = imread('camera.jpg');
subplot(1,3,1);
imshow(I);
title('Original image');

PSF = fspecial('motion',13,45);
Blurred = imfilter(I,PSF,'circ','conv');

subplot(1,3,2);
imshow(n);
title('blurred image');

INITPSF = ones(size(PSF));
[J P] = deconvblind(Blurred,INITPSF,50);

%weight
WEIGHT = edge(I,'sobel',.28);
se1 = strel('disk',1);
se2 = strel('line',13,45);
WEIGHT = ~imdilate(WEIGHT,[se1 se2]);
WEIGHT = padarray(WEIGHT(2:end-1,2:end-1),[1 1]);

P1 = P;
P1(find(P1 < 0.01))= 0;
[J2 P2] = deconvblind(Blurred,P1,50,[],double(WEIGHT));
subplot(1,3,3);
imshow(J2)
% title('restore image');
% figure, imshow(J2)
title('Newly Deblurred Image');



