function [f]=uprima(t,u,epsylon)
% v′′ − ε.(1 − v^2).v′ + δ.v = 0
f(1)=u(2);
f(2)=epsylon*(1-u(1)*u(1))*u(2)-u(1);