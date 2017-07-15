close all;
clear all;
freq(8)=0;
one=0;
fs=3000;
y=wavrecord(1*fs,fs);
fp=3000;
x=wavrecord(1*fp,fp);%records the noise from mic
lk=[0 1 1 2 1 2 2 3];
x2=wavrecord(1*fp,fp);
t=0:1/fs:1-(1/fs);
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
x2=(x2/m)*63;
x2=floor(x2);
%lcg
for i=1:l-1
    pn(i+1)=mod(i+(y3(i+1)),8);
end;

for i=1:l-1
    pn(i)=mod((pn(i+1)),8);
end;

for i=1:l-1
    pn(i)=mod(pn(i+1)+x(i),8);
end;

for i=1:l-1
    pn(i)=mod(pn(i+1)+x2(i),8);
end;



for j=1:l
    freq(pn(j)+1)= freq(pn(j)+1)+1; %counting the frequency of each number
end;
disp(freq);
%figure(1);
%%lot(t,pn);
%figure(2);
%plot(t,y);
%figure(3);
%ylim([270,330]);
%stairs(num,freq);

%chi2  test
e=375;
chi=sum(power(freq-e,2)/e);

for i=1:8
    one=one+(freq(i)*lk(i));
end;
zero=(3000*3)-one;
disp(one);
disp(zero);

