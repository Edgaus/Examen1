% dkdE
% Derivada dk/dE obtenida derivando implicitamente cos(k a) = F(E):
%
%   -a sin(k a) dk/dE = F'(E)   =>   dk/dE = -F'(E)/(a sqrt(1 - F^2))
%
% (se usa sin(k a) = +sqrt(1-F^2) porque k a esta en [0, pi]). Devuelve NaN
% dentro de las brechas.
function [res] = dkdE(E)

global a

Fv  = F(E);
res = -dFdE(E)./(a*sqrt(1 - Fv.^2));
res(abs(Fv) > 1) = NaN;

end
