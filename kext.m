% kext
% kext(E) devuelve el vector de onda en el esquema de zona extendida.

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
