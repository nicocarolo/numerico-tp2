function [T U]=nyst(f,a,b,U0,h,epsylon)
M=(b-a)/h; % Cantidad de intervalos
T=zeros(M+1,1);
U=zeros(M+1,2);
%E=zeros(M+1,1);
U(1,:)=U0; % Condicional inicial
T(1)=a; % Primer punto
T(2)=a+h; % Segundo punto
tolerancia = 10^(-1);
%Calculo U(2,:) por RK2
q1= h*feval(f,T(1),U(1,:),epsylon);
q2= h*feval(f,T(1)+h,U(1,:)+q1,epsylon);
U(2,:) = U(1,:) + (q1+q2)/2;
for j=2:M
%   j
%  Valor del tiempo posterior.
   T(j+1)= a+j*h;
   
%  Calculo del q1 y q2.
   q1= h*feval(f,T(j),U(j,:),epsylon);
   q2= h*feval(f,T(j)+h,U(j,:)+q1,epsylon);
   
%  Calculo del valor de U en el paso siguiente.
   U(j+1,:) = U(j,:) + (q1+q2)/2;
%   UAux = U(j,:);
%   UMejorado = UAux;
%   primero = true;
%    j+1
%   U(j+1,:)
   for i=1:3
      estimacionDerivada = ((U(j+1,1)-U(j-1,1))/(2*h));
      evaluado = epsylon*(1-U(j,1)*U(j,1))*estimacionDerivada-U(j-1,1);
      U(j+1,1) = -1*U(j-1,1)+2*U(j,1)+(h^2)*evaluado;
      U(j,2) = estimacionDerivada;
      %     U(j+1,:) = (-1)*U(j-1,:)+2*U(j,:)+(h^2)*feval(f, T(j),[U(j,2) (U(j+1,1)-U(j-1,1))/2*h],epsylon);
%      U(j+1,:)
%      U(j+1,2) = (U(j+1,1)-U(j-1,1))/2*h;
   end
%   U(j+1,:)
%   while (norm(UMejorado - UAux,inf) > tolerancia || primero == true)
%%        UAux
%%        UMejorado
%        primero = false;
%        UAux = UMejorado;
%%       Nystrom
%        UMejorado=2*U(j,:)-U(j-1,:)+h^2*feval(f, T(j),(UMejorado-U(j-1,:))/2*h,epsylon);
%        
%   end
%   U(j,:) = UMejorado;

end