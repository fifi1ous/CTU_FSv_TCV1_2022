clc; clear; format long G
%% načtení + úprava dat
data=load('zadani_27.txt');
data=sort(data);
%% 1. Charakteristiky polohy

%průměr
prum=sum(data)/length(data);

%medián
med=data(:,(length(data)+1)/2);

%% 2. Charakteristiky proměnlivosti

roz_prum=data-prum;
VSO=sqrt(sum((roz_prum).^2)/(length(data)-1));

PO=sum(abs(roz_prum))/length(data);

RP=abs(roz_prum);
RP=sort(RP);
PRO=RP(:,(length(roz_prum)+1)/2);

%% 3. Charakteristiky šikmosti

SI=(sum((roz_prum).^3)/(length(data)*VSO^3));

%% 4. Charakteristiky špičatosti

SP=(sum((roz_prum).^4)/(length(data)*VSO^4));
%% Výpis dat do příkazového řádku
fprintf('Průměrná hodnota=%10.5f\n',prum)
fprintf('Medián          =%9.4f\n',med)
fprintf('Výběrová směrodatná odchylka=%6.4f\n',VSO)
fprintf('Průměrná odchylka=%6.4f\n',PO)
fprintf('Pravděpodobná odchylka=%6.4f\n',PRO)
fprintf('Šikmost=%5.3f\n',SI)
fprintf('Špičatost=%4.1f\n',SP)