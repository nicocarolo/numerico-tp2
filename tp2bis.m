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
%     [Euler => 1] Modificado porque Euler distinto h => distinto tamanio
%     [RK2 => 2]
%     [RK4 => 3]
%     [Nystrom => 4]
%     [ODE23 => 5] Modificado porque Ode23 distinto h => distinto tamanio
%     [ODE25 => 6] Modificado porque Ode45 distinto h => distinto tamanio
soluciones = zeros(((b-a)/h)+1,2,6,5);

figure(1,'Name', 'v(t) vs t','Position',[50,50,1600,750]);
figure(2,'Name', 'v´(t) vs t','Position',[50,50,1600,750]);
figure(3,'Name', 'v(t) vs v´(t)','Position',[50,50,1600,750]);
figure(4,'Name', 'v(t) vs t','Position',[50,50,1600,750]);
figure(5,'Name', 'v´(t) vs t','Position',[50,50,1600,750]);
figure(6,'Name', 'v(t) vs v´(t)','Position',[50,50,1600,750]);
figure(7,'Name', 'v(t) vs t','Position',[50,50,1600,750]);
figure(8,'Name', 'v´(t) vs t','Position',[50,50,1600,750]);
figure(9,'Name', 'v(t) vs v´(t)','Position',[50,50,1600,750]);
figure(10,'Name', 'v(t) vs t','Position',[50,50,1600,750]);
figure(11,'Name', 'v´(t) vs t','Position',[50,50,1600,750]);
figure(12,'Name', 'v(t) vs v´(t)','Position',[50,50,1600,750]);
figure(13,'Name', 'v(t) vs t','Position',[50,50,1600,750]);
figure(14,'Name', 'v´(t) vs t','Position',[50,50,1600,750]);
figure(15,'Name', 'v(t) vs v´(t)','Position',[50,50,1600,750]);
for epsylon=1:5
  
  [TEuler UEuler] = Euler(f,a,b,u0,0.0001,epsylon);
  
  [T YRK2 ERK2]=rk2(f,a,b,u0,h,epsylon);
  soluciones(:,:,2,epsylon) = YRK2;
  [T YRK4]=rk4(f,a,b,u0,h,epsylon);
  soluciones(:,:,3,epsylon) = YRK4;
  
  [T YNys]=nyst(f,a,b,u0,h,epsylon);  
  soluciones(:,:,4,epsylon) = YNys;
  
  ode = @(t,u) uprima(t,u,epsylon);
  [t23,u23] = ode23(ode,[a b],u0,options);
  [t45,u45] = ode45(ode,[a b],u0,options);
  
% Grafico de v(t) vs t
  figure((epsylon*3)-2)
  subplot (1, 1, 1);
  plot(TEuler,UEuler(:,1),'y',T,soluciones(:,1,2,epsylon),'m--',T,soluciones(:,1,3,epsylon),':c'
  ,T,soluciones(:,1,4,epsylon),'r',t23,u23(:,1),'-g',t45,u45(:,1),'-b');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('t');
  ylabel('v(t)');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','eastoutside');
  legend('boxoff');
%  print(strcat(num2str(epsylon),"vt.jpg"), "-djpg")
  close((epsylon*3)-2)
 % Grafico de v´(t) vs t
  figure((epsylon*3)-1)
  subplot (1, 1, 1);
  plot(TEuler,UEuler(:,2),'y',T,soluciones(:,2,2,epsylon),'m--',T,soluciones(:,2,3,epsylon),':c'
  ,T,soluciones(:,2,4,epsylon),'r',t23,u23(:,2),'-g',t45,u45(:,2),'-b');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('t');
  ylabel('v´(t)');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','eastoutside');
  legend('boxoff');
%  print(strcat(num2str(epsylon),"v´t.jpg"), "-djpg")
  close((epsylon*3)-1)
  
 % Grafico de v´(t) vs v(t)
  figure((epsylon*3))
  subplot (1, 1, 1);
  plot(UEuler(:,1),UEuler(:,2),'y',soluciones(:,1,2,epsylon),soluciones(:,2,2,epsylon),'m--',soluciones(:,1,3,epsylon),soluciones(:,2,3,epsylon),':c'
  ,soluciones(:,1,4,epsylon),soluciones(:,2,4,epsylon),'r',u23(:,1),u23(:,2),'g',u45(:,1),u45(:,2),'b');
  title(strcat('Epsylon = ' , num2str(epsylon)));
  xlabel('v(t)');
  ylabel('v´(t)');
  legend('Euler','RK2','RK4','Nystrom','ODE23','ODE45','Location','eastoutside');
  legend('boxoff');
%  print(strcat(num2str(epsylon),"vv´.jpg"), "-djpg")
  close((epsylon*3))
end