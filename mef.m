% mef
% Masa efectiva normalizada a la masa del electron libre, ecuacion (15):
%
%   m* = hbar^2 (d2E/dk2)^-1
%
% Conviene calcularla con E como variable independiente. Si k = k(E), entonces
% dE/dk = 1/k'(E) y d2E/dk2 = -k''(E)/k'(E)^3, de donde
%
%   m*/me = -hbar^2 k'(E)^3 / (me k''(E))
%
% k'(E) es analitica (dkdE) y k'' se obtiene por diferencias centradas sobre
% ella con un paso h pequeno (por defecto 1e-4 eV).
function [res] = mef(E, h)

global me hbar

if nargin < 2
    h = 1e-4;
end

kp  = dkdE(E);
kpp = (dkdE(E + h) - dkdE(E - h))/(2*h);

res = -(hbar^2)*(kp.^3)./(me*kpp);

end
