%HW6
%calculation of ankle joint angles

clear
clc
close all

load('data.mat');

latankX=data(:,1);
latankY=data(:,2);
latankZ=data(:,3);
heelX=data(:,4);
heelY=data(:,5);
heelZ=data(:,6);
toeX=data(:,7);
toeY=data(:,8);
toeZ=data(:,9);
medankX=data(:,10);
medankY=data(:,11);
medankZ=data(:,12);
latkneX=data(:,13);
latkneY=data(:,14);
latkneZ=data(:,15);
medkneX=data(:,16);
medkneY=data(:,17);
medkneZ=data(:,18);

%Applying 2nd order lowpass butterworth filter: Cutoff frequency 6

lankX = filter_data(latankX,6.00,100,[1]);
lankY = filter_data(latankY,6.00,100,[1]);
lankZ = filter_data(latankZ,6.00,100,[1]);
hlX = filter_data(heelX,6.00,100,[1]);
hlY = filter_data(heelY,6.00,100,[1]);
hlZ = filter_data(heelZ,6.00,100,[1]);
toX = filter_data(toeX,6.00,100,[1]);
toY = filter_data(toeY,6.00,100,[1]);
toZ = filter_data(toeZ,6.00,100,[1]);
mankX= filter_data(medankX,6.00,100,[1]);
mankY= filter_data(medankY,6.00,100,[1]);
mankZ= filter_data(medankZ,6.00,100,[1]);
lkneX = filter_data( latkneX,6.00,100,[1]);
lkneY = filter_data( latkneY,6.00,100,[1]);
lkneZ = filter_data( latkneZ,6.00,100,[1]);
mkneX = filter_data( medkneX,6.00,100,[1]);
mkneY = filter_data( medkneY,6.00,100,[1]);
mkneZ = filter_data( medkneZ,6.00,100,[1]);

%leg segment
pkneX=mkneX + (0.5*(lkneX-mkneX));
pkneY=mkneY + (0.5*(lkneY-mkneY));
pkneZ=mkneZ + (0.5*(lkneZ-mkneZ));

pankX=mankX + (0.5*(lankX-mankX));
pankY=mankY + (0.5*(lankY-mankY));
pankZ=mankZ + (0.5*(lankZ-mankZ));

comLX=pankX + (0.567*(pkneX-pankX));
comLY=pankY + (0.567*(pkneY-pankY));
comLZ=pankZ + (0.567*(pkneZ-pankZ));

kLX=pkneX-comLX;
kLY=pkneY-comLY;
kLZ=pkneZ-comLZ;

kL=[kLX kLY kLZ];

iLX_temp=lkneX-mkneX;
iLY_temp=lkneY-mkneY;
iLZ_temp=lkneZ-mkneZ;

iL_temp=[iLX_temp iLY_temp iLZ_temp];

jL=cross(kL,iL_temp);

iL=cross(jL,kL);

%foot segment
comFX=hlX +(0.44*(toX-hlX));
comFY=hlY +(0.44*(toY-hlY));
comFZ=hlZ +(0.44*(toZ-hlZ));

kFX=hlX-toX;
kFY=hlY-toY;
kFZ=hlZ-toZ;

kF=[kFX kFY kFZ];

iFX_temp=lankX-mankX;
iFY_temp=lankY-mankY;
iFZ_temp=lankZ-mankZ;

iF_temp=[iFX_temp iFY_temp iFZ_temp];

jF=cross(kF,iF_temp);
iF=cross(jF,kF);


for i=25
iLU= iL(i,:)./norm(iL(i,:));
 jLU= jL(i,:)./norm(jL(i,:));
 kLU= kL(i,:)./norm(kL(i,:));
 
 iFU= iF(i,:)./norm(iF(i,:));
 jFU= jF(i,:)./norm(jF(i,:));
 kFU= kF(i,:)./norm(kF(i,:));
 
TL = [iLU ; jLU ; kLU]
TF = [iFU ; jFU ; kFU];

TL_tr= (TL)'
R = TF*TL_tr

b=asin(R(3,1))
c=asin(-R(2,1)./cos(b))
a=acos(R(3,3)./cos(b))

alpha = a;
beta = b;
gama = c;

angle=[alpha, beta,gama]

       end
 

%        for k=2;
%  
% TL = [iLU(k,:) ; jLU(k,:) ; kLU(k,:)]
% TF = [iFU(k,:) ; jFU(k,:) ; kFU(k,:)];
% 
% TL_tr= (TL)'
% R = TF*TL_tr
% 
% b=asin(R(3,1))
% c=asin(-R(2,1)./cos(b))
% a=acos(R(3,3)./cos(b))
% 
% alpha = a*(180./pi)
% beta = b*(180./pi)
% gama = c*(180./pi)
% 
% angle=[alpha, beta,gama]
% 
%        end
   
       
