%barcode rotation
clear all
close all
padding=100;
img=imread('barcode.png');
img=img(10:end,10:end,:);
h2d=hamming(size(img,1))*hamming(size(img,2))';
gray=rgb2gray(img);
spect=fft2(double(gray).*h2d,size(gray,1),size(gray,2));
spect=spect./(size(spect,1)*size(spect,2));
shifted=fftshift(abs(spect));
imshow(shifted)
%% TODO: detect rotation
