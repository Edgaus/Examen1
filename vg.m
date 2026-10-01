% vg
% Velocidad de grupo, ecuacion (14): vg = dw/dk = (1/hbar) dE/dk.
%
% Se usa la derivada analitica dk/dE de dkdE.m, de modo que
%
%   vg(E) = 1/(hbar dk/dE) = -a sqrt(1 - F^2)/(hbar F'(E))
%
% El resultado esta en A/s (dividir por c0 para expresarlo en unidades de c).
% El signo sigue al de dk/dE en el esquema de zona reducida (negativo en las
% bandas pares); lo que tiene sentido fisico es |vg|. NaN dentro de las brechas.
function [res] = vg(E)

global hbar

res = 1./(hbar*dkdE(E));

end
