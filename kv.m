% kv
% kv(E) despeja k de la ecuacion (10): k = acos(F(E))/a.
%
% El resultado es complejo en general: dentro de una banda |F| <= 1 y k es real
% (0 <= k <= pi/a, esquema de zona reducida); dentro de una brecha |F| > 1 y
% acos devuelve una parte imaginaria, que es la que describe los estados de
% superficie (ecuacion 13).
function [res] = kv(E)

global a

res = acos(F(E))/a;

end
