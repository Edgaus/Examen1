% alpha
% alpha calcula alpha = sqrt(2*me*E/hbar^2), el vector de onda en la region II
% (el pozo, V = 0) segun la ecuacion (3).
function [res] = alpha(E)

global me hbar

res = sqrt(2*me*E)/hbar;

end
