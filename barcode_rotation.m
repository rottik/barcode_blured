%barcode rotation
clear all
close all
padding=100;
img=imread('barcode.png');
img=img(10:end,10:end,:);
gray=zeros(size(img,1)+padding,size(img,2)+padding,'uint8');
gray(padding/2:end-padding/2-1,padding/2:end-padding/2-1)=gray(padding/2:end-padding/2-1,padding/2:end-padding/2-1)+rgb2gray(img);
spect=fft2(gray,size(gray,1),size(gray,2));
spect=spect./(size(spect,1)*size(spect,2));

shifted=fftshift(abs(spect));
ss=floor(size(shifted)/2);

shifted(1+ss(1),:)=0;
shifted(:,1+ss(2))=0;

imshow(shifted)