clc; clear; format long G;
%% 1.
s1=[4.7751 4.7752 4.7747 4.7755 4.7746];
s2=[4.7753 4.7744 4.7746 4.7751 4.7748 4.7755 4.7756 4.7746 4.7748 4.7747];
s3=[4.7752 4.7754 4.7755 4.7747 4.7751 4.7753 4.7747 4.7754 4.7749 4.7751 4.7752 4.7748 4.7754 4.7745 4.7753 4.7746 4.7751 4.7749 4.7752 4.7747
];
c1=[1;2;3];
s1p=mean(s1);
s2p=mean(s2);
s3p=mean(s3);
v1=s1p-s1; v2=s2p-s2; v3=s3p-s3;
vb1=sqrt(sum(v1.^2)/(length(s1)-1)); vbp1=vb1/(sqrt(length(s1)));
vb2=sqrt(sum(v2.^2)/(length(s2)-1)); vbp2=vb2/(sqrt(length(s2)));
vb3=sqrt(sum(v3.^2)/(length(s3)-1)); vbp3=vb3/(sqrt(length(s3)));

vysA=[s1p, vb1, vbp1; s2p, vb2, vbp2; s3p, vb3, vbp3];
vysA=[c1,vysA];
fid=fopen('vysledky.txt','w');
fprintf(fid,'příklad 1)\n');
fprintf(fid,'č.s: aritmetický průměr: výb.směr.odch.měření: výb.směr.odch.průměru:\n');
fprintf(fid,'  %.d      %7.5f               %8.6f                   %8.6f\n', vysA');
%% 2.
clear -regexp \d;
d1=[35.905 35.860 35.899 35.896 35.900 35.900 35.900 35.902];
od1=[10.0 50.0 1.0 5.0 2.0 1.5 1.0 3.0];
k1=1;
v1=k1./(od1.^2);
vp1=(d1*v1')/sum(v1);
v2=vp1-d1;
vsmo1=sqrt((v1*v2'.^2)/(length(d1)-1));
vspo1=vsmo1/(sqrt(sum(v1)));
vysB=[vp1, vsmo1, vspo1];
fprintf(fid,'\npříklad 2)\n');
fprintf(fid,'vážený průměr: vyb.jed.sm.odch: vyb.sm.odch.prum:\n');
fprintf(fid,'   %8.5f          %7.5f              %7.5f\n',vysB);
%% 3.
clear -regexp \d;
d1=[49.6175 49.6157 49.6174 49.6166];
T1=[1.2 2.0 0.7 0.3];
p1=[2 5 3 2];
for n=1:length(p1)
    od1(n)=T1(n)/sqrt(p1(n));
end
k1=od1(1)^2;
v1=k1./(od1.^2);
vp1=(d1*v1')/sum(v1);
v2=vp1-d1;
vsmo1=sqrt((v1*v2'.^2)/(length(d1)-1));
vspo1=vsmo1/(sqrt(sum(v1)));
vysC=[vp1, vsmo1, vspo1];
fprintf(fid,'\npříklad 3)\n');
fprintf(fid,'vážený průměr: vyb.jed.sm.odch: vyb.sm.odch.prum:\n');
fprintf(fid,'   %8.5f          %7.4f              %7.5f\n',vysC);
%% 4.
clear -regexp \d;
d1=[103.645 103.668 98.564 98.559 91.018 91.041 106.219 106.253 78.561 78.567];
i=1;
for n=1:length(d1)/2
    roz(n)=d1(i)-d1(i+1);
    prum(n)=(d1(i)+d1(i+1))/2;
    i=i+2;
end
vyr=sum(prum);
sd=sqrt((roz*roz')/(length(d1)/2));
s=sd/(sqrt(2));
sp=sd/2;
spp=sp*sqrt(length(d1)/2);
vysD=[vyr,sd,s,sp,spp];
fprintf(fid,'\npříklad 4)\n');
fprintf(fid,'Vyr.hodnota: Smer.odch.roz.mer.ve.dvojici: Směr.odch.jed.měř.ve.dvojici: Směr.odch.prům.měř.z.dvojice: Směr.odch.výs.hod.z.souč.jedn.prům.:\n');
fprintf(fid,' %8.3f             %8.3f                            %8.4f                        %8.4f                  %7.3f\n',vysD);
