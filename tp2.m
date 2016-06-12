
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
soluciones = zeros(11,2,6,5);

figure(1,'Name', 'v(t) vs t','Position',[50,50,1600,750]);
figure(2,'Name', 'v´(t) vs t','Position',[50,50,1600,750]);
figure(3,'Name', 'v(t) vs v´(t)','Position',[50,50,1600,750]);
epsylon = 1;
for epsylon=1:5
  
  [T UEuler] = Euler(f,a,b,u0,h,epsylon);
  soluciones(:,:,1,epsylon) = UEuler;
  [T YRK2 ERK2]=rk2(f,a,b,u0,h,epsylon);
  soluciones(:,:,2,epsylon) = YRK2;
  [T YRK4]=rk4(f,a,b,u0,h,epsylon);
  soluciones(:,:,3,epsylon) = YRK4;
  % Metodos de paso fijo
  
  %falta ver la funcion a usar en nystrom
  [T YNys ENys]=nystrom('f_u',a,b,u0,h);
  soluciones(:,:,4,epsylon) = YNys;
  
  ode = @(t,u) uprima(t,u,epsylon);
  [t,u] = ode23(ode,0:0.1:1,u0,options);
  soluciones(:,:,5,epsylon) = u;
  [t,u] = ode45(ode,0:0.1:1,u0,options);
  soluciones(:,:,6,epsylon) = u;
  
  figure(1)
  subplot (2, 3, epsylon);
  plot(T,soluciones(:,1,1,epsylon),'c',T,soluciones(:,1,2,epsylon),'r',T,soluciones(:,1,3,epsylon),'g'
  ,T,soluciones(:,1,4,epsylon),'m',T,soluciones(:,1,5,epsylon),'-bo',T,soluciones(:,1,6,epsylon),'k');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('v(t)');
  ylabel('t');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','west');
  legend('boxoff');
  
  figure(2)
  subplot (2, 3, epsylon);
  plot(T,soluciones(:,2,1,epsylon),'c',T,soluciones(:,2,2,epsylon),'r',T,soluciones(:,2,3,epsylon),'g'
  ,T,soluciones(:,2,4,epsylon),'m',T,soluciones(:,2,5,epsylon),'-bo',T,soluciones(:,2,6,epsylon),'k');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('v´(t)');
  ylabel('t');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','west');
  legend('boxoff');
  
  figure(3)
  subplot (2, 3, epsylon);
  plot(soluciones(:,1,1,epsylon),soluciones(:,2,1,epsylon),'c',soluciones(:,1,2,epsylon),soluciones(:,2,2,epsylon),'r',soluciones(:,1,3,epsylon),soluciones(:,2,3,epsylon),'g'
  ,soluciones(:,1,4,epsylon),soluciones(:,2,4,epsylon),'m',soluciones(:,1,5,epsylon),soluciones(:,2,5,epsylon),'-bo',soluciones(:,1,6,epsylon),soluciones(:,2,6,epsylon),'k');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('v(t)');
  ylabel('v´(t)');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','west');
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



