clc; clear; format long G
%% Čas trvání skriptu 20s, čas způsobuje funkce na derivace, očekávejte zdržení
G=1/200*pi;
%% Data                             %pevné body
Data2=[  1      877314.982     1034882.802
         4      876308.872     1034636.046];
Data=Data2(:,1);

L=[1   2    295.2442   343.158
   1   8    362.8942   330.808
   2   1    103.4268   343.155
   2   3    303.3990   344.470
   2   7    371.5363   337.200
   2   8    39.2359   341.649
   3   2    114.0832   344.468
   3   4    313.7441   348.374
   3   6    380.2477   340.836
   3   7    49.2972   347.676
   4   3    94.9096   348.374
   4   5    362.8076   337.946
   4   6    29.3743   343.909
   5   4    171.8732   337.945
   5   6    104.1924   340.500
   6   3    177.7016   340.832
   6   4    245.6561   343.909
   6   5    311.4090   340.496
   6   7    111.1745   355.387
   7   2    163.9113   337.196
   7   3    230.9852   347.681
   7   6    295.4141   355.386
   7   8    97.0488   344.212
   8   1    167.8682   330.804
   8   2    236.0282   341.654
   8   7    301.4677   344.223];

 X1=[    8	    877090.334	   1035125.612	         384.6040	
         2	    876981.541	   1034801.760	         381.3946	
         7	    876754.348	   1035050.912	         389.0214
         3	    876646.880	   1034720.275	         370.7085	
         6	    876409.534	   1034964.867	         373.2560	
         5	    876078.881	   1034883.638	         380.4720	
         1      877314.982     1034882.802           389.5780
         4      876308.872     1034636.046           389.5430];
X1=sortrows(X1,1);
X1(:,4)=X1(:,4)*G;
L(:,3)=L(:,3)*G;
%% Nastavení    
smer=0.0015; sm=smer*G;
sd=0.003;
q=10e-9;
%% Úprava dat
l=[L(:,4);L(:,3)];
x=[X1(:,2);X1(:,3);X1(:,4)];
x2=[X1(:,1)];
%% Matice Vah
P1=eye(size(L,1))*(1/sd^2); P2=eye(size(L,1))*(1/sm^2); P3=zeros(size(L,1));P=[P1,P3;P3,P2];
%% vypočet 
[A,prom]=MAT_A_DEV(X1,x,l,L); 
%%
for n=1:10
    [A1,l0,ls]=MAT_A(A,prom,x,l,L,X1);
    [Bt,b]=MAT_B(Data,Data2,X1,x);
    b1=b(:,3);
    qq=size(X1,1);
    A1=[A1(:,1:2*qq)*(-1),A1(:,2*qq+1:end)];

    if n>2
        if v-ls<q
            break
        end
    end
    ATPA=[A1'*P*A1,Bt';Bt,b];   
    ATPL=[A1'*P*ls;b1];
    % ATPA=[A1'*P*A1];   
    % ATPL=[A1'*P*ls];
    dx=-(ATPA)^(-1)*ATPL;
    dx(end-(length(b)-1):end)=[];
    x=x+dx;
    v=A1*dx+ls;
    X3=[x2,x(1:qq),x((qq+1):(qq*2))];
    X1=[sortrows(X3,1),x(qq*2+1:end)];
    Data2=X1(Data,:);
end
s0=sqrt((v'*P*v)/(size(A1,1)+(size(X1,2)-1)-size(A1,2)));
Mx=1^2*([A1'*P*A1,Bt';Bt,b])^(-1);
SMX=sqrt(diag(Mx));
SMX(end-(length(b)-1):end)=[];
X=[X1(:,1),X1(:,2),X1(:,3),X1(:,4)/G];

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
function [Bt,b]=MAT_B(Data,Data2,X1,x)
u=size(X1,2)-1;
p=size(x,1);
Bt=zeros(u,p);
Data3=Data+size(X1,1);
o=length(Data);
b=zeros(u);

for n=1:u
    for m=1:p
        if n==1
            if m<=p/u
                for j=1:o
                    if m==Data(j)
                        Bt(n,m)=X1(Data2(j),3);
                    end
                end
            end
            if m>p/u && m<=p/u*o
                for j=1:o
                    if m==Data3(j)
                        Bt(n,m)=-X1(Data2(j),2);
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