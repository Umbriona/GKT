clear all
P=760; %mmHg
q= 0.8;
zfa=0.35;   % toaltkonc av A i inflödet
xfa=0.3063; % konc. av A i vätskeinflödet

Aa=6.90565;
Ba=1211.033;
Ca=220.790;
Ab=6.95464;
Bb=1344.800;
Cb=219.482;


xd=0.9;
xw=0.1;
F=250;                  %feed
R=3;                    %återflödesförhållande
% totalbalans + Komponent Ballans för att beräkna strömarnas storlekar
% ......(Kan göras med penna och papper)
D= ;
W= ;
L= ;                %vätskeflöde i övre delen
V= ;                %Ångflöde i övre delen
Lstrack= ;          %vätskeflöde i nedre delen
Vstrack= ;          %Ångflöde i nedre delen

%Först återkokaren
y0=5/3-5/(3+4.5*xw);    %Jämvikts villkoret
x11= ;         % KB återkokaren


% Avdrivardel   Stegning till feedbotten:
x(1)=x11;
i=0;

while x<xfa
    i=i+1;
    y(i)=5/3-5/(3+4.5*x(i));
    x(i+1)= ;               % Komponent ballans för avdrivar delen
end

m=i;

% Förstärkare
while y(i)<xd
    x(i+1)= ;   %Komponent ballans över förstärkar delen
    i=i+1;
    y(i)=5/3-5/(3+4.5*x(i)); %Jv samband
end

% värmebehov återkokare

% Beräkning av temperaturen i återkokaren  (Bubbelpunkt)

xwa=xw;
xwb=1-xwa;
error=1;
t=90;   % Start gissning. Bubbeelpunkt för feeden är : 80 grader c                               
while abs(error) > 0.001;
        t=t+0.0001;
        Pao=10^(Aa-Ba/(Ca+t)); % Antoines ekvation
        Pbo=10^(Ab-Bb/(Cb+t)); % Antoines ekvation
        ya= ;                  % Rault Dalton samband
        yb= ;                  % Rault Dalton samband
        error=1-ya-yb;
end
TK=t+273;           % Sammansättning ut ur återkokare
x1=y0;              % Komponent A
x2=1-y0;            % Komponent B

%Beräkning av entalpier i gasfas
aAg=0.69381e5;
bAg=0.6752e1;
cAg=0.13199;
aBg=0.31596e5;
bBg=0.15841e2;
cBg=0.15429;

HA=aAg+bAg*TK+cAg*TK^2;
HB=aBg+bBg*TK+cBg*TK^2;
Hblandningg=x1*HA+x2*HB;

%Entalpier vätskefas
aAv=0.19534e5;
bAv=0.63711e2;
cAv=0.12206;
aBv=-0.12588e5;
bBv=0.14150e2;
cBv=0.23130;

hA=aAv+bAv*TK+cAv*TK^2;
hB=aBv+bBv*TK+cBv*TK^2;
hblandningv=x1*hA+x2*hB;

qw= ;        % Ångbildningsvärme i kW
disp(['överförd effekt   ' num2str(round(qw)),'  W'])

disp(['bottnar nedre del    ' num2str(m)])

disp(['bottnar övre del     ' num2str(i-m)])

disp(['bottnar totalt       ' num2str(i)])

figure(1);
plot(1:i,y,'r');
hold on
plot(1:i,x);
legend('y1','x1');
ylabel('x1,y1');
xlabel('Botten nr (Räknat från återkokaren)');

% Minsta återflödesförhållandet

yfa=5/3-5/(3+4.5*xfa);
Rmin=(xd-yfa)/(yfa-xfa);            
disp(['Minsta återflödesförhålland:    ',num2str(Rmin)])
