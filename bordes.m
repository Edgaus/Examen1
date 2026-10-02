% bordes: fondo y techo de la 1a banda y fondo de la 2a banda, localizados a
% partir de los NaN que k(E) ya pone dentro de la brecha.
function [Efondo, Etecho, E2abanda] = bordes(E)
    rk = k(E);
    h  = isnan(rk);
    i1 = find(~h, 1);                      % primer punto permitido
    if isempty(i1)
        error('bordes: no hay k real. Revisa V0, a, d y que kv.m tome real(F).');
    end
    igrel = find(h(i1:end), 1);            % primer punto de la 1a brecha
    if isempty(igrel)
        error('bordes: no se vio la primera brecha. Usa un paso de E mas fino.');
    end
    ig = i1 - 1 + igrel;
    i2rel = find(~h(ig:end), 1);           % primer punto de la 2a banda
    if isempty(i2rel)
        error('bordes: no se vio la segunda banda. Sube el E maximo.');
    end
    i2 = ig - 1 + i2rel;
    Efondo = E(i1);  Etecho = E(ig-1);  E2abanda = E(i2);
end
