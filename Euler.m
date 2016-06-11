function [T U]=Euler(f,a,b,u0,h,epsylon)

cantIntervalos=(b-a)/h;
N=length(u0);
T=zeros(cantIntervalos+1,1);
U=zeros(cantIntervalos+1,N);
T=a:h:b;
T=T';

for i=1:N
  U(1,i)=u0(i);
end

for j=1:cantIntervalos
  U(j+1,:)=U(j,:)+h*feval(f,T(j),U(j,:),epsylon);
end