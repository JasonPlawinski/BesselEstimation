function dist=KLDiv(P,Q)
%  dist = KLDiv(P,Q) Kullback-Leibler divergence of two discrete probability
%  distributions
ind=find(Q~=0);
KL=abs(P(ind).*log2(P(ind)./Q(ind)));
dist=sum(KL);
end