import numpy as np
import scipy.fftpack
import matplotlib.image as mpimg
import matplotlib.pyplot as plt

def rgb2grey(rgb):
    if len(rgb.shape) is 3:
        return np.dot(rgb[...,:3], [0.299, 0.587, 0.114])
    else:
        print('Current image is already in grayscale.')
        return rgb

filename="tmp583977.png"
img=mpimg.imread(filename)
width=520
height=320
img_sharp=img[50:50+height,30:30+width]
img_blur=img[55:55+height,620:620+width]

img_sharp=rgb2grey(img_sharp)
img_blur=rgb2grey(img_blur)

f = np.fft.fft2(img_sharp)
fshift = np.fft.fftshift(f)
magnitude_spectrum = 20*np.log(np.abs(fshift))
cepstrum=np.real(np.fft.ifft2(np.log(1+np.abs(fshift))))

f = np.fft.fft2(img_sharp)
fshift_sharp = np.fft.fftshift(f)
f = np.fft.fft2(img_blur)
fshift_blur = np.fft.fftshift(f)

cepstrum_blur=np.fft.ifft2(np.log(1+np.abs(fshift_blur)))
print(np.max(cepstrum_blur))


plt.subplot(231),plt.imshow(img_sharp, cmap = 'gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(232),plt.imshow(20*np.log(np.abs(fshift_sharp)), cmap = 'gray')
plt.title('Magnitude Spectrum'), plt.xticks([]), plt.yticks([])
plt.subplot(233),plt.imshow(np.real(np.fft.ifft2(np.log(1+np.abs(fshift_sharp)))), cmap = 'gray')
plt.title('Cepstrum'), plt.xticks([]), plt.yticks([])

plt.subplot(234),plt.imshow(img_blur, cmap = 'gray')
plt.title('Input Image'), plt.xticks([]), plt.yticks([])
plt.subplot(235),plt.imshow(20*np.log(np.abs(fshift_blur)), cmap = 'gray')
plt.title('Magnitude Spectrum'), plt.xticks([]), plt.yticks([])
plt.subplot(236),plt.imshow(np.real(np.fft.ifft2(np.log(1+np.abs(fshift_blur)))), cmap = 'gray')
plt.title('Cepstrum'), plt.xticks([]), plt.yticks([])
plt.show()
