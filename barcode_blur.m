%%% remove blur from picture
clear all
close all

feature('SetPrecision', 24)

% img=imread('tmp583977.png');
% gray=rgb2gray(img);
% gray_sharp=gray(44:374,30:568);
% gray_blured=gray(50:380,621:1159);
% clear gray; clear img;
% 
% mag_spect=abs(fft2(gray_blured));
% cepstrum=ifft2( log( 1+ mag_spect  )  );

% subplot(2,2,1)
% imshow(gray_blured)
% subplot(2,2,3)
% imshow(mag_spect)
% subplot(2,2,4)
% imshow(cepstrum)
% figure
img=imread('barcode.png');
img=img(10:end,10:end,:);
gray=rgb2gray(img);

h2d=hamming(size(gray,1))*hamming(size(gray,2))';
spect=fft2(double(gray).*h2d,size(gray,1),size(gray,2));
spect=round(spect*1000000)/1000000;
spect=spect./((size(spect,1)*size(spect,2)));
cepstrum=real(fft2(log(abs(spect).^2)));
cepstrum=cepstrum./((size(cepstrum,1)*size(cepstrum,2)));

c0v=cepstrum(1,:);
R=0;

for r=2:length(c0v)
    if(c0v(r)<0)
        R=r/2;
        break;
    end
end
R



subplot(2,2,1)
imshow(gray)
%subplot(2,2,2)

subplot(2,2,3)
imshow(fftshift(abs(spect)))
subplot(2,2,4)
imshow(fftshift(cepstrum))