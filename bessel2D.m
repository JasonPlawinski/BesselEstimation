function [ value ] = bessel2D( a1,a2,X,Y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
L=length(X);
StdX=std(X);
StdY=std(Y);
mu02=var(Y);
mu11=Sigma(2,1);
mu20=var(X);
mu40=kurtosis(X);
mu31=sum(Y.*X.^3)/(L*StdY*StdX^3);
mu13=sum(X.*Y.^3)/(L*StdX*StdY^3);
mu22=sum(X.^2*Y.^2)/(L*StdX^2*StdY^2);
mu04=kurtosis(Y);
muK=[mu04 mu13 mu22 mu31 mu40];
muV=[mu02 mu11 mu20];
K=0;
V=0;

for i=0:2
    V=V+muV(i+1)*nchoosek(2,i).*a1.^k.*a2.^2-k;
end

for i=0:4
    K=K+muK(i+1)*nchoosek(4,i).*a1.^k.*a2.^4-k;
end
K=K/(V^2);

p=3/(K-3);
c=V/p;

phi=(1/(1+0.5*c))^p;
exp(j(a))
end

