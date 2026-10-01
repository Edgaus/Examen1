% ext_Fsl
% Version generalizada de F(E) para una superred de semiconductores: masas
% efectivas distintas en el pozo y en la barrera, con la condicion de frontera
% de BenDaniel-Duke (continuidad de psi y de (1/m) dpsi/dx en lugar de dpsi/dx).
%
%   cos(k a) = cos(kb Lb) cos(kw Lw)
%              - (1/2) [ (kb mw)/(kw mb) + (kw mb)/(kb mw) ] sin(kb Lb) sin(kw Lw)
%
% con kw = sqrt(2 mw E)/hbar en el pozo (V = 0, ancho Lw), kb = sqrt(2 mb (E-Vb))/hbar
% en la barrera (V = Vb, ancho Lb) y periodo a = Lw + Lb.
%
% Si mw = mb se recupera exactamente la ecuacion (10) del guion, porque entonces
% el corchete se reduce a (kw^2 + kb^2)/(kw kb).
%
% Parametros a traves de las globales mw, mb, Vb, Lw, Lb.
function [res] = ext_Fsl(E)

global hbar mw mb Vb Lw Lb

E(E <= 0) = eps;
E(abs(E - Vb) < 1e-12) = Vb + 1e-12;

kw = sqrt(2*mw*E)/hbar;
kb = sqrt(2*mb*(E - Vb))/hbar;

G = 0.5*((kb.*mw)./(kw.*mb) + (kw.*mb)./(kb.*mw));

res = real(cos(kb*Lb).*cos(kw*Lw) - G.*sin(kb*Lb).*sin(kw*Lw));

end
