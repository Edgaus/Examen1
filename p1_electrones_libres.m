% p1_electrones_libres
% PREGUNTA (pag. 8, en rojo):
%   "Write a function to calculate the band structure for free electrons and
%    compare with the band structure obtained by the KP model. [...] Can you
%    observe any difference?"

kpmain
global V0 a d

V0 = 0;        % electrones libres
d  = a/2;

E = 0.01:0.01:30;

figure(1); clf
subplot(1, 2, 1); hold on
plot(k(E), E, 'b-', 'LineWidth', 3)
plot(fekred(E), E, 'r--', 'LineWidth', 1)
hold off
xlabel('k [1/A]'); ylabel('E [eV]')
title('Zona reducida: KP (V_0=0) vs electrones libres plegados')
legend('KP: k(E)', 'libres plegados: fekred(E)', 'Location', 'southeast')
axis([0 pi/a 0 30]); grid on

subplot(1, 2, 2); hold on
plot(kext(E), E, 'b-', 'LineWidth', 3)
plot(fek(E), E, 'r--', 'LineWidth', 1)
hold off
xlabel('k [1/A]'); ylabel('E [eV]')
title('Zona extendida: KP desdoblado vs parabola libre')
legend('KP: kext(E)', 'libres exactos: fek(E)', 'Location', 'southeast')
grid on

dif_red = max(abs(k(E) - fekred(E)));
dif_ext = max(abs(kext(E) - fek(E)));
[bandas, gaps] = brechas(0.001, 30);

fprintf('\n===== P1: electrones libres vs KP con V0 = 0 =====\n');
fprintf('a = %.4f A, d = %.4f A, V0 = %.3f eV\n', a, d, V0);
fprintf('Diferencia maxima |k_KP - k_libre_plegado|   = %.3e 1/A  (error de redondeo)\n', dif_red);
fprintf('Diferencia maxima |kext_KP - k_libre_exacto| = %.3e 1/A  (paso de la malla en\n', dif_ext);
fprintf('  los puntos de plegado, donde se detecta el cambio de banda)\n');
fprintf('Numero de brechas encontradas entre 0 y 30 eV: %d\n', size(gaps, 1));
fprintf(['RESPUESTA: no hay ninguna diferencia fisica. Con V0 = 0 el modelo KP\n' ...
         '  reproduce exactamente la parabola de electron libre E = hbar^2 k^2/(2 me)\n' ...
         '  y no aparece ninguna brecha de energia (F(E) = cos(alpha a), de modo que\n' ...
         '  k = alpha siempre tiene solucion real). La unica diferencia es de\n' ...
         '  representacion: k(E) = acos(F)/a devuelve k siempre en la primera zona de\n' ...
         '  Brillouin (0 <= k <= pi/a), es decir la parabola plegada en los bordes de\n' ...
         '  zona k = n*pi/a (esquema de zona reducida), mientras que fek(E) la da en\n' ...
         '  zona extendida. Al desdoblar el resultado del KP con kext(E) las dos curvas\n' ...
         '  coinciden punto a punto.\n']);
