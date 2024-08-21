function [A,prom]=MAT_A_DEV(X1,x,l,L)
d=size(X1,1); u=length(l); p=length(x); o=length(L);
L1=[L(:,1:2);L(:,1:2)];
x2=sortrows(X1(:,1));

syms Y [1,d]
syms X [1,d]
syms OP [1,d]
prom=[sym2cell(Y),sym2cell(X),sym2cell(OP)];


for n=1:u
    for m=1:p
        Ra=L1(n,1);
        Rb=L1(n,2);
       if n<=u/2
           A(n,m)=diff(sqrt((Y(Ra)-Y(Rb))^2+(X(Ra)-X(Rb))^2),prom(m));
       else
           A(n,m)=diff((atan((Y(Ra)-Y(Rb))/(X(Ra)-X(Rb))))+OP(Ra),prom(m));
       end
      
     end
end
end