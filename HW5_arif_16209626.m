%Energy Analysis
%Calculation of potential, translational kinetic, rotational kinetic, and
%total energies of the foot and leg segments as functions of time

clear
clc
close all

load('data.mat');

%Applying 2nd order lowpass butterworth filter: Cutoff frequency 6

pankx = filter_data(pankx,6.00,100,[1]);
panky = filter_data(panky,6.00,100,[1]);
ptoex = filter_data(ptoex,6.00,100,[1]);
ptoey = filter_data(ptoey,6.00,100,[1]);
pknex = filter_data(pknex,6.00,100,[1]);
pkney = filter_data(pkney,6.00,100,[1]);
Fax = filter_data(Fax,6.00,100,[1]);
Fay = filter_data(Fay,6.00,100,[1]);
M = filter_data( M,6.00,100,[1]);

mass = 90;
m_f = 0.0145*mass; %foot mass/body mass=0.0145
m_l = 0.0465*mass; %leg mass/body mass=0.0465
g = 9.81;
fs = 100;%sampling frequency
time = [1/fs:1/fs:106/fs];

%energy analysis for foot
%potential energy
cm_x_f = pankx + ((ptoex-pankx)/2);
cm_y_f = ptoey + ((panky-ptoey)/2);
PE_f = m_f*g*cm_y_f; %potential energy

%translational energy
dt = 1/fs;
%Applying derivative to calculate velocity and acceleration
[vx_f,ax_f] = derivative(cm_x_f,1,dt);
[vy_f,ay_f] = derivative(cm_y_f,1,dt);
KET_f = (0.5*m_f*vx_f.^2) + (0.5*m_f*vy_f.^2); %translational energy

%rotational energy
theta_f = atan2((ptoey-panky),(ptoex-pankx));
%Applying derivative to calculate angular velocity and angular acceleration
[omega_f,alpha_f] = derivative(theta_f,1,dt);

L_f = sqrt((ptoex-pankx).^2 + (panky-ptoey).^2); %length of foot
L_f_avg = mean(L_f);

rho_f = L_f_avg*0.475; %radius of gyration/foot length=0.475
I_f = m_f*(rho_f).^2;
KER_f = (0.5*I_f*(omega_f).^2); %rotational energy

total_E_f = PE_f + KET_f + KER_f; %total energy

%energy analysis for leg
%potential energy
cm_x_l = pknex + (0.433*(pankx-pknex));
cm_y_l = panky + (0.567*(pkney-panky));
PE_l = m_l*g*cm_y_l; %potential energy

%translational energy
%Applying derivative to calculate velocity and acceleration
[vx_l,ax_l] = derivative(cm_x_l,1,dt);
[vy_l,ay_l] = derivative(cm_y_l,1,dt);
KET_l = (0.5*m_l*vx_l.^2) + (0.5*m_l*vy_l.^2); %translational energy

%rotational energy
theta_l = atan2((panky-pkney),(pankx-pknex));
%Applying derivative to calculate angular velocity and angular acceleration
[omega_l,alpha_l] = derivative(theta_l,1,dt);

L_l = sqrt((pankx-pknex).^2 + (pkney-panky).^2); %length of leg
L_l_avg = mean(L_l);

rho_l = L_l_avg*0.302; %radius of gyration/leg length=0.302
I_l = m_l*(rho_l).^2;
KER_l = (0.5*I_l*(omega_l).^2); %rotational energy

total_E_l = PE_l + KET_l + KER_l; %total energy

%Calculation:Energy Exchange 

%foot energy exchange
del_PE_f = (max(PE_f)- min(PE_f));
del_KET_f = (max(KET_f)- min(KET_f));
del_KER_f = (max(KER_f)- min(KER_f));
del_E_f = (max(total_E_f)- min(total_E_f));
E_ex_f = del_PE_f + del_KET_f + del_KER_f - del_E_f;

%plot:foot
figure (1)
plot(time,PE_f,'g',time,KET_f,'b',time,KER_f,'r',time,total_E_f,'k');
title('Foot Energy Analysis with time')
xlabel('Time (Second)')
ylabel('Energy (Joule)')
legend('Potential Energy','Translational Kinetic Energy','Rotational Kinetic Energy','Total Energy')
grid on

%leg energy exchange
del_PE_l = (max(PE_l)- min(PE_l));
del_KET_l = (max(KET_l)- min(KET_l));
del_KER_L = (max(KER_l)- min(KER_l));
del_E_l = (max(total_E_l)- min(total_E_l));
E_ex_l = del_PE_l + del_KET_l + del_KER_L - del_E_l;

%plot:leg
figure (2)
plot(time,PE_l,'g',time,KET_l,'b',time,KER_l,'r',time,total_E_l,'k');
title('Leg Energy Analysis with time')
xlabel('Time (Second)')
ylabel('Energy (Joule)')
legend('Potential Energy','Translational Kinetic Energy','Rotational Kinetic Energy','Total Energy')
grid on

%Ankle Power
P = M.*(omega_f -omega_l);

%plot:Ankle Power
figure (3)
plot(time,P);
title('Ankle Power Vs. Time')
xlabel('Time (Second)')
ylabel('Ankle Power(Watt)')
grid on
line([0.112, 0.112],ylim,'color','r')
line([0.795, 0.795],ylim,'color','r')

%work_done
W = trapz(P).*dt; %total work done
ipos = find(P>0);
ineg = find(P<0);
W_pos = trapz(P(ipos)).*dt; %positive work
W_neg = trapz(P(ineg)).*dt; %negative work


