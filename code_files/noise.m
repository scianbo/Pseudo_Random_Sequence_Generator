close all;
clear all;
freq(16)=0;
fs=3000;
y=wavrecord(1*fs,fs);%records the noise from mic

t=0:1/fs:1-(1/fs);
l=length(t);

plot(t,y);
m=max(y);


y2=abs(y);             
y21=(y2/m)*15;
y3=floor(y21);

for j=1:l
    freq(y3(j)+1)= freq(y3(j)+1)+1; %counting the frequency of each number
end;
num=0:15;
disp(freq);
figure(1);
plot(num,freq,'.');
figure(2);
plot(t,y);


