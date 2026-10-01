% fek
% Estructura de bandas exacta de electrones libres: k(E) = sqrt(2 me E/hbar^2),
% es decir la parabola E = hbar^2 k^2/(2 me) en esquema de zona extendida.
function [res] = fek(E)

global me hbar

res = sqrt(2*me*E)/hbar;

end
