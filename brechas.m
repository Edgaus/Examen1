% brechas
% [bandas, gaps] = brechas(Emin, Emax) localiza los bordes de banda del modelo
% KP resolviendo |F(E)| = 1.
%
% Primero se barre una malla fina para detectar los cambios entre region
% permitida (|F| <= 1) y prohibida (|F| > 1) y despues cada borde se afina por
% biseccion, de modo que el tamano de la brecha NO depende del paso del
% grafico (con pasos de 0.1 eV se sobreestima, como advierte el guion).
%
%   bandas(i,:) = [Einf Esup] de la banda i
%   gaps(i,:)   = [Einf Esup] de la brecha entre las bandas i e i+1
%
% El tercer argumento (opcional) es el numero de puntos de la malla inicial.
function [bandas, gaps] = brechas(Emin, Emax, npts)

if nargin < 3
    npts = 200001;
end

Eg  = linspace(Emin, Emax, npts);
per = abs(F(Eg)) <= 1;                 % 1 = permitido, 0 = prohibido

bandas = [];
j = 1;
while j <= npts
    if per(j)
        j0 = j;
        while j <= npts && per(j)
            j = j + 1;
        end
        j1 = j - 1;

        % Borde inferior: entre el ultimo punto prohibido y el primer permitido
        if j0 == 1
            Einf = Eg(1);
        else
            Einf = bordebanda(Eg(j0-1), Eg(j0));
        end
        % Borde superior: entre el ultimo permitido y el primer prohibido
        if j1 == npts
            Esup = Eg(npts);
        else
            Esup = bordebanda(Eg(j1+1), Eg(j1));
        end

        bandas = [bandas; Einf Esup];
    else
        j = j + 1;
    end
end

% Las brechas son los huecos entre bandas consecutivas (la region prohibida que
% hay por debajo de la primera banda no es una brecha, es el fondo de bandas).
gaps = [];
for i = 1:1:(size(bandas, 1) - 1)
    gaps = [gaps; bandas(i, 2) bandas(i+1, 1)];
end

end

% Biseccion de |F(E)| - 1 entre Eprohibida (|F|>1) y Epermitida (|F|<=1).
function [Eb] = bordebanda(Eprohibida, Epermitida)

for it = 1:1:80
    Em = 0.5*(Eprohibida + Epermitida);
    if abs(F(Em)) > 1
        Eprohibida = Em;
    else
        Epermitida = Em;
    end
end
Eb = 0.5*(Eprohibida + Epermitida);

end
