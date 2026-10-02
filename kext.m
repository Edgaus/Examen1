% kext
% kext(E) devuelve el vector de onda en el esquema de zona extendida.
%
% k(E) resuelve cos(ka) = F y devuelve acos(F)/a, que siempre cae en
% [0, pi/a]: todas las bandas quedan plegadas dentro de la primera zona.
% En el esquema extendido la banda n ocupa el intervalo [(n-1)pi/a, n pi/a]:
%
%   n impar:  k = (n-1)*pi/a + acos(F)/a
%   n par:    k = n*pi/a     - acos(F)/a
%
% Las bandas se identifican por los NaN de las brechas y, si V0 = 0
% (no hay NaN), por los puntos donde k llega a un borde de zona y se
% regresa.

function kE = kext(E)

    global a

    kr = k(E);
    kE = nan(size(kr));
    kb = pi/a;

    val = reshape(find(~isnan(kr)), 1, []);
    if isempty(val)
        return
    end

    corte = [1, reshape(find(diff(val) ~= 1) + 1, 1, []), numel(val) + 1];

    n = 0;
    for t = 1:numel(corte) - 1
        tramo = val(corte(t):corte(t+1) - 1);

        if numel(tramo) >= 3
            s = sign(diff(kr(tramo)));
            s(s == 0) = 1;
            sub = [1, reshape(find(diff(s) ~= 0) + 1, 1, []), numel(tramo) + 1];
        else
            sub = [1, numel(tramo) + 1];
        end

        for u = 1:numel(sub) - 1
            idx = tramo(sub(u):sub(u+1) - 1);
            n = n + 1;
            if mod(n, 2) == 1
                kE(idx) = (n-1)*kb + kr(idx);
            else
                kE(idx) = n*kb - kr(idx);
            end
        end
    end
end
