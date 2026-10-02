% velocidadmasa
% Velocidad de grupo y masa efectiva en la primera banda.
% Requiere haber ejecutado main.m antes.
%
% De k(E) se obtiene k' = dk/dE por diferencias finitas. De ahi
%   vg    = (1/hbar) dE/dk      = 1/(hbar k')
%   m*    = hbar^2 (d2E/dk2)^-1 = -hbar^2 k'^3 / k''
% El signo menos sale de derivar 1/k' respecto a k.

global me hbar V0 a d

a  = 4.05/sqrt(3);
d  = a/2;
V0 = 0.1;
c  = 2.99792458e18;   % A/s

[Ef, Et] = bordes(0.001:1e-4:30);

% Se evitan los bordes exactos: ahi dk/dE diverge y la derivada numerica
% pierde precision.
E  = linspace(Ef + 1e-3, Et - 1e-3, 200001);

dk = gradient(k(E), E);                      % dk/dE
vg = 1./(hbar*dk);                           % ecuacion (14)
ms = -(hbar^2)*dk.^3./(me*gradient(dk, E));  % ecuacion (15), normalizada a me

fprintf('vg max = %.4e A/s = %.3f%% de c\n', max(abs(vg)), 100*max(abs(vg))/c)

% La velocidad de grupo se pide en funcion de k.
figure
plot(k(E), vg, 'b', 'LineWidth', 2)
xlabel('k (1/A)')
ylabel('v_g (A/s)')
title('Velocidad de grupo en la primera banda')

% La masa efectiva se pide en funcion de la energia.
figure
plot(E, ms, 'b', 'LineWidth', 2)
ylim([-5 5])
xlabel('E (eV)')
ylabel('m^*/m_e')
title('Masa efectiva en la primera banda')
yline(0, 'k:')
