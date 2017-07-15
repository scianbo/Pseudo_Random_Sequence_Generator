close all;
clear all;
freq(16)=0;
one=0;

%records the noise from mic
fs=4000;
y=wavrecord(1*fs,fs);
fp=4000;
x=wavrecord(1*fp,fp);
x2=wavrecord(1*fp,fp);
t=0:1/fs:1-(1/fs);

lk=[0 1 1 2 1 2 2 3 1 2 2 3 2 3 3 4]; %lookup table for no.of 1s
l=length(t);
pn(l)=0;
m=max(y);

y2=abs(y);             
y21=(y2/m)*63;
y3=floor(y21);

m=max(x);
x=abs(x);             
x=(x/m)*63;
x=floor(x);

m=max(x2);
x2=abs(x2);             
x2=(x2/m)*127;
x2=floor(x2);
%lcg
for i=1:l-1
    pn(i+1)=mod(i+(y3(i+1)),16);
end;

for i=1:l-1
    pn(i)=mod((pn(i+1)),16);
end;

for i=1:l-1
    pn(i)=mod(pn(i+1)+x(i),16);
end;

for i=1:l-1
    pn(i)=mod(pn(i+1)+x2(i),16);
end;


for j=1:l
    freq(pn(j)+1)= freq(pn(j)+1)+1; %counting the frequency of each number
end;
num=0:9;
%disp(freq);

%chi2  test
e=250;
chi=sum(power(freq-e,2)/e);

%monobit test
for i=1:16 
    one=one+(freq(i)*lk(i));
end;
zero=(4000*4)-one;
%display(one);
%display(zero);
oner=one/(one+zero);
zeror=zero/(one+zero);
ratio=[oner zeror];
disp(ratio);

