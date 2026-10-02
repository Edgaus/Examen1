% main
% Define las variables globales y las constantes, y grafica la estructura
% de bandas del caso de electron libre.
%
% Unidades: longitud en A, vector de onda en 1/A, energia en eV.

global me hbar V0 a d

me   = 5.68572e-32;
hbar = 6.58199e-16;

a = 4.05/sqrt(3);   % distancia entre planos (111) del Al, 2.3383 A
d = a/2;
V0 = 0;             % electron libre

path('C:\Users\edgau\OneDrive - CINVESTAV\Documentos\MATLAB\Examen Max',path);

E = 0.1:0.01:30;    % eV

% La estructura de bandas lleva k en la abscisa y E en la ordenada,
% de modo que k(E) es el primer argumento de plot.
plot(k(E), E, 'b', fek(E), E, 'r--')
xlabel('k (1/A)')
ylabel('E (eV)')
title('Electron libre')
legend('Kronig-Penney', 'Electron libre exacto', 'Location', 'southeast')

% Con V0 = 0 la banda de Kronig-Penney es la parabola libre plegada en la
% primera zona: la diferencia con acos(cos(k a))/a es del orden de 1e-14.
max(abs(k(E) - acos(cos(fek(E)*a))/a))
