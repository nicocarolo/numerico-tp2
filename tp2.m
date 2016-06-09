%function [T U]=Euler_SEDO(f,a,b,u0,h)
%      v    v' 
%    | u0  v0 |
% U =| u1  v1 |
%    | ..  .. |

pkg load odepkg;
f = 'uprima';
a = 0;
b = 1;
u0 = [1 0];
h = 0.1;
%
%options = odeset;
%ode = @(t,u) uprima(t,u);
%[t,u] = ode23(ode,[0 1],u0,options);


  cantIntervalos=(b-a)/h;
  N=length(u0);
  ptosIntervalo=zeros(cantIntervalos+1,1);
  U=zeros(cantIntervalos+1,N);
  ptosIntervalo=a:h:b;
  ptosIntervalo=ptosIntervalo';

  for i=1:N
   U(1,i)=u0(i);
  end

  for j=1:cantIntervalos
   U(j+1,:)=U(j,:)+h*feval(f,ptosIntervalo(j),U(j,:));
  end
  
  
  printf ("resultado con z =  %d\n")
  plot(ptosIntervalo,U(:,1),'c',ptosIntervalo,U(:,2),'r');
  ptosIntervalo
  U