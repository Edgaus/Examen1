% kext
% kext(E) desdobla k(E) al esquema de zona extendida: la banda n se traslada al
% intervalo [(n-1)pi/a, n pi/a] para poder compararla con la parabola de
% electrones libres fek(E).
%
% El indice de banda se incrementa cada vez que la curva llega a un borde de
% zona, que se detecta de dos maneras: porque k(E) devuelve NaN (hay brecha) o
% porque k(E) invierte su sentido de variacion (bordes sin brecha, p.ej. V0 = 0).
%
% E debe ser un vector ordenado de forma creciente.
function [res] = kext(E)

global a

kr  = k(E);
res = nan(size(kr));

n      = 1;      % indice de banda
dir    = 1;      % +1 si k crece con E en esta banda, -1 si decrece
prev   = NaN;
enbrecha = false;

for j = 1:1:length(kr)
    if isnan(kr(j))
        enbrecha = true;
        continue;
    end

    if enbrecha
        n = n + 1;  dir = -dir;  prev = NaN;  enbrecha = false;
    elseif ~isnan(prev) && (kr(j) - prev)*dir < 0
        n = n + 1;  dir = -dir;
    end

    if mod(n, 2) == 1
        res(j) = (n - 1)*pi/a + kr(j);
    else
        res(j) = n*pi/a - kr(j);
    end

    prev = kr(j);
end

end
