function [] = miniprojekt3(f,xf,Pt,s,I)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


    
    
   P=[Pt, Pt*3];                    % I uppgift 3 så skall två olika
    
                                   % tryck beskrivas därför lägs detta vilkor till
    
    
    if f==4 | f==5 | f==6
        x=linspace(0,1,10);            %I uppgrt 4 skall vi plotta upp xi mot yi
                                        % därför behöver vi lägga till
                                        % detta vilkor som gör om xi till
                                        % en väktor.
        xi=[x',(1-x)'];
    else
        xi=[xf,(1-xf)];
    end
    
    
        PkokAce=56;                     % kokpunkter för de molekyler som finns i systemen
        PkokMet=64.7;
        PkokEta=78.4;
        PkokMety=56.9;
        PkokEty=77.1;
        Pkoknhex=69;
        PkokBen=80.1;
        
        if s==1                                                             %för att få ett bra start värde på 
            T=xi(1)*PkokAce+xi(2)*PkokMet;                                  % temperaturen in i looparan används denna algoritm
        elseif s==2
            T=xi(1)*PkokMety+xi(2)*PkokMet;                                 % som utnytjar koponenternas kokpunkt och dess molbråk
        elseif s==3
            T=xi(1)*PkokAce+xi(2)*PkokEty;                                  % för att ge ett medelvärde mellan dessa.
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
        
        del12=[0.65675; 0.60396; 0.62551; 0.73666; 0.53015];                % Wilsonparametsar för de olika systemen
        del21=[0.77204; 0.47071; 0.49384; 0.62367; 1.07005];
        del=[del12, del21];
        
        if s==1
            r=[1 2];                %r behövs för att selektivt välja ut 
        elseif s==2                 % wilsonparameter till rätt system
            r=[4 2];
        elseif s==3
            r=[2 5];
        elseif s==4
            r=[5 3];
        elseif s==5
            r=[6 7];
        end
            
            
            
            
        gam1=(1/(xi(1)+del(r(1))*xi(2)))+exp(xi(2)*(del(r(1))/(xi(1)...     % Här räknas aktivitets
            +del(r(1))*xi(2))-del(r(2))/(del(r(2))*xi(1)+xi(2))));          % faktorerna fram 
        
        gam2=(1/(xi(2)+del(r(2))*xi(1)))+exp(xi(1)*(del(r(1))/(xi(1)...
            +del(r(1))*xi(2))-del(r(2))/(del(r(2))*xi(1)+xi(2))));
        
            if f==4 | f==5 | f==6                                                 % efresom vi i uppgift 4 och
               k=1:10;                                                      % 5 skall plotta mot flera värden på xf
            else
                k=1;                                                        % sätter vi här ett vilkor för att loparna skall lopa fram vektorer.
            end
            
            
            y11=1;
            y21=1;
           for j=k
                  for i=1:10000                                             % Här är loparna som 
                    P101=10^(A(r(1))-B(r(1))/(T+C(r(1))));               % räknar fram molbråken
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
                  disp('ideal vätskeblandning')                             %den här delen utav funktionen behandlar de individuella 
                  disp('y=')                                                %frågorna. Och ser till att man endast får utt svaren för rätt fråga.
                  disp(y11)
                  disp(y21)
              elseif I==2
                  disp('ickeideal vätskeblandning')
                  disp('y=')
                  disp(y12)
                  disp(y22)
              end
             
          elseif f==2
            
           
              if I==1
                  ak=(y11/xi(1))/(y21/xi(2));                         % vilkoret för I anväds för att kunna få ut både för det ideeala fallet 
                  disp('Relativflyktighet')                                 %Och för det icke ideeala fallet.
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
                  disp(' Den rälativaflyktighetens tryck beroende')
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
                
                    A=[ones(length(P),1) P'];                               %för att tareda på den relativaflycktigheten  
                    x=A\ak';                                                %används min. kvadrat metoden för att ta fram en 
                    m=x(1); k=x(2);                                         % rät linje mellan de olika punkterna
                    T=linspace(min(P),max(P));
                    Y=k*T+m;
                    
                    plot(T,Y)
                    hold off
                  disp(' Den rälativaflyktighetens tryck beroende')
                  disp('k=')
                  disp(k)
              end
                            
         elseif f==4
             
             
             if I==1
                plot(xi(:,1)',y11)                                          %samman sättningen plottas så också en
                hold on
                plot([0 1], [0 1],'k')                                      % referens linje som går från 0-1
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
                                                                         % ingen azeotrop hittades då den relativa flyktigheten aldrig är =1
                                                                            % men för andra tryck än för atmosfärstryck kan ak sjunka under 1 
              
          elseif f==7
              
                     
              
              
              
              
          end
    
end



