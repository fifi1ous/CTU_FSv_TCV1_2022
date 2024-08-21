function [ls,A]=matice_A(konc,poc,l)
d=((konc(:,1)-poc(1)).^2+(konc(:,2)-poc(2)).^2).^(1/2);
fi=atan2((konc(:,1)-poc(1)),(konc(:,2)-poc(2)));

for n=1:length(fi);
    if fi(n)<0
        fi(n)=fi(n)+2*pi;
    end
    fi(n)=fi(n)-poc(3);
    if fi(n)<0
    fi(n)=fi(n)+2*pi;
    end
end
l0=[d;fi];
ls=l-l0;
A=ones(10,3);
for n=1:length(l)
    if n<6
        A(n,1)=((konc(n,1)-poc(1))/l0(n));
        A(n,2)=((konc(n,2)-poc(2))/l0(n));
        A(n,3)=0;
    else
        A(n,1)=((konc(n-5,2)-poc(2))/(l0(n-5)^2));
        A(n,2)=-((konc(n-5,1)-poc(1))/(l0(n-5)^2));
        A(n,3)=1;
    end
end
end