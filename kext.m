% kext
% kext(E) devuelve el vector de onda en el esquema de zona extendida.
%
% k(E) resuelve cos(ka) = F y devuelve acos(F)/a, que siempre cae en
% [0, pi/a]: todas las bandas quedan plegadas dentro de la primera zona.
% En el esquema extendido la banda n ocupa el intervalo [(n-1)pi/a, n pi/a],
% de modo que hay que desplegar una banda de cada dos:
%
%   n impar:  k = (n-1)*pi/a + acos(F)/a
%   n par:    k = n*pi/a     - acos(F)/a
%
% Las dos expresiones coinciden en los bordes de banda, donde acos(F)/a
% vale 0 o pi/a, asi que la curva resulta continua.
%
% Las bandas se identifican de dos maneras, porque una sola no basta:
% por los NaN que k(E) deja dentro de las brechas, y por los puntos donde
% acos(F)/a llega a un borde de zona y se regresa. Lo segundo hace falta
% cuando V0 = 0, caso en el que no hay brechas y por tanto no hay NaN.

function kE = kext(E)

    global a

    kr = k(E);
    kE = nan(size(kr));
    kb = pi/a;

    val = reshape(find(~isnan(kr)), 1, []);
    if isempty(val)
        return
    end

    % Cortes por brecha: val deja de ser consecutivo.
    corte = [1, reshape(find(diff(val) ~= 1) + 1, 1, []), numel(val) + 1];

    n = 0;
    for t = 1:numel(corte) - 1
        tramo = val(corte(t):corte(t+1) - 1);

        % Cortes por borde de zona: kr cambia de sentido.
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
