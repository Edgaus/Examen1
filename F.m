% F
% F(E) es el miembro derecho de la ecuacion (10) del guion:
%
%   cos(k a) = F(E) = cos(beta d) cos(alpha s)
%                     - (alpha^2 + beta^2)/(2 alpha beta) sin(beta d) sin(alpha s)
%
% con s = a - d. Hay soluciones de Bloch (k real) solo donde |F| <= 1; donde
% |F| > 1 estamos en una brecha de energia.
%
% F es matematicamente real incluso para E < V0 (beta imaginario), por eso se
% toma real() al final para eliminar el residuo numerico de la parte imaginaria.
function [res] = F(E)

global V0 a d

s = a - d;

% Puntos problematicos solo por aritmetica (0/0), no por fisica:
E(E <= 0) = eps;                        % alpha(0) = 0
E(abs(E - V0) < 1e-12) = V0 + 1e-12;    % beta(V0) = 0

al = alpha(E);
be = beta(E);

G = (al.^2 + be.^2)./(2*al.*be);

res = real(cos(be*d).*cos(al*s) - G.*sin(be*d).*sin(al*s));

end
