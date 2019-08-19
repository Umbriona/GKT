function [] = miniprojekt4(U)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%beräkning av bubbelpunkten

close all
clc
Q=[ 1.0000    0.4500    0.8000    0.1000    1.5000
    2.0000    0.4500    0.8000    0.1000    1.7500
    3.0000    0.4500    0.8000    0.1000    2.0000
    4.0000    0.4500    0.9000    0.1000    2.0000
    5.0000    0.4500    0.9000    0.1000    2.5000
    6.0000    0.4500    0.9000    0.1000    3.0000
    7.0000    0.4500    0.8000    0.1500    1.5000
    8.0000    0.4500    0.8000    0.1500    1.7500
    9.0000    0.4500    0.8000    0.1500    2.0000
   10.0000    0.4500    0.9000    0.1500    2.0000
   11.0000    0.4500    0.9000    0.1500    2.5000
   12.0000    0.4500    0.9000    0.1500    3.0000
   13.0000    0.4500    0.8000    0.2000    1.5000
   14.0000    0.4500    0.8000    0.2000    1.7500
   15.0000    0.4500    0.8000    0.2000    2.0000
   16.0000    0.4500    0.9000    0.2000    2.0000
   17.0000    0.4500    0.9000    0.2000    2.5000
   18.0000    0.4500    0.9000    0.2000    3.0000
   19.0000    0.5000    0.8000    0.1000    1.5000
   20.0000    0.5000    0.8000    0.1000    1.7500
   21.0000    0.5000    0.8000    0.1000    2.0000
   22.0000    0.5000    0.9000    0.1000    2.0000
   23.0000    0.5000    0.9000    0.1000    2.5000
   24.0000    0.5000    0.9000    0.1000    3.0000
   25.0000    0.5000    0.8000    0.1500    1.5000
   26.0000    0.5000    0.8000    0.1500    1.7500
   27.0000    0.5000    0.8000    0.1500    2.0000
   28.0000    0.5000    0.9000    0.1500    2.0000
   29.0000    0.5000    0.9000    0.1500    2.5000
   30.0000    0.5000    0.9000    0.1500    3.0000
   31.0000    0.5000    0.8000    0.2000    1.5000
   32.0000    0.5000    0.8000    0.2000    1.7500
   33.0000    0.5000    0.8000    0.2000    2.0000
   34.0000    0.5000    0.9000    0.2000    2.0000
   35.0000    0.5000    0.9000    0.2000    2.5000
   36.0000    0.5000    0.9000    0.2000    3.0000
   37.0000    0.5500    0.8000    0.1000    1.2000
   38.0000    0.5500    0.8000    0.1000    1.5000
   39.0000    0.5500    0.8000    0.1000    1.8000
   40.0000    0.5500    0.9000    0.1000    1.5000
   41.0000    0.5500    0.9000    0.1000    2.0000
   42.0000    0.5500    0.9000    0.1000    2.5000
   43.0000    0.5500    0.8000    0.1500    1.2000
   44.0000    0.5500    0.8000    0.1500    1.5000
   45.0000    0.5500    0.8000    0.1500    1.8000
   46.0000    0.5500    0.9000    0.1500    1.5000
   47.0000    0.5500    0.9000    0.1500    2.0000
   48.0000    0.5500    0.9000    0.1500    2.5000
   49.0000    0.5000    0.8500    0.1000    1.5000
   50.0000    0.5000    0.8500    0.1000    1.7500
   51.0000    0.5000    0.8500    0.1000    2.0000
   52.0000    0.5000    0.8500    0.1500    2.0000
   53.0000    0.5000    0.8500    0.1500    2.5000
   54.0000    0.5000    0.8500    0.1500    3.0000
   55.0000    0.5000    0.8500    0.2000    2.0000
   56.0000    0.5000    0.8500    0.2000    2.5000
   57.0000    0.5000    0.8500    0.2000    3.0000
   58.0000    0.5500    0.8500    0.1500    1.5000
   59.0000    0.5500    0.8500    0.1500    1.8000
   60.0000    0.5500    0.8500    0.1500    2.0000];

%Givna data

xf=Q(U, 2);            % Q är här den indatan som kom med pdf:en
F=10; % inflödet (mol/h)

