% importation
I=imread('arbre1.jpg');
Ig=double(rgb2gray(I));
h=fspecial('log');
iH1=Ig;


% Bruitage
iH2=Ig + 25*randn(size(Ig));
iH2(find(iH2>255))=255;
iH2(find(iH2<0))=0;
iH3=Ig + 15*rand(size(Ig));
iH3(find(iH3>255))=255;
iH3(find(iH3<0))=0;

iH4=double(rgb2gray(imread('index.jpg')));
iH5=double(rgb2gray(imread('sand1.jpg')));
iH6=double(rgb2gray(imread('sand2.jpg')));
iH7=double(rgb2gray(imread('CorbeilleFruit.jpg')));
iH8=double(rgb2gray(imread('mosaic.jpg')));
iH9=double(rgb2gray(imread('grass.jpg')));
iH10=double(rgb2gray(imread('FaceHeat3.jpg')));
iH11=double(rgb2gray(imread('FaceHeat2.jpg')));
iH12=double(rgb2gray(imread('FaceHeat1.jpg')));

im{1}=iH1;
im{2}=iH2;
im{3}=iH3;
im{4}=iH4;
im{5}=iH5;
im{6}=iH6;
im{7}=iH7;
im{8}=iH8;
im{9}=iH9;
im{10}=iH10;
im{11}=iH11;
im{12}=iH12;

ConSize=max(size(im));
KlGauss=zeros(ConSize,1);
KlBessel=zeros(ConSize,1);

figure()
imshow(imread('arbre1.jpg'))
figure()
iH1=imfilter(iH1,h);
imshow(iH1,[])
figure()
v=var(iH1(:))
k=kurtosis(iH1(:));
p=3/(k-3);
c=v/p;
x=(-800:1:800);
G=(1/sqrt(2*pi*v))*exp(-(x.^2/(2*v)));
Fb=(1/(sqrt(pi)*gamma(p)*(2*c))^(0.5*p+0.25))*abs(besselk(p-0.5,sqrt(2/c)*abs(x))).*(abs(x).^(p-0.5));
fun = @(x)(1/(sqrt(pi)*gamma(p)*(2*c))^(0.5*p+0.25))*abs(besselk(p-0.5,sqrt(2/c)*abs(x))).*(abs(x).^(p-0.5));
normalisation1 = integral(fun,-inf,inf);
Fb=Fb/normalisation1;
histogram(iH1(:),100,'Normalization','pdf')
hold on;
plot(x,G,'r')
plot(x,Fb,'g')

figure()
histogram(iH1(:),100,'Normalization','pdf')
hold on;
grid on
plot(x,G,'r')
plot(x,Fb,'g')
set(gca,'YScale','log')

% 
pause
for i=1:max(ConSize)
iH=im{i};

figure(i)
subplot(2,2,1)
imshow(iH,[]);
iH=imfilter(iH,h);

    % Generation of bins
[heights, locations]=hist(iH(:),500);
width = locations(2)-locations(1);
heights = heights / (length(iH(:))*width);

% estimation of parameters
m=mean(iH(:));
v=var(iH(:));
k=kurtosis(iH(:));

p=3/(k-3);
c=v/p;

% Bessel estimation
x=locations;
% Z=sqrt(pi)*gamma(p)*(2*c)^(0.5*p+0.25);
% K=abs(besselk(p-0.5,sqrt(2/c)*abs(x)));

% Fb=(1/Z)*K.*(abs(x).^(p-0.5));

Fb=(1/(sqrt(pi)*gamma(p)*(2*c))^(0.5*p+0.25))*abs(besselk(p-0.5,sqrt(2/c)*abs(x))).*(abs(x).^(p-0.5));
% Gaussian estimation
G=(1/sqrt(2*pi*v))*exp(-(x.^2/(2*v)));

% test normalisation
fun = @(x)(1/(sqrt(pi)*gamma(p)*(2*c))^(0.5*p+0.25))*abs(besselk(p-0.5,sqrt(2/c)*abs(x))).*(abs(x).^(p-0.5));
% fun2 = @(x)(1/sqrt(2*pi*v))*exp(-(x.^2/(2*v)));
normalisation1 = integral(fun,-inf,inf);
% normalisation2 = integral(fun2,-inf,inf)
% fun = @(x)(normalisation1^-1/(sqrt(pi)*gamma(p)*(2*c))^(0.5*p+0.25))*abs(besselk(p-0.5,sqrt(2/c)*abs(x))).*(abs(x).^(p-0.5));
% normalisation3 = integral(fun,-inf,inf)

%graphing

Fb=Fb/normalisation1;
subplot(2,2,2)
imshow(iH,[])


subplot(2,2,3)
bar(locations,heights,'hist')
hold on
grid on;
plot(x,Fb,'r')
plot(x,G,'g')
hold off

subplot(2,2,4)
bar(locations,heights,'hist','BaseValue',10^-7);
set(gca,'YScale','log')
hold on

plot(x,Fb,'r')
plot(x,G,'g')
axis([-750 750 10^-6 1])
hold off
title(p)
grid on;

KlBessel(i)= KLDiv(Fb,heights);
KlGauss(i)=KLDiv(G,heights);

end



pause;
close all
figure(1)
plot(0:ConSize-1,KlBessel,'r')
hold on
plot(0:ConSize-1,KlGauss,'g')
