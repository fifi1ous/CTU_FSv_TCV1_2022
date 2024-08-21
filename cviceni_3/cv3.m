clc; clear; format long G

data=load('data.txt');
%%
s=sqrt(sum(data.^2)/(size(data,2)-1));
sirka=0.5*s;
sirka=round(sirka,2);

%%
int=ones(1,11);
k=-5;
for n=1:11
    int(1,n)=k*sirka;
    k=k+1;
end
%%
stred=int+sirka/2;
stred(end)=[];
rj=hist(data,stred);
%%
INT=-2.5:0.5:2.5;
INT(1)=-2.78;
INT(end)=2.78;
for n=1:10
    P(n)=normcdf(INT(n+1))-normcdf(INT(n));
end
Rj=P.*length(data);
%%
for n=1:10
    roz2(n)=((rj(n)-Rj(n))^2)/Rj(n);
    ROZ(n)=(rj(n)-Rj(n));
end
X=sum(roz2);
K=chi2inv(0.950,7);
%%
figure
histogram(data,int)