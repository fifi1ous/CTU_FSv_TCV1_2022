clc; clear; format long G
data=[    1 1035205.687 877363.098 18.0142 330.057; 
   19 1034622.298 877557.207 162.6415 347.833; 
   29 1034593.248 877160.751 242.7221 327.283; 
   35 1034767.056 876977.558 290.1032 361.626; 
   48 1035213.431 877238.727 394.5568 345.297]; 
G_R=1/200*pi;
sd =  0.003; sfi=0.0015*G_R;
X=[877321.664,1034878.242,389.9988*G_R];
data=[data(:,1),data(:,3),data(:,2),data(:,4)*G_R,data(:,5)];
%% MAtice VAH
P=eye(10,10);
for n=1:size(P,1)
    if n<=size(P,1)/2
        P(n,:)=P(n,:)*1/sd^2;
    else
        P(n,:)=P(n,:)*1/sfi^2;
    end
end
%% l
l=[data(:,5);data(:,4)];
SS=[data(:,2),data(:,3)];
q=10e-9; 
%%
for n=1:10
[ls,A]=matice_A(SS,X,l);
if n>2
    if v-ls<q
        break
    end
end
dx=-(A'*P*A)^(-1)*A'*P*ls;
X=X+dx';
v=A*dx+ls;
end
s0=sqrt((v'*P*v)/(10-3));
Mx=1^2*(A'*P*A)^(-1);
Xt=[X(1),X(2),X(3)/G_R];
SMX=sqrt(diag(Mx));