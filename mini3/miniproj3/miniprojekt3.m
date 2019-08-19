function [] = miniprojekt3(f,xf,Pt,s,I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


    
    
   P=[Pt, Pt*3];                    % I uppgift 3 s� skall tv� olika
    
                                   % tryck beskrivas d�rf�r l�gs detta vilkor till
    
    
    if f==4 | f==5 | f==6
        x=linspace(0,1,10);            %I uppgrt 4 skall vi plotta upp xi mot yi
                                        % d�rf�r beh�ver vi l�gga till
                                        % detta vilkor som g�r om xi till
                                        % en v�ktor.
        xi=[x',(1-x)'];
    else
        xi=[xf,(1-xf)];
    end
    
    
        PkokAce=56;                     % kokpunkter f�r de molekyler som finns i systemen
        PkokMet=64.7;
        PkokEta=78.4;
        PkokMety=56.9;
        PkokEty=77.1;
        Pkoknhex=69;
        PkokBen=80.1;
        
        if s==1                                                             %f�r att f� ett bra start v�rde p� 
            T=xi(1)*PkokAce+xi(2)*PkokMet;                                  % temperaturen in i looparan anv�nds denna algoritm
        elseif s==2
            T=xi(1)*PkokMety+xi(2)*PkokMet;                                 % som utnytjar koponenternas kokpunkt och dess molbr�k
        elseif s==3
            T=xi(1)*PkokAce+xi(2)*PkokEty;                                  % f�r att ge ett medelv�rde mellan dessa.
        elseif s==4
            T=xi(1)*PkokEta+xi(2)*PkokEty;
        elseif s==5
            T=xi(1)*Pkoknhex+xi(2)*PkokBen;
        end
        
        A=[7.02447; 7.87863; 8.04494; 7.20211;...                           % Antoinekonstanter (mmHg och C)
            7.09803; 6.87776; 6.90565];
        B=[1161.00; 1473.11; 1554.30; 1232.83; ...
            1238.71; 1171.53; 1211.03];
        C=[224.0; 230.0; 222.65; 228.0; ...
            217.0; 224.37; 220.79];
        
        del12=[0.65675; 0.60396; 0.62551; 0.73666; 0.53015];                % Wilsonparametsar f�r de olika systemen
        del21=[0.77204; 0.47071; 0.49384; 0.62367; 1.07005];
        del=[del12, del21];
        
        if s==1
            r=[1 2];                %r beh�vs f�r att selektivt v�lja ut 
        elseif s==2                 % wilsonparameter till r�tt system
            r=[4 2];
        elseif s==3
            r=[2 5];
        elseif s==4
            r=[5 3];
        elseif s==5
            r=[6 7];
        end
            
            
            
            
        gam1=(1/(xi(1)+del(r(1))*xi(2)))+exp(xi(2)*(del(r(1))/(xi(1)...     % H�r r�knas aktivitets
            +del(r(1))*xi(2))-del(r(2))/(del(r(2))*xi(1)+xi(2))));          % faktorerna fram 
        
        gam2=(1/(xi(2)+del(r(2))*xi(1)))+exp(xi(1)*(del(r(1))/(xi(1)...
            +del(r(1))*xi(2))-del(r(2))/(del(r(2))*xi(1)+xi(2))));
        
            if f==4 | f==5 | f==6                                                 % efresom vi i uppgift 4 och
               k=1:10;                                                      % 5 skall plotta mot flera v�rden p� xf
            else
                k=1;                                                        % s�tter vi h�r ett vilkor f�r att loparna skall lopa fram vektorer.
            end
            
            
            y11=1;
            y21=1;
           for j=k
                  for i=1:10000                                             % H�r �r loparna som 
                    P101=10^(A(r(1))-B(r(1))/(T+C(r(1))));               % r�knar fram molbr�ken
                    y11(j)=P101*xi(j,1)/P(1);                            % i gas fasen
                    
                    P201=10^(A(r(2))-B(r(2))/(T+C(r(2))));
                    y21(j)=P201*xi(j,2)/P(1);
                    
                    if y11(j)+y21(j)<1
                        T=T+0.1;
                    elseif y11(j)+y21(j)>1
                        T=T-0.1;
                    end
                    
                  end
                
                
                y12(j)=1;
                y22(j)=1;
                  for i=1:10000
                    P102=10^(A(r(1))-B(r(1))/(T+C(r(1))));
                    y12(j)=P102.*xi(j,1).*gam1./P(1);
                    
                    P202=10^(A(r(2))-B(r(2))/(T+C(r(2))));
                    y22(j)=P202*xi(j,2)*gam2/P(1);
                    
                    if y12(j)+y22(j)<1
                        T=T+0.1;
                    elseif y12(j)+y22(j)>1
                        T=T-0.1;
                    end
                  end
                  
             if f==3
                  
                y111(j)=0;
                y211(j)=0;
               for i=1:10000
                    P1011=10^(A(r(1))-B(r(1))/(T+C(r(1)))); %#ok<*AGROW>
                    y111(j)=P1011*xi(j,1)*gam1/P(2);
                    
                    P2011=10^(A(r(2))-B(r(2))/(T+C(r(2))));
                    y211(j)=P2011*xi(j,2)*gam2/P(2);
                    
                    if y111(j)+y211(j)<1
                        T=T+0.1;
                    elseif y111(j)+y211(j)>1
                        T=T-0.1;
                    end
                end
                
               y112(j)=0;
               y212(j)=0;
               for i=1:10000
                    P1021=10^(A(r(1))-B(r(1))/(T+C(r(1))));
                    y112(j)=P1021*xi(j,1)*gam1/P(2);
                    
                    P2021=10^(A(r(2))-B(r(2))/(T+C(r(2))));
                    y212(j)=P2021*xi(j,2)*gam2/P(2);
                    
                    if y112(j)+y212(j)<1
                        T=T+0.1;
                    elseif y112(j)+y212(j)>1
                        T=T-0.1;
                    end
                end
             end
            end
            
          if f==1
              if I==1
                  disp('ideal v�tskeblandning')                             %den h�r delen utav funktionen behandlar de individuella 
                  disp('y=')                                                %fr�gorna. Och ser till att man endast f�r utt svaren f�r r�tt fr�ga.
                  disp(y11)
                  disp(y21)
              elseif I==2
                  disp('ickeideal v�tskeblandning')
                  disp('y=')
                  disp(y12)
                  disp(y22)
              end
             
          elseif f==2
            
           
              if I==1
                  ak=(y11/xi(1))/(y21/xi(2));                         % vilkoret f�r I anv�ds f�r att kunna f� ut b�de f�r det ideeala fallet 
                  disp('Relativflyktighet')                                 %Och f�r det icke ideeala fallet.
                  disp('ak')
                  disp(ak)
              elseif I==2
                  ak=(1/(xi(1)/y12))/(1/(xi(2)/y22));
                  disp('Relativflyktighet')
                  disp('ak')
                  disp(ak)
              end
              
          elseif f==3
              
              if I==1
                  ak=[(1/(xi(1)/y11))/(1/(xi(2)/y21)), (1/(xi(1)/y111))/(1/(xi(2)/y211))] ;
                  disp('Relativflyktighet')
                  disp('ak Pt [P P*2]')
                  disp(ak)
                  
                  
                  
                  plot(P(1),ak(1),'*')
                  hold on
                  plot(P(2),ak(2),'*')
                
                    A=[ones(length(P),1) P'];
                    x=A\ak';
                    m=x(1); k=x(2);
                    T=linspace(min(P),max(P));
                    Y=k*T+m;
                    
                    plot(T,Y)
                    hold off
                  disp(' Den r�lativaflyktighetens tryck beroende')
                  disp('k=')
                  disp(k)
                  
              elseif I==2
                  ak=[(y12/xi(1))/(y22/xi(2)), (y112/xi(1))/(y212/xi(2))] ;
                  disp('Relativflyktighet')
                  disp('ak Pt [P P*2]')
                  disp(ak)
                  
                  
                  
                  plot(P(1),ak(1),'*')
                  hold on
                  plot(P(2),ak(2),'*')
                
                    A=[ones(length(P),1) P'];                               %f�r att tareda p� den relativaflycktigheten  
                    x=A\ak';                                                %anv�nds min. kvadrat metoden f�r att ta fram en 
                    m=x(1); k=x(2);                                         % r�t linje mellan de olika punkterna
                    T=linspace(min(P),max(P));
                    Y=k*T+m;
                    
                    plot(T,Y)
                    hold off
                  disp(' Den r�lativaflyktighetens tryck beroende')
                  disp('k=')
                  disp(k)
              end
                            
         elseif f==4
             
             
             if I==1
                plot(xi(:,1)',y11)                                          %samman s�ttningen plottas s� ocks� en
                hold on
                plot([0 1], [0 1],'k')                                      % referens linje som g�r fr�n 0-1
                hold off
                axis([0 1 0 1])
             elseif I==2
                plot(xi(:,1),y12)
                hold on
                plot([0 1], [0 1],'k')
                hold off
                axis([0 1 0 1]) 
             end
          elseif f==5
              
              
              
                  ak=(y12./xi(:,1)')./(y22./xi(:,2)');
                  disp('Relativflyktighet')
                  disp('ak Pt ')
                  plot(xi(:,1)',ak)
                 
          elseif f==6
              ak=(y12./xi(:,1)')./(y22./xi(:,2)');
              if min(ak)<1
                  disp('ja')
              else
              disp('Nej') 
              end
                                                                         % ingen azeotrop hittades d� den relativa flyktigheten aldrig �r =1
                                                                            % men f�r andra tryck �n f�r atmosf�rstryck kan ak sjunka under 1 
              
          elseif f==7
              
                     
              
              
              
              
          end
    
end



