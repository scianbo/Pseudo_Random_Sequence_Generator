 close all;
clear all;
freq(64)=0;
one=0;
fs=2560;
y=wavrecord(1*fs,fs);
fp=1280;
x=wavrecord(2*fp,fp);%records the noise from mic

x2=wavrecord(1*fp,fp);
t=0:1/fs:1-(1/fs);
l=length(t);
pn(l)=0;
m=max(y);

y2=abs(y);             
y21=(y2/m)*1023;
y3=floor(y21);

m=max(x);
x=abs(x);             
x=(x/m)*1023;
x=floor(x);


%lcg
for i=1:l-1
    pn(i+1)=mod(i+(y3(i+1)),64);
end;

for i=1:l-1
    pn(i)=mod((pn(i+1)),64);
end;

for i=1:l-1
    pn(i)=mod(pn(i+1)+x(i),64);
end;




for j=1:l
    freq(pn(j)+1)= freq(pn(j)+1)+1; %counting the frequency of each number
end;

disp(freq);

%chi2  test
e=40;
chi=sum(power(freq-e,2)/e);

%plot(t,pn);




