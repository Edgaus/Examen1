% beta
% beta calcula beta = sqrt(2*me*(E-V0)/hbar^2), el vector de onda en la region I
% (la barrera, V = V0) segun la ecuacion (3).
%
% Para E < V0 el radicando es negativo y beta resulta imaginario puro. No hay
% que evitarlo: se trabaja con aritmetica compleja y F(E) sigue siendo real
% (cos -> cosh y sin -> i*sinh), que es justamente el regimen de tunelamiento.
function [res] = beta(E)

global me hbar V0

res = sqrt(2*me*(E - V0))/hbar;

end
