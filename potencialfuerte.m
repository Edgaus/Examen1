% potencialfuerte
% Estructura de bandas con pozos mas profundos: V0 = 5 eV y d = 1 A.
% Requiere haber ejecutado main.m antes.

global me hbar V0 a d

a  = 4.05/sqrt(3);
d  = 1;
V0 = 5;

E = 0.01:0.005:35;          % malla fina: con 0.1 eV una brecha chica no se resuelve

[rk, ik] = k(E);

[Ef, Et, E2] = bordes(E);
fprintf('Primera banda: %.4f a %.4f eV\n', Ef, Et)
fprintf('Primera brecha: %.4f a %.4f eV, Eg = %.4f eV\n', Et, E2, E2 - Et)

figure
plot(rk, E, 'b', 'LineWidth', 2)
xlabel('k (1/A)')
ylabel('E (eV)')
title('Potencial fuerte, V_0 = 5 eV, d = 1 A')
