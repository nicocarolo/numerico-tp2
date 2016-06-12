function [T U]=rk4(f,a,b,U0,h,epsylon)
M=(b-a)/h;
T=zeros(M+1,1);
U=zeros(M+1,2);
%E=zeros(M+1,1);
U(1,:)=U0;
T(1)=a;

%for i = 1:N
%   k1 = h*f(t(i), w(:,i));
%   k2 = h*f(t(i)+h/2, w(:,i)+0.5*k1);
%   k3 = h*f(t(i)+h/2, w(:,i)+0.5*k2);
%   k4 = h*f(t(i)+h, w(:,i)+k3);
%   w(:,i+1) = w(:,i) + (k1 + 2*k2 + 2*k3 + k4)/6;
%   t(i+1) = a + i*h;
%end

for j=1:M
 % Valor del tiempo posterior.
 T(j+1)= a+j*h;
 
 % Calculo del q1 y q2.
 q1= h*feval(f,T(j),U(j,:),epsylon);
 q2= h*feval(f,T(j)+h/2,U(j,:)+0.5*q1,epsylon);
 q3= h*feval(f,T(j)+h/2,U(j,:)+0.5*q2,epsylon);
 q4= h*feval(f,T(j)+h/2,U(j,:)+0.5*q3,epsylon);
 
 % Calculo del valor de U en el paso siguiente.
 U(j+1,:) = U(j,:) + (q1+2*q2+2*q3+q4)/6;
end