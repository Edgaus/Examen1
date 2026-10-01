% imk
% imk(E) devuelve |Im k(E)|, distinto de cero solo dentro de las brechas de
% energia. Ahi la funcion de onda de la ecuacion (13) decae como exp(-|Im k| x),
% es decir 1/|Im k| es la longitud de penetracion de un estado de superficie.
% Dentro de las bandas se devuelve NaN para que el grafico quede limpio.
function [res] = imk(E)

vect = abs(imag(kv(E)));
vect(vect == 0) = NaN;
res = vect;

end
