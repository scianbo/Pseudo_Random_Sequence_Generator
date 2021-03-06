close all;
clear all;
freq(10)=0;

fs=4000;                %sampling freq.
y=wavrecord(3.6*fs,fs);   %records the noise from mic
fp=12000;
x=wavrecord(2*fp,fp);   %secondary noise signal
t=0:1/fs:3.6-(1/fs);
l=length(t);
pn(l)=0;                %pn sequence
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
    pn(i)=mod((i+(y3(i+1))),32);
end;

for i=1:l-1
    pn(i)=mod((x(i)+(pn(i+1))),11);
end;

for i=1:l
    pn(i)=mod(i+(pn(i)),10);
end;
%counting the frequency of each number
for j=1:1000
    freq(pn(j)+1)= freq(pn(j)+1)+1; 
end;

disp(freq);
 
%Converting the numbers into 0s and 1s
for i=1:14400
    if pn(i)>=5    %threshold function
        pn(i)=0;
    else pn(i)=1;
    end;
end;
figure(1)
hist(pn);

mat= vec2mat(pn,120); %convert sequence into a matrix
figure(2);
imshow(mat);  %display the matrix

%chi2  test
e=100;
chi2=sum(power(freq-e,2)/e);

