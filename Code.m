clc;
clear all;
close all;
imagefiles = dir('*.jpg'); 
nfiles = length(imagefiles); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   img=im2double(currentimage);
   
if length(size(img))==3
    img=rgb2gray(img);
end

im=imnoise(img,'gaussian',0,0.05);

[m,n]=size(im);f=im+0.0001;z=log(f);
z=fftshift(fft2(z));v1=m;v2=n;v=15;
h=mat2gray(fspecial('gaussian',[v1 v2],v));
ref=z.*(1-h);lum=z.*h;
reflect=exp(ifft2(ifftshift(ref)));
lum=exp(ifft2(ifftshift(lum)));
ifftt=abs(reflect);ref=ifftt;
ifftt2=abs(lum);iiiu=ifftt2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
new1=wiener2(ref,[3,3]);
new2=wiener2(iiiu,[3,3]);
re=new2.*new1;

win=wiener2(im,[3,3]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w=img-win;
ww=img-re;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(ii)
% % subplot(221);imshow(mat2gray(img));title('orginalImage');
% %  subplot(222);imshow(mat2gray(im));title('noisyImage0.005');
 subplot(121);imshow(mat2gray(w));title('wiener');
  subplot(122);imshow(mat2gray(ww));title('improvedWinener');

end