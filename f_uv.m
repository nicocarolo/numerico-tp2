function out=f_uv(t,u)
%% Función a evaluar
% En principio va a depender de t (no autonomo) y de u, no de u'.
%
out=[u(2) -u(1)*(1+u(1)^2)];
