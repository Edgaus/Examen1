function [rkvE, ikvE, kextE] = k(E)
% k(E)  parte real de kv(E); NaN dentro de las brechas.
% Segunda salida: parte imaginaria (estados de superficie).
% Tercera salida: k en el esquema de zona extendida.

    global a

    kE   = kv(E);
    ikvE = imag(kE);
    rkvE = real(kE);
    rkvE(abs(ikvE) > 1e-10) = NaN;

    if nargout < 3
        return
    end

    % Despliega la banda n al intervalo [(n-1)pi/a, n pi/a].
    % Cortes: NaN de las brechas, y (si V0 = 0) el cambio de sentido en el
    % borde de zona.
    kr = rkvE;
    kextE = nan(size(kr));
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
                kextE(idx) = (n-1)*kb + kr(idx);
            else
                kextE(idx) = n*kb - kr(idx);
            end
        end
    end
end
