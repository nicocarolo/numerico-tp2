
%      v    v'
%    | u0  v0 |
% U =| u1  v1 |
%    | ..  .. |

% pkg load odepkg;
f = 'uprima';
a = 0;
b = 1;
u0 = [1 0];
h = 0.1;
%
%options = odeset;
%ode = @(t,u) uprima(t,u);
%[t,u] = ode23(ode,[0 1],u0,options);

%        Matriz de soluciones:
%4ta columna = indice epsylon [1,2,..,5]
%3er columna = indice metodo
%     [Euler => 1]
%     [RK2 => 2]
%     [RK4 => 3]
%     [Nystrom => 4]
%     [ODE23 => 5]
%     [ODE35 => 6]
soluciones = zeros(11,2,6,5);

epsylon = 1;
for epsylon=1:1
  
  [T UEuler] = Euler(f,a,b,u0,h,epsylon);
  soluciones(:,:,1,epsylon) = UEuler;
  [T YRK2 ERK2]=rk2(f,a,b,u0,h,epsylon);
  soluciones(:,:,2,epsylon) = YRK2;
  % Metodos de paso fijo
  
  %falta ver la funcion a usar en nystrom
  [T YNys ENys]=nystrom('f_u',a,b,Y0,h);
  soluciones(:,:,4,epsylon) = YNys;

end

% printf (resultado con z = %d\n, z)
%  plot(ptosIntervalo,U(:,1),'c',ptosIntervalo,U(:,2),'r');

soluciones(:,:,1,1) %Euler con epsylon 1
soluciones(:,:,2,1) %RK2 con epsylon 2
soluciones(:,:,4,1) %RK2 con epsylon 2

