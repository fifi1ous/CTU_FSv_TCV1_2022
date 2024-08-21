function [A1,l0,ls]=MAT_A(A,prom,x,l,L,X1)
A1=subs(A,prom,x');
A1=eval(A1);
u=size(L,1);
for n=1:u
    for m=1:2
        Ra=L(n,1);
        Rb=L(n,2);
        if m==2
            l0(n,2)=sqrt((X1(Ra,2)-X1(Rb,2))^2+(X1(Ra,3)-X1(Rb,3))^2);
        else
            l0(n,m)=atan2(X1(Rb,2)-X1(Ra,2),X1(Rb,3)-X1(Ra,3));
            if l0(n,m)<0
                l0(n,m)=l0(n,m)+2*pi;
            end
            l0(n,m)=l0(n,m)-X1(Ra,4);
            if l0(n,m)<0
               l0(n,m)=l0(n,m)+2*pi;
            end
        end
    end
end
l0=[l0(:,2);l0(:,1)];
ls=l-l0;
% ls=l0-l;
end