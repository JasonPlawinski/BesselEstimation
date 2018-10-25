close all;
% Estimation of 2D probability density

Im=imread('sand2.jpg');
Ig=double(rgb2gray(Im));
h=fspecial('log');
iH=imfilter(Ig,h);
S=size(iH);
Limage=S(1);
limage=S(2);

LenHist=(4*Limage*limage-(limage+Limage)-4)/2;
BinList=zeros(LenHist,2);
ind=1;
for i=1:Limage
    for j=1:limage-1
        BinList(ind,1)=iH(i,j);
        BinList(ind,2)=iH(i,j+1);
        ind=ind+1;
    end
end

for i=1:limage
    for j=1:Limage-1
        BinList(ind,1)=iH(j,i);
        BinList(ind,2)=iH(j+1,i);
        ind=ind+1;
    end
end
BinList2= [BinList(:,2) BinList(:,1)];
size(BinList);
size(BinList2);
BinListPerm=[BinList; BinList2];
size(BinListPerm);
figure()
hist3(BinListPerm,[40 40])
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');

figure()
hist3(BinListPerm,[25 25])
set(gca,'ZScale','log')
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');

Sigma=cov(BinListPerm)
figure()
mu = [0 0];
% Sigma = [.25 .3; .3 1];
x1 = -600:20:600; x2 = -600:20:600;
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mu,Sigma);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([-600 600 -600 600 0 .000015])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');

% X=BinListPerm(:,1)
% Y=BinListPerm(:,2)
% L=length(X);
% StdX=std(X);
% StdY=std(Y);
% mu02=var(Y);
% mu11=Sigma(2,1);
% mu20=var(X);
% mu40=kurtosis(X);
% mu31=sum(Y.*X.^3)/(L*StdY*StdX^3);
% mu13=sum(X.*Y.^3)/(L*StdX*StdY^3);
% mu22=sum(X.^2*Y.^2)/(L*StdX^2*StdY^2);
% mu04=kurtosis(Y);






