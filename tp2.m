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
soluciones = zeros(((b-a)/h)+1,2,6,5);

figure(1,'Name', 'v(t) vs t','Position',[50,50,1600,750]);
figure(2,'Name', 'v´(t) vs t','Position',[50,50,1600,750]);
figure(3,'Name', 'v(t) vs v´(t)','Position',[50,50,1600,750]);
for epsylon=1:5
  
  [T UEuler] = Euler(f,a,b,u0,h,epsylon);
  soluciones(:,:,1,epsylon) = UEuler;
  [T YRK2 ERK2]=rk2(f,a,b,u0,h,epsylon);
  soluciones(:,:,2,epsylon) = YRK2;
  [T YRK4]=rk4(f,a,b,u0,h,epsylon);
  soluciones(:,:,3,epsylon) = YRK4;
  
  [T YNys]=nyst(f,a,b,u0,h,epsylon);
  
  soluciones(:,:,4,epsylon) = YNys;
  ode = @(t,u) uprima(t,u,epsylon);
  [t23,u23] = ode23(ode,[a b],u0,options);
  if (epsylon == 1)
      u23con1 = u23;
      t23con1 = t23;
  endif
  if (epsylon == 2)
      u23con2 = u23;
      t23con2 = t23;
  endif
  if (epsylon == 3)
      u23con3 = u23;
      t23con3 = t23;
  endif
  if (epsylon == 4)
      u23con4 = u23;
      t23con4 = t23;
  endif
  if (epsylon == 5)
      u23con5 = u23;
      t23con5 = t23;
  endif
%  t23'
%  soluciones(:,:,5,epsylon) = u;
  [t45,u45] = ode45(ode,[a b],u0,options);
  if (epsylon == 1)
      u45con1 = u45;
      t45con1 = t45;
  endif
  if (epsylon == 2)
      u45con2 = u45;
      t45con2 = t45;
  endif
  if (epsylon == 3)
      u45con3 = u45;
      t45con3 = t45;
  endif
  if (epsylon == 4)
      u45con4 = u45;
      t45con4 = t45;
  endif
  if (epsylon == 5)
      u45con5 = u45;
      t45con5 = t45;
  endif
%  soluciones(:,:,6,epsylon) = u;
  
% Grafico de v(t) vs t
  figure(1)
  subplot (3, 2, epsylon);
  plot(T,soluciones(:,1,1,epsylon),'c',T,soluciones(:,1,2,epsylon),'r',T,soluciones(:,1,3,epsylon),'g'
  ,T,soluciones(:,1,4,epsylon),'m',t23,u23(:,1),'-.b',t45,u45(:,1),'-k');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('t');
  ylabel('v(t)');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','eastoutside');
  legend('boxoff');
  
 % Grafico de v´(t) vs t
  figure(2)
  subplot (3, 2, epsylon);
  plot(T,soluciones(:,2,1,epsylon),'c',T,soluciones(:,2,2,epsylon),'r',T,soluciones(:,2,3,epsylon),'g'
  ,T,soluciones(:,2,4,epsylon),'m',t23,u23(:,2),'-.b',t45,u45(:,2),'-k');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('t');
  ylabel('v´(t)');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','eastoutside');
  legend('boxoff');
  
 % Grafico de v´(t) vs v(t)
  figure(3)
  subplot (3, 2, epsylon);
  plot(soluciones(:,1,1,epsylon),soluciones(:,2,1,epsylon),'c',soluciones(:,1,2,epsylon),soluciones(:,2,2,epsylon),'r',soluciones(:,1,3,epsylon),soluciones(:,2,3,epsylon),'g'
  ,soluciones(:,1,4,epsylon),soluciones(:,2,4,epsylon),'m',u23(:,1),u23(:,2),'-.b',u45(:,1),u45(:,2),'-k');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('v(t)');
  ylabel('v´(t)');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','eastoutside');
  legend('boxoff');
end