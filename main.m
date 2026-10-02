% main
% Define las variables globales, las constantes y el estilo de las figuras,
% y grafica la estructura de bandas del caso de electron libre.
%
% Unidades: longitud en A, vector de onda en 1/A, energia en eV.
% Este script debe ejecutarse antes que los demas: en el se fijan las
% variables globales que usan kv, k, fek, imk y bordes.

global me hbar V0 a d

me   = 5.68572e-32;
hbar = 6.58199e-16;
c    = 2.99792458e18;   % velocidad de la luz en A/s

a  = 4.05/sqrt(3);      % distancia entre planos (111) del Al, 2.3383 A
d  = a/2;
V0 = 0;                 % electron libre

path('C:\Users\edgau\OneDrive - CINVESTAV\Documentos\MATLAB\Examen Max',path);

% Estilo comun de todas las figuras: lineas mas gruesas y letra mas grande.
set(groot, 'defaultLineLineWidth', 2)
set(groot, 'defaultAxesLineWidth', 1)
set(groot, 'defaultAxesFontSize', 12)

E = 0.1:0.01:30;        % eV

% La estructura de bandas lleva k en la abscisa y E en la ordenada,
% de modo que k(E) es el primer argumento de plot.
figure
plot(k(E), E, 'b', fek(E), E, 'r--')
xlabel('k (1/A)')
ylabel('E (eV)')
title('Electron libre')
legend('Kronig-Penney', 'Electron libre exacto', 'Location', 'southeast')
% Sin xlim se aprecia la diferencia: Kronig-Penney devuelve la banda
% plegada en [0, pi/a] y fek la parabola extendida.

% Con V0 = 0 la banda de Kronig-Penney es la parabola libre plegada en la
% primera zona: la diferencia con acos(cos(k a))/a es del orden de 1e-13.
max(abs(k(E) - acos(cos(fek(E)*a))/a))
