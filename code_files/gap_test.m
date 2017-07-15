close all;
clear all;
freq(10)=0;
freq2(100)=0;
fs=4000;
y=wavrecord(1*fs,fs);%records the noise from mic
fp=2000;
x=wavrecord(2*fp,fp);
t=0:1/fs:1-(1/fs);
l=length(t);
gapcount=0;
N=0;
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
    pn(i)=mod((x(i)+(pn(i+1))),20);
end;

for i=1:l
    pn(i)=mod(i+(pn(i)),10);
end;

for j=1:l
    freq(pn(j)+1)= freq(pn(j)+1)+1; %counting the frequency of each number
end;

disp(freq);

%chi2  test
e=400;
chi2=sum(power(freq-e,2)/e);

freq2(150)=0;

for x=0:9
for i=1:100
    if pn(i)==x
        k=i;
        while pn(k+1)~=x 
                    
                    gapcount=gapcount+1;
                    
                    k=k+1;
                     if k==100
                        break;
                     end;
                
         end;
         
         freq2(gapcount+1)=freq2(gapcount+1)+1;
            if gapcount==0;
            freq2(gapcount+1)=freq2(gapcount+1)+1;
            else
                N=N+1;
            end;
            gapcount=0;
    end;
end;
end;

thr(16)=0;
for i=1:16
    thr(i)=1-power(0.9,i*4);
end;
 prac(16)=0;  
 s=sum(freq2);
for i=1:16
    prac(i)=sum(freq2(1:i*4))/s;
end;

crit=1.36/sqrt(90); %los=0.05 D(0.05)=1.36
m=max(thr-prac);
pass=0;
if m<=crit
    pass=1;
end;
display(pass);
display(prac);

    





