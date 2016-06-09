
function [T U E]=RK2(f,T0,U0,h)
a=T0(1);
b=T0(2);
M=(b-a)/h;
T=zeros(M+1,1);
U=zeros(M+1,2);
E=zeros(M+1,1);
U(1,:)=U0;
T(1)=a;
% Energia
E(1)=Energia(U(1,:));
for j=1:M
 % Valor del tiempo posterior.
 T(j+1)= a+j*h;
 % Calculo del q1 y q2.
 q1= h*feval(f,T(j),U(j,:));
 q2= h*feval(f,T(j)+h,U(j,:)+q1);
 % Calculo del valor de U en el paso siguiente.
 U(j+1,:) = U(j,:) + (q1+q2)/2;
 % Energia
 E(j+1)=Energia(U(j+1,:));
end

function out=f_u(t,u)
%% Función a evaluar
% En principio va a depender de t (no autonomo) y de u, no de u'.
%
out=[-u*(1+u^2)];

function out=Energia(u)
%% Función a evaluar
% En principio va a depender de t (no autonomo) y de u, no de u'.
%
out=[1/2*u(2)^2+1/2*u(1)^2*(1+1/2*u(1)^2)];
function out=f_uv(t,u)
%% Función a evaluar
% En principio va a depender de t (no autonomo) y de u, no de u'.
%
out=[u(2) -u(1)*(1+u(1)^2)];
