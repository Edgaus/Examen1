% bordes: fondo y techo de la 1a banda y fondo de la 2a banda, localizados a
% partir de los NaN que k(E) ya pone dentro de la brecha.
function [Efondo, Etecho, E2abanda] = bordes(E)
    rk = k(E);
    h  = isnan(rk);
    i1 = find(~h, 1);                      % primer punto permitido
    ig = i1 - 1 + find(h(i1:end), 1);      % primer punto de la 1a brecha
    i2 = ig - 1 + find(~h(ig:end), 1);     % primer punto de la 2a banda
    Efondo = E(i1);  Etecho = E(ig-1);  E2abanda = E(i2);
end