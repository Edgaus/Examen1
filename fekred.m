% fekred
% Estructura de bandas de electrones libres plegada a la primera zona de
% Brillouin (esquema de zona reducida, 0 <= k <= pi/a). Es la forma en que k(E)
% devuelve el resultado del modelo KP, asi que esta es la curva con la que hay
% que comparar el KP con V0 = 0.
function [res] = fekred(E)

global a

res = acos(cos(fek(E)*a))/a;

end
