clc; clear; format long G
%% načítání dat
data=load('mreni.txt');
H51=234.3145;
sho=0.0030;
XI=[43;34;46;2;13;35;7];
%% váhy
sh=sho*sqrt((data(:,3)/1000));
s0=1;
PI=s0./(sh.^2);
P=eye(15).*PI;
%% matice l
for n=1:size(data,1)
    if data(n,1)==51
        l(n,1)=data(n,4)+H51;
    else
        l(n,1)=data(n,4);
    end
end
%% matice a
a=zeros(size(data,1),size(XI,1));
for m=1:size(data,1)
    for n=1:size(XI)
        if data(m,1)==51 && data(m,2)==XI(n)
            a(m,n)=1;
        elseif data(m,1)~=51
            if data(m,1)==XI(n)
                a(m,n)=-1;
            end
            if data(m,2)==XI(n)
                a(m,n)=1;
            end
        end
    end
end
%% x
x=((a'*P*a)^(-1))*a'*P*l;
%% v
v=a*x-l;
ll=l+v;

so=sqrt((v'*P*v)/(15-7));
N=a'*P*a;
Mx=s0^2*(N^(-1));
Ml=s0^2*a*(N^(-1))*a';
SML=sqrt(diag(Ml));
SMX=sqrt(diag(Mx));
