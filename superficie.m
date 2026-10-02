% superficie
% Estados de superficie: dentro de las brechas el vector de onda es
% imaginario y la funcion de onda decae exponencialmente hacia el interior
% del cristal. Requiere haber ejecutado main.m antes.

global me hbar V0 a d

a  = 4.05/sqrt(3);
d  = 1;
V0 = 5;

E = 0.01:0.005:35;

[rk, ik] = k(E);

ik = abs(ik);         % la rama de acos cambia de signo segun si F > 1 o F < -1
ik(ik == 0) = NaN;    % no dibujar la linea de ceros dentro de las bandas

figure
hold on
plot(rk, E, 'b', 'LineWidth', 2)   % bandas permitidas
plot(ik, E, 'r', 'LineWidth', 2)   % estados evanescentes en las brechas
hold off
xlabel('k (1/A)')
ylabel('E (eV)')
title('Re k y |Im k|, V_0 = 5 eV, d = 1 A')
legend('Re k', '|Im k|', 'Location', 'southeast')

% Alcance de un estado de superficie en el centro de la primera brecha.
[~, Et, E2] = bordes(E);
Ec    = (Et + E2)/2;
kappa = abs(imk(Ec));
fprintf('Centro de la primera brecha: %.4f eV\n', Ec)
fprintf('|Im k| = %.4f 1/A, longitud de decaimiento %.3f A = %.2f capas atomicas\n', ...
        kappa, 1/kappa, 1/(kappa*a))
