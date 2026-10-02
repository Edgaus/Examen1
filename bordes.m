function [Ef, Et, E2] = bordes(E)
% bordes localiza los bordes de banda sobre la malla de energia E.
%
%   Ef  fondo de la primera banda
%   Et  techo de la primera banda
%   E2  fondo de la segunda banda
%
% Se apoya en que k(E) devuelve NaN dentro de las brechas. Los valores
% quedan determinados con la resolucion del paso de E, asi que la brecha
% E2 - Et se sobreestima a lo mas en dos pasos de la malla.

    global a d V0 %#ok<NUSED>

    banda = ~isnan(k(E));

    i1 = find(banda, 1, 'first');
    if isempty(i1)
        error('bordes: no hay ninguna banda en el intervalo dado.')
    end

    i2 = find(~banda(i1:end), 1, 'first');
    if isempty(i2)
        error('bordes: la malla de energia no alcanza la primera brecha.')
    end
    i2 = i1 + i2 - 1;          % primer punto dentro de la brecha

    Ef = E(i1);
    Et = E(i2-1);

    if nargout > 2
        i3 = find(banda(i2:end), 1, 'first');
        if isempty(i3)
            error('bordes: la malla de energia no alcanza la segunda banda.')
        end
        E2 = E(i2 + i3 - 1);
    end
end
