% imk(E)
% Parte imaginaria del vector de onda. Es distinta de cero solo dentro
% de las brechas, donde no hay electrones de Bloch propagantes.

function imkE = imk(E)
    [~, imkE] = k(E);
end
