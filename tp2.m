%      v    v'
%    | u0  v0 |
% U =| u1  v1 |
%    | ..  .. |

pkg load odepkg;
f = 'uprima';
a = 0;
b = 30;
u0 = [1 0];
h = 0.01;
%
options = odeset;

%        Matriz de soluciones:
%4ta columna = indice epsylon [1,2,..,5]
%3er columna = indice metodo
%     [Euler => 1]
%     [RK2 => 2]
%     [RK4 => 3]
%     [Nystrom => 4]
%     [ODE23 => 5]
%     [ODE25 => 6]
soluciones = zeros(3001,2,6,5);

figure(1,'Name', 'v(t) vs t','Position',[50,50,1600,750]);
figure(2,'Name', 'v´(t) vs t','Position',[50,50,1600,750]);
figure(3,'Name', 'v(t) vs v´(t)','Position',[50,50,1600,750]);
%epsylon = 1;
for epsylon=1:1
  
  [T UEuler] = Euler(f,a,b,u0,h,epsylon);
  soluciones(:,:,1,epsylon) = UEuler;
  [T YRK2 ERK2]=rk2(f,a,b,u0,h,epsylon);
  soluciones(:,:,2,epsylon) = YRK2;
  [T YRK4]=rk4(f,a,b,u0,h,epsylon);
  soluciones(:,:,3,epsylon) = YRK4;
  
%  T'
  %falta ver la funcion a usar en nystrom
  [T YNys]=nyst(f,a,b,u0,h,epsylon);
%  T'
%  YRK2'
  YNys'
  
  soluciones(:,:,4,epsylon) = YNys;
  ode = @(t,u) uprima(t,u,epsylon);
  [t,u] = ode23(ode,a:h:b,u0,options);
  soluciones(:,:,5,epsylon) = u;
  [t,u] = ode45(ode,a:h:b,u0,options);
  soluciones(:,:,6,epsylon) = u;
  
% Grafico de v(t) vs t
  figure(1)
  subplot (3, 2, epsylon);
  plot(T,soluciones(:,1,1,epsylon),'c',T,soluciones(:,1,2,epsylon),'r',T,soluciones(:,1,3,epsylon),'g'
  ,T,soluciones(:,1,4,epsylon),'m',T,soluciones(:,1,5,epsylon),'-b',T,soluciones(:,1,6,epsylon),'k');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('t');
  ylabel('v(t)');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','eastoutside');
  legend('boxoff');
  
 % Grafico de v´(t) vs t
  figure(2)
  subplot (3, 2, epsylon);
  plot(T,soluciones(:,2,1,epsylon),'c',T,soluciones(:,2,2,epsylon),'r',T,soluciones(:,2,3,epsylon),'g'
  ,T,soluciones(:,2,4,epsylon),'m',T,soluciones(:,2,5,epsylon),'-b',T,soluciones(:,2,6,epsylon),'k');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('t');
  ylabel('v´(t)');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','eastoutside');
  legend('boxoff');
  
 % Grafico de v´(t) vs v(t)
  figure(3)
  subplot (3, 2, epsylon);
  plot(soluciones(:,1,1,epsylon),soluciones(:,2,1,epsylon),'c',soluciones(:,1,2,epsylon),soluciones(:,2,2,epsylon),'r',soluciones(:,1,3,epsylon),soluciones(:,2,3,epsylon),'g'
  ,soluciones(:,1,4,epsylon),soluciones(:,2,4,epsylon),'m',soluciones(:,1,5,epsylon),soluciones(:,2,5,epsylon),'-b',soluciones(:,1,6,epsylon),soluciones(:,2,6,epsylon),'k');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('v(t)');
  ylabel('v´(t)');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','eastoutside');
  legend('boxoff');
end
% printf (resultado con z = %d\n, z)
%hold
%plot(T,UEuler,'r');
%hold
%plot(T,YRK2,'c');
%
%printf ("resultado con Euler\n")
%soluciones(:,1,1,1) %Euler con epsylon 1
%printf ("resultado con RK2\n")
%soluciones(:,:,2,1) %RK2 con epsylon 1
%printf ("resultado con RK4\n)"
%soluciones(:,:,3,1) %RK4 con epsylon 1
%printf ("resultado con Nystrom\n")
%soluciones(:,:,4,1) %Nystrom con epsylon 1
%printf ("resultado con ODE23\n")
%soluciones(:,:,5,1) %ODE23 con epsylon 1
%printf ("resultado con ODE45\n")
%soluciones(:,:,6,1) %ODE45 con epsylon 1



