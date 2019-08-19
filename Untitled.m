A=0.311/exp(-110*10^3/(8.31447*473));
H=1000;
I=[0 0.8];
h=0.01;
Fa0=10;
Fb0=20*Fa0;



N=(I(:,2)-I(:,1))/h;
        x=zeros(1,N)'; 
        U=zeros(1,N)';
        x(1)=I(:,1);
        U(1)=0;
 
        for i=1:N;
            x(i+1)=x(i)+h ;
            
F1=Fa0*(1-x(i));
F2=Fb0-Fa0*x(i);
F3=Fa0*x(i);
F=[F1 F2 F3];


Cpa=120;
Cpb=80;
Cpc=189;
Cp=[Cpa; Cpb; Cpc];

T=@(x)H*x/Cpa+473;
k=@(x) A*exp(-110*10^3/(8.31447*T(x))); 
f=@(x) Fa0/(k(x)*(1-x)) ;
             
            U(i+1)=U(i)+(h/2)*(f(x(i))+f(x(i+1)));
            
        end
      T(x)  
        plot (x,U)