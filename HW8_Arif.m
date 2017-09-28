
%HW8
%differences between pre-fatique and post-fatique conditions

clear
clc
close all

load('data.mat'); 

fs = 1000; %sampling frequency
t = [1/fs:1/fs:1]; %time reference

figure(1)
plot(t,emg1,'g',t,emg2,'b'); %plot both pre-fatique and post-fatoque EMG data
title('EMG vs Time')
xlabel('Time (Second)')
ylabel('Amplitude')
legend('pre-fatigue','post-fatigue');
grid on

%pre-fatique
emg1_rect = abs(emg1); %rectify data

figure(2)
plot(t,emg1_rect); %plot rectified data
title('Rectified EMG (Pre-fatigue)')
xlabel('Time (Second)')
ylabel('Amplitude')
grid on

emg1_env = filter_data(emg1_rect,2.4,fs,[1]);

figure(3)
plot(t,emg1_env);
title('Linear Enevelope:Pre-fatigue(low-pass filtered version of Rectified EMG)')
xlabel('Time (Second)')
ylabel('Amplitude')
grid on


figure(4)
plot(t,emg1_rect,'b',t,emg1_env,'r');
title('rectified EMG(pre-fatigue) with linear envelope')
xlabel('Time (Second)')
ylabel('Amplitude')
grid on

[f,p] = power_spectrum(emg1,fs); %power spectrum

figure(5)
plot(f,p);
stem(f,p);
title('power Spectrum:pre-fatigue')
xlabel('frequency')
ylabel('power')
grid on

%post-fatique
emg2_rect = abs(emg2); %rectify data

figure(6)
plot(t,emg2_rect); %plot rectified data
title('Rectified EMG (post-fatigue)')
xlabel('Time (Second)')
ylabel('Amplitude')
grid on


emg2_env = filter_data(emg2_rect,2.4,fs,[1]);

figure(7)
plot(t,emg2_env);
title('Linear Enevelope:Post-fatigue(low-pass filtered version of Rectified EMG)')
xlabel('Time (Second)')
ylabel('Amplitude')
grid on

figure(8)
plot(t,emg2_rect,'b',t,emg2_env,'r');
title('rectified EMG(post-fatigue) with linear envelope')
xlabel('Time (Second)')
ylabel('Amplitude')
grid on

[f2,p2] = power_spectrum(emg2,fs);

figure(9)
plot(f2,p2);
stem(f2,p2);
title('power Spectrum:post-fatigue')
xlabel('frequency')
ylabel('power')
grid on


