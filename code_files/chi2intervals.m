
clear all;
freq(8,10)=0;
chi2(8)=0;

fs=4000;
y=wavrecord(1*fs,fs);%records the noise from mic
fp=1000;
x=wavrecord(4*fp,fp);
t=0:1/fs:1-(1/fs);
l=length(t);

pn(l)=0;     %pn sequence

m=max(y);
y2=abs(y);             
y21=(y2/m)*40;
y3=floor(y21);

m=max(x);

x=abs(x);             
x=(x/m)*20;
x=floor(x);

%LCG
for i=1:l-1
    pn(i)=mod((i+(y3(i+1))),40);
end;

for i=1:l-1
    pn(i)=mod((x(i+1)+(pn(i+1))),20);
end;

for i=1:l
    pn(i)=mod(i+(pn(i)),10);
end;

loop=0;
for i=1:8
for j=1:500
    freq(i,pn(j+loop)+1)= freq(i,pn(j+loop)+1)+1; %counting the frequency of each number
end;
loop=loop+500;
end;

%disp(freq);


%chi2  test
for i=1:8
e=50;
temp1=10*i;
temp2=temp1-9;
chi2(i)=sum(power(freq(temp2:temp1)-e,2)/e);
end;
%plot(1:10,chi2);
pass(8)=0;

for i=1:8
if chi2(i)<=5.38
pass(i)=1;
else
pass(i)=0;
end
end;
disp(pass);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

freq2(4,10)=0;
loop=0;
for i=1:4
for j=1:1000
    freq2(i,pn(j+loop)+1)= freq2(i,pn(j+loop)+1)+1; %counting the frequency of each number
end;
loop=loop+1000;
end;

%disp(freq);


%chi2  test
chi22(4)=0;
for i=1:4
e=100;
temp1=10*i;
temp2=temp1-9;
chi22(i)=sum(power(freq2(temp2:temp1)-e,2)/e);
end;
%plot(1:10,chi2);
pass1(4)=0;

for i=1:4
if chi22(i)<=5.38
pass1(i)=1;
else
pass1(i)=0;
end
end;
disp(pass1);

