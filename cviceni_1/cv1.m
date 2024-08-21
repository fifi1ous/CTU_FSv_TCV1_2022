clc; clear; format long G
gon=200/pi; rnd=pi/200;
%% načtení dat + úprava
mer=load('mereni_27.txt');
ss=load('souradnice_27.txt');
mer(:,3)=mer(:,3)*rnd;
%% Výpočet směrníku
smer=atan2((ss(4)-ss(3)),(ss(6)-ss(5)));
sm=smer-mer(1,3);
%% výpočet souřadnic
SS=zeros(size(mer,1)-1,3); 
for n=1:size(SS,1);
    SS(n,1)=n;
    SS(n,2)=ss(3)+sin(sm+mer((n+1),3))*mer((n+1),2);
    SS(n,3)=ss(5)+cos(sm+mer((n+1),3))*mer((n+1),2);
end
%% textový výpis
fid=fopen('vysledky_27.txt','w');
fprintf(fid,'číslo bodu |   [Y]      |        [X]\n');
fprintf(fid,'%4d    %12.3f      %12.3f\n',SS');
fclose(fid);
%% grafické znázornění
SS=[SS;SS(1,:)];
figure
plot(-SS(:,2),-SS(:,3),'Color','r','Marker','+','MarkerSize',10)
xlabel('Y')
ylabel('X','Rotation',-0)
hold on
plot(-ss(:,2),-ss(:,3),'Color','b','LineStyle','-.','Marker','+','MarkerSize',10)
set(gca,'xAxisLocation','top')
set(gca,'yAxisLocation','right')
hold off
type vysledky_27.txt
