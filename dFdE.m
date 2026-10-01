% dFdE
% Derivada analitica dF/dE de la funcion F(E) de la ecuacion (10). Se usa para
% obtener dk/dE (y con ella la velocidad de grupo y la masa efectiva) sin
% derivar numericamente la estructura de bandas.
%
% Con alpha' = alpha/(2E), beta' = beta/(2(E-V0)) y G = (alpha^2+beta^2)/(2 alpha beta):
%
%   F' = -beta' d sin(beta d) cos(alpha s) - alpha' s cos(beta d) sin(alpha s)
%        - G' sin(beta d) sin(alpha s)
%        - G [ beta' d cos(beta d) sin(alpha s) + alpha' s sin(beta d) cos(alpha s) ]
function [res] = dFdE(E)

global V0 a d

s = a - d;

E(E <= 0) = eps;
E(abs(E - V0) < 1e-12) = V0 + 1e-12;

al = alpha(E);
be = beta(E);

dal = al./(2*E);
dbe = be./(2*(E - V0));

G  = (al.^2 + be.^2)./(2*al.*be);
dG = ((2*al.*dal + 2*be.*dbe).*(al.*be) ...
      - (al.^2 + be.^2).*(dal.*be + al.*dbe))./(2*(al.^2).*(be.^2));

res = real(-dbe.*d.*sin(be*d).*cos(al*s) ...
           - dal.*s.*cos(be*d).*sin(al*s) ...
           - dG.*sin(be*d).*sin(al*s) ...
           - G.*(dbe.*d.*cos(be*d).*sin(al*s) + dal.*s.*sin(be*d).*cos(al*s)));

end
