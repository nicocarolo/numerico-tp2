function [T U E]=nystrom(f_u,a,b,U0,h)
M=(b-a)/h;
T=zeros(M+1,1);
U=zeros(M+1,2);
E=zeros(M+1,1);
U(1,:)=U0;

% Energia
E(1)=Energia(U(1,:));
T(1)=a;
% Uso las condiciones iniciales para encontrar U(2).
% Calculo la otra condición a partir de Taylor
U(2,1)=U0(1)+h*U0(2)+h^2/2*feval(f_u,a,U0(1));
T(2)=a+h;
for j=2:M
 % Valor del tiempo posterior.
 T(j+1)=a+j*h;
 % Calculo los valores de U en n+1.
 % Usamos Nystrom
 U(j+1,1)=2*U(j,1)-U(j-1,1)+h^2*feval( f_u, T(j), U(j,1));
 % Estimo la derivada.
 U(j,2)=(U(j+1,1)-U(j-1,1))/(2*h);
 % Energia
 E(j)=Energia(U(j,:));
end
% Uso el valor del predictor para M+1.
U(M+1,2)=(U(M+1,1)-U(M,1))/h;
% Energia
E(M+1)=Energia(U(M+1,:));

function out=Energia(u)
%% Función a evaluar
% En principio va a depender de t (no autonomo) y de u, no de u'.
%
out=[1/2*u(2)^2+1/2*u(1)^2*(1+1/2*u(1)^2)];
