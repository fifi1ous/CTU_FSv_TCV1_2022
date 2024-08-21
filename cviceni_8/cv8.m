clc; clear; format long G

data=[1   +20.8137    1938
   2   -17.2628    1919
   3   -18.9566    2239
   4   +5.9446    1938
   5   +21.7462    1902
   6   -19.4350    2073
   7   +13.3603    2069
   8   +1.3337    2275
   9   +0.4590    2150
  10   +1.1406    1560
  11   -14.1167    1833
  12   +1.1010    1797
  13   +17.0082    1734];
sh0=0.001;
H100=234.3145;
H200=243.4531;
%% Matice vah
sh=sh0*sqrt(data(:,3)/1000);
p=eye(length(data)).*(1./(sh.^2));
%% Výpočet uzávěrů
u(1,1)=data(3,2)+data(4,2)+data(5,2)+data(6,2)+data(7,2)+data(8,2)-data(13,2)-data(12,2)-data(11,2);
u(2,1)=H200-H100-(data(1,2)+data(2,2)+data(11,2)+data(12,2)+data(13,2)+data(9,2)+data(10,2));
%% Matice měřnení
l=data(:,2);
%% Matice A
syms H1000 H2000 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11
prom={h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13};
for n=1:length(data)
At(1,n)=diff(h3+h4+h5+h6+h7+h8-h13-h12-h11,prom(n));
At(2,n)=diff(H2000-H1000-(h1+h2+h11+h12+h13+h9+h10),prom(n));
end
At=eval(At);
Ath=ones(11,13);
for n=1:size(Ath,2)
    Ath(1,n)=diff(H1000+h1,prom(n));
    Ath(2,n)=diff(H1000+h1+h2,prom(n));
    Ath(3,n)=diff(H1000+h1+h2+h3,prom(n));
    Ath(4,n)=diff(H1000+h1+h2+h3+h4,prom(n));
    Ath(5,n)=diff(H1000+h1+h2+h3+h4+h5,prom(n));
    Ath(6,n)=diff(H1000+h1+h2+h3+h4+h5+h6,prom(n));
    Ath(7,n)=diff(H1000+h1+h2+h3+h4+h5+h6+h7,prom(n));
    Ath(8,n)=diff(H1000+h1+h2+h3+h4+h5+h6+h7+h8,prom(n));
    Ath(9,n)=diff(H1000+h1+h2+h3+h4+h5+h6+h7+h8+h9,prom(n));
    Ath(10,n)=diff(H1000+h1+h2+h11,prom(n));
    Ath(11,n)=diff(H1000+h1+h2+h11+h12,prom(n));
end


k=-(At*p^(-1)*At')^(-1)*u;
v=p^(-1)*At'*k;
L=l+v;

s0=sqrt((v'*p*v)/2);
Ml=p^(-1)-p^(-1)*At'*(At*p^(-1)*At')^(-1)*At*p^(-1);
SML=sqrt(diag(Ml));

H=H100+Ath*L;
MH=Ath*Ml*Ath';
SMH=sqrt(diag(MH));

%% Kontrola
u1(1,1)=L(3,1)+L(4,1)+L(5,1)+L(6,1)+L(7,1)+L(8,1)-L(13,1)-L(12,1)-L(11,1);
u1(2,1)=H200-H100-(L(1,1)+L(2,1)+L(11,1)+L(12,1)+L(13,1)+L(9,1)+L(10,1));