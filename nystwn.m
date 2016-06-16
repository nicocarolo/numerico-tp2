function [T U]=nystwn(f,a,b,U0,h,epsylon)
%h = 0.5;
M=(b-a)/h;
T=zeros(M+1,1);
U=zeros(M+1,2);
E=zeros(M+1,1);
U(1,:)=U0;
T(1)=a;
%T(2)=a+h;

q1= h*feval(f,T(1),U(1,:),epsylon);
q2= h*feval(f,T(1)+h,U(1,:)+q1,epsylon);
 
 % Calculo del valor de U en el paso siguiente.
U(2,:) = U(1,:) + (q1+q2)/2;

for j=2:M
    T(j)=a+h;
    Xn = U(j,1);
    XnMenosUno = U(j-1,1);
    
    termA = Xn*(2-h^2);
    termB = XnMenosUno*(-1-(h-(h*(1-Xn^2))/2));
    termC = (1-(h-(h*(1-Xn^2))/2));
    U(j+1,1) = (termA+termB)/termC;
    "primera"
    U(j+1,1)
    U(j+1,1) = (U(j,1)*(2-h^2)+U(j-1,1)*(-1+(h*epsylon*(1-U(j,1)))/2))/(1+(h*epsylon*(1-U(j,1)))/2);
    "segunda"
    U(j+1,1)

%   Despeje mio
    U(j+1,1) = ((((-1)*h/2)*(1-(U(j,1))^2)*U(j-1,1))-U(j-1,1)-(U(j,1)*h^2)+(2*U(j,1)))/(1-((h/2)*(1-U(j,1))^2));
    "tercera"
    U(j+1,1)
end
U(:,1)'