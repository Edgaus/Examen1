% kext
% kext(E) devuelve el vector de onda en el esquema de zona extendida.
%
% En una banda k es real. La banda n ocupa [(n-1)*pi/a, n*pi/a]:
%   n impar:  k = (n-1)*pi/a + kr
%   n par:    k = n*pi/a     - kr
%
% En una brecha k es imaginario. Esa brecha cierra contra el borde
% n*pi/a, asi que se despliega como
%   k = n*pi/a + i*Im(k)
% con el signo de Im(k) que ya trae acos. Si no hay brechas, la salida
% sigue siendo real.

function kE = kext(E)

    global a

    [kr, ki] = k(E);
    kE = nan(size(kr));
    kb = pi/a;

    permitido = reshape(~isnan(kr), 1, []);
    N = numel(kr);
    if N == 0
        return
    end

    % n es el numero de bandas ya recorridas: la brecha siguiente
    % pertenece al borde n*pi/a.
    n = 0;
    i = 1;
    while i <= N
        if ~permitido(i)
            j = i;
            while j <= N && ~permitido(j)
                j = j + 1;
            end
            idx = i:j-1;
            kE(idx) = n*kb + 1i .* ki(idx);
            i = j;
            continue
        end

        j = i;
        while j <= N && permitido(j)
            j = j + 1;
        end
        tramo = i:j-1;

        if numel(tramo) >= 3
            s = sign(diff(kr(tramo)));
            s(s == 0) = 1;
            sub = [1, reshape(find(diff(s) ~= 0) + 1, 1, []), numel(tramo) + 1];
        else
            sub = [1, numel(tramo) + 1];
        end

        for u = 1:numel(sub) - 1
            sel = tramo(sub(u):sub(u+1) - 1);
            n = n + 1;
            if mod(n, 2) == 1
                kE(sel) = (n-1)*kb + kr(sel);
            else
                kE(sel) = n*kb - kr(sel);
            end
        end
        i = j;
    end

    if all(isnan(kE(:)) | abs(imag(kE(:))) < 1e-10)
        kE = real(kE);
    end
end
