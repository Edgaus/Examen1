% imk
% imk(E) devuelve la parte imaginaria del vector de onda. Es distinta de
% cero solo dentro de las brechas, donde no hay electrones de Bloch
% propagantes y la solucion decae exponencialmente.

function imkE = imk(E)

    [~, imkE] = k(E);

end