xb=Q(U, 4);     % xb och xd tas ur Q
xd=Q(U, 3);
rhoL=772*xb+796*(1-xb);   %rohL och rhoV är densiteter i vätske fas respektive gas fas
rhoV=1.8;
sigma=0.024;
aandelfall=0.2;         %aandelfall är den andel av den inre arean som fallröret upptar

A=[1 1;xd xb];      %för att få produkt stömmarna ut loses mass balans och komponent balans  
C=[F; F*xf];        % över hela kolonnen för respektive fall
DB=A\C;
R=Q(U, 5);
V=DB(1)*(R+1);
Lm=R*DB(1);
Ln=Lm+F;

P=760; %mmHg





Ae=18.9119;         %antoinekonstanter
Be=3803.98;
Ce=231.47;
Ap=17.5439;
Bp=3166.338;
Cp=193.00;





% Avdrivardel   Stegning till feedbotten:
x(1)=xb;
i=0;
f1=0;
while x<xf
    i=i+1;                                      % här är loparna som itererar fram hur många ideala steg som behövs 
        xn1=xb;
        xn2=1-xb;
        Tbubbel=77;
        avvikelse1=1;
             while abs(avvikelse1)>0.001        % för jämvikts förhollandet behövdes den relativa flyktigheten
                Tbubbel=Tbubbel+0.01;           % så en extra lop i lopen fick läggas till för att få framm värden på (x1,x2,y1,y2)
                P0e=exp(Ae-Be./(Tbubbel+Ce));
                P0p=exp(Ap-Bp./(Tbubbel+Cp));
                y1=P0e.*xn1./P;
                y2=P0p.*xn2./P;
                avvikelse1=(1-y1-y2);
                f1=f1+1;
                if f1>100000                        % ett stopp för att pogrammet inte skall skena iväg.
                break
                end
                alpha=(y1/xn1)/(y2/xn2);
              end
    y(i)=alpha*x(i)/(1+x(i)*(alpha-1));
    x(i+1)=V/Ln*y(i)+DB(2)/Ln*xb;
end

m=i;

while y(i)<xd
    x(i+1)=V/Lm*y(i)+1/Lm*(DB(2)*xb-F*xf);   %Komponent ballans över förstärkar delen
      xn1=xb;
        xn2=1-xb;
        Tbubbel=77;
        avvikelse1=1;
             while abs(avvikelse1)>0.001 
                Tbubbel=Tbubbel+0.01;
                P0e=exp(Ae-Be./(Tbubbel+Ce));
                P0p=exp(Ap-Bp./(Tbubbel+Cp));
                y1=P0e.*xn1./P;
                y2=P0p.*xn2./P;
                avvikelse1=(1-y1-y2);
                f1=f1+1;
                if f1>100000
                break
                end
                alpha=(y1/xn1)/(y2/xn2);
              end
    i=i+1;
    
    y(i)=alpha*x(i)/(1+x(i)*(alpha-1)); %Jv samband
end






   H=0.6*i+1*1/0.7;     %höjd faktorn


disp(['bottnar nedre del    ' num2str(m)])

disp(['bottnar övre del     ' num2str(i-m)])

disp(['bottnar totalt       ' num2str(i)])

disp(['Torn höjd (m)      ' num2str(H)])



ax45=Log10([0.02, 0.3, 0.6, 1, 8]);             % här räknas kollonnens diameter ut     
ay45=Log10([0.11 0.08 0.065 0.04 0.029]);       % genom det med följande formlerna
ap45=polyfit(ax45,ay45,4);                      %en funktion passas till kurva 0.60 i diagrammet för att man skall kunna läsa av det.

yanpassad=ap45(1).*ax45.^4+ap45(2).*ax45.^3+ap45(3).*ax45.^2+ap45(4).*ax45.^1+ap45(5);
aFLV=Lm/V*(rhoV/rhoL)^(1/2);
logak1=ap45(1)*aFLV.^4+ap45(2)*aFLV.^3+ap45(3)*aFLV.^2+ap45(4)*aFLV.^1+ap45(5);
ak1=10^logak1;
avm=ak1*sqrt((rhoL-rhoV)/rhoV)*(sigma/0.020)^0.20;

adrift=avm*0.7;
Atorn=avm/(avm*adrift*rhoV*(1-aandelfall));

Dtorn=sqrt(Atorn*4/pi);

disp(['Torn diameter (m)      ' num2str(Dtorn)])
disp('fel med enheterna någon stans vid beräkningen av tornets diameter')



end

