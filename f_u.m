function out=f_u(t,u)
%% Función a evaluar
% En principio va a depender de t (no autonomo) y de u, no de u'.
%
out=[-u*(1+u^2)];
