% ext_minibanda
% [Einf, Esup, W] = ext_minibanda(n, Vb_, mw_, mb_, Lw_, Lb_, Emax)
%
% Bordes y ancho de la minibanda n de una superred, calculados con ext_Fsl y
% brechas. Las masas se dan en las mismas unidades que me (eV s^2/A^2) y las
% longitudes en A.
function [Einf, Esup, W] = ext_minibanda(n, Vb_, mw_, mb_, Lw_, Lb_, Emax)

global mw mb Vb Lw Lb

mw = mw_;  mb = mb_;  Vb = Vb_;  Lw = Lw_;  Lb = Lb_;

bandas = brechas(1e-5, Emax, 400001, @ext_Fsl);

Einf = bandas(n, 1);
Esup = bandas(n, 2);
W    = Esup - Einf;

end
