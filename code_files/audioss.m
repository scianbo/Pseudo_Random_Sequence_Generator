close all;
clear all;
freq(10)=0;
freq2(100)=0;
fs=2000;
y=wavrecord(1*fs,fs);%records the noise from mic
fp=2000;
x=wavrecord(1*fp,fp);
t=0:1/fs:1-(1/fs);
l=length(t);

pn(l)=0;     %pn sequence
pn2(l)=0;  %pn sequence 2 for serial test


m=max(y);
y2=abs(y);             
y21=(y2/m)*63;
y3=floor(y21);

m=max(x);

x=abs(x);             
x=(x/m)*63;
x=floor(x);

%LCG
for i=1:l-1
    pn(i)=mod((i+(y3(i+1))),10);
end;

for i=1:l-1
    pn(i)=mod((x(i+1)+(pn(i+1))),10);
end;

for i=1:l
    pn(i)=mod(i+(pn(i)),10);
end;

for j=1:l
    freq(pn(j)+1)= freq(pn(j)+1)+1; %counting the frequency of each number
end;

disp(freq);
n=0:9;
plot(n,freq);

for i=1:l-1
    pn2(i)=(pn(i)*10)+pn(i+1);
end;
pn2(l)=(pn(l)*10)+pn(1);

for j=1:l
    freq2(pn2(j)+1)= freq2(pn2(j)+1)+1; %counting the frequency of each number
end;

%disp(freq2);

%chi2  test
e=200;
chi2=sum(power(freq-e,2)/e);


