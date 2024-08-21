function [Bt,b]=MAT_B(Data,Data2,X1,x)
u=size(X1,2)-1;
p=size(x,1);
Bt=zeros(u,p);
Data3=Data+size(X1,1);
qq=1:p;
o=length(Data);
b=zeros(u);

for n=1:u
    for m=1:p
        if n==1
            if m<=p/u
                for j=1:o
                    if m==Data(j)
                        Bt(n,m)=X1(Data2(j),2);
                    end
                end
            end
            if m>p/u && m<=p/u*o
                for j=1:o
                    if m==Data3(j)
                        Bt(n,m)=-X1(Data2(j),3);
                    end
                end
            end
        elseif n==2
            for j=1:o
                if m==Data(j)
                    Bt(n,m)=1;
                end
            end
        elseif n==3
            for j=1:o
                if m==Data3(j)
                    Bt(n,m)=1;
                end
            end
        end
    end
end
end