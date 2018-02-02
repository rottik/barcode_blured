%%% remove blur from picture
clear all
close all

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
padding=100;
img=imread('barcode.png');
img=img(10:end,10:end,:);
gray=zeros(size(img,1)+padding,size(img,2)+padding,'uint8');
gray(padding/2:end-padding/2-1,padding/2:end-padding/2-1)=gray(padding/2:end-padding/2-1,padding/2:end-padding/2-1)+rgb2gray(img);

h2d=hamming(size(gray,1))*hamming(size(gray,2))';
spect=fft2(double(gray).*h2d,size(gray,1),size(gray,2));
%spect=round(real(spect)*10000)/10000 + round(imag(spect)*10000)/10000;
cepstrum=fft2(log(abs(spect).^2));
spect=spect./(size(spect,1)*size(spect,2));
c0v=cepstrum(1,:);
R=0;

for r=1:length(c0v)
    if(c0v(r)<0)
        R=r/2;
        break;
    end
end

h=zeros(R*2,R*2);
for x=1:size(h,1)
    for y=1:size(h,2)
        X=(x-R/2);
        Y=(y-R/2);
        if(X*X+Y*Y<=R*R)
            h(x,y)=0.5*pi*R;
        end
    end
end

H=fft2(h);

subplot(2,2,1)
imshow(gray)
subplot(2,2,2)

subplot(2,2,3)
imshow(fftshift(abs(spect)))
subplot(2,2,4)
imshow(fftshift(cepstrum))