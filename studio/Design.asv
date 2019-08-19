% Det här programmet beräknar designparametrar för ett destillationstorn. 
% Det tornet arbetar vid 760 mmHg. I tornet destilleras metanol
% och propanol så att det blir ganska rent. Just den här filen använder vi bara när vi
% skall räkna på det befintliga tornet och dess driftsbetingelser. För övriga beräkningar
% hänvisas till rating.m. 

clear all
close all

global Atorn

aVm=2.5;			%gasflöde kg/s
aLm=1;		 		%vätskeflöde kg/s
adrift=0.80;		%Drifthast./Gashastighet vid flödning

ae=0.08;			%Hur stor andel av totala tvärsnitsarean som utgörs av hål.
aandelfall=0.1;	    %Hur stor andel av totala tvärsnitsarean som utgörs av ett fallrör.
ahw=40;				%mm	fallrörskantens höjd
alw=0.700;			%m fallrörkantens längd
adh=4;				%mm håldiametern

arhoL=798;			%vätskans densitet kg/m3
arhoV=2.05;			%gasens densitet kg/m3
asigma=0.022;		%ytspänning N/m
amyL=0.0004;		%Pa,s  Vätskans viskositet
aDLK=3.6e-9;		%m2/s  Diffusivitet för light key


aFLV=aLm/aVm*sqrt(arhoV/arhoL); %Flödningsparameter

%figur 1 i utdelatmaterial, bottenavstånd 0,45m anpassar kurva
ax45=Log10([0.02 0.06 0.08 0.1 0.2 0.4 0.6 0.8 1.0]);
ay45=Log10([0.08 0.08 0.077 0.075 0.065 0.05 0.042 0.035 0.03]);
ap45=polyfit(ax45,ay45,4);
yanpassad=ap45(1).*ax45.^4+ap45(2).*ax45.^3+ap45(3).*ax45.^2+ap45(4).*ax45.^1+ap45(5);

aFLV=Log10(aFLV);
logak1=ap45(1)*aFLV.^4+ap45(2)*aFLV.^3+ap45(3)*aFLV.^2+ap45(4)*aFLV.^1+ap45(5);
ak1=10^logak1;
avn=ak1*sqrt((arhoL-arhoV)/arhoV)*(asigma/0.020)^0.20;
disp(' ')
disp(' ')
disp('Gashastighet vid flödning (m/s) (baserad på nettoarean) : ');
disp(avn);
disp(' ')

axhwhow=[12 17 20 27 40 48 60 80 100];
ayhwhow=[27 28 28.3 29 29.7 30 30.3 30.75 31];
aphwhow=polyfit(axhwhow,ayhwhow,4);
ahow=750*(aLm/(arhoL*alw))^(2/3); %vätskenivån över fallrörskanten
ahwhow=ahw+ahow;

%Motsvarar avläsning av K2 från figur 2 i utdelat material
ak2=aphwhow(1)*ahwhow.^4+aphwhow(2)*ahwhow.^3+aphwhow(3)*ahwhow.^2+aphwhow(4)*ahwhow.^1+aphwhow(5)*ahwhow.^0;

%Eduljee gråtning
avh=(ak2-0.90*(25.4-adh))/sqrt(arhoV);
disp('Gashastighet vid gråtning (m/s) (baserad på hålarean) : ')
disp(avh)
disp(' ')
avhol=avn*(1-aandelfall)/ae;
disp('Gashastighet vid flödning (m/s) (baserad på hålarean) : ');
disp(avhol);
disp(' ')
Atorn=aVm/(avn*adrift*arhoV*(1-aandelfall));
disp('Tornets tvärsnittsarea (m2) : ')
disp(Atorn)
adtorn=sqrt(Atorn*4/pi);
disp(' ')
disp('Tornets diameter (m) : ')
disp(adtorn)
disp(' ')
vdrifthol=aVm/(Atorn*ae)/arhoV;
disp('Ångans drifthastighet (m/s) (baserad på hålarean) : ')
disp(vdrifthol)
disp(' ')

%Hur många procent från flödning ligger driften?
pfranflod=(vdrifthol)/avhol*100;
disp('Hur långt från flödning som driften ligger (i%) drifthatighet/flödningshastighet: ')
disp(pfranflod)
disp(' ')

%Beräkning av bottenverkningsgrad
avV=aVm/Atorn/arhoV;
aDg=asigma/(amyL*avV);
aSc=amyL/(arhoL*aDLK);
aRe=(ahw/1000)*avV*arhoV/(amyL*ae);
aEmV=0.07*aDg^0.14*aSc^0.25*aRe^0.08;
disp('Murphree-bottenverkningsgraden beräknad med van Winkles korrelation : ')
disp(aEmV)