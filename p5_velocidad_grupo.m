% p5_velocidad_grupo
% PREGUNTAS (pag. 10, en rojo):
%   "What is the maximum vg, expressed in percents of the velocity of light?
%    Can you give a physical explanation for this behaviour of vg when
%    approaching the boundary of the Brillouin zone?"

kpmain
global me hbar V0 a d c0

% Se evaluan los dos potenciales usados en el laboratorio
casos = [0.1 a/2; 0.2 a/2; 5 1];

fprintf('\n===== P5: velocidad de grupo en la primera banda =====\n');
fprintf('vg = (1/hbar) dE/dk = -a sqrt(1-F^2)/(hbar F''(E)),  c = %.4e A/s\n\n', c0);
fprintf('  V0[eV]  d[A]    1a banda [eV]        vg_max [A/s]    vg_max/c [%%]\n');

figure(7); clf
colores = {'b', 'g', 'r'};

for i = 1:1:size(casos, 1)
    V0 = casos(i, 1);
    d  = casos(i, 2);

    [bandas, gaps] = brechas(1e-6, 35);
    E1 = bandas(1, 1);
    E2 = bandas(1, 2);

    % Malla interior a la primera banda (los bordes se excluyen: ahi vg -> 0)
    E  = linspace(E1 + 1e-6*(E2-E1), E2 - 1e-6*(E2-E1), 200001);
    kk = k(E);
    vv = abs(vg(E));

    [vmax, jmax] = max(vv);

    fprintf('  %5.2f  %5.3f  %7.4f ... %7.4f   %.4e    %7.4f\n', ...
            V0, d, E1, E2, vmax, 100*vmax/c0);

    subplot(1, size(casos, 1), i); hold on
    plot(kk, vv/c0*100, colores{i}, 'LineWidth', 2)
    plot(kk, 100*hbar*kk/(me*c0), 'k--')
    plot(kk(jmax), 100*vmax/c0, 'ko', 'MarkerFaceColor', 'k')
    hold off
    xlabel('k [1/A]'); ylabel('v_g [% de c]')
    title(sprintf('V_0 = %.2f eV, d = %.3f A', V0, d))
    legend('KP', 'electron libre hbar k/m_e', 'maximo', 'Location', 'northwest')
    grid on
end

% Caso de referencia para la respuesta escrita: electrones casi libres
V0 = 0.1;  d = a/2;
[bandas, gaps] = brechas(1e-6, 35);
E  = linspace(bandas(1,1) + 1e-9, bandas(1,2) - 1e-9, 400001);
vv = abs(vg(E));
[vmax, jmax] = max(vv);
vlibre_borde = hbar*(pi/a)/me;

fprintf('\nRESPUESTA (V0 = 0.1 eV, d = a/2):\n');
fprintf('  vg maxima = %.4e A/s = %.3f%% de c, alcanzada en E = %.4f eV, k = %.4f 1/A\n', ...
        vmax, 100*vmax/c0, E(jmax), k(E(jmax)));
fprintf('  (el electron libre daria hbar(pi/a)/me = %.4e A/s = %.3f%% de c en el borde)\n', ...
        vlibre_borde, 100*vlibre_borde/c0);
fprintf('  Es decir vg_max es del orden de 0.5%% de c: el tratamiento no relativista esta\n');
fprintf('  perfectamente justificado.\n');
fprintf('  Explicacion fisica del comportamiento al acercarse al borde de zona: en el borde\n');
fprintf('  k = pi/a se cumple la condicion de Bragg (2k = G = 2pi/a), la onda incidente\n');
fprintf('  exp(ikx) y la reflejada exp(-ikx) se mezclan con el mismo peso y la solucion es\n');
fprintf('  una onda estacionaria (cos(pi x/a) o sin(pi x/a)), no una onda viajera. Por eso\n');
fprintf('  E(k) llega al borde con pendiente nula, dE/dk -> 0 y vg -> 0: el electron ya no\n');
fprintf('  propaga, queda reflejado por la red. vg crece casi como el electron libre\n');
fprintf('  (hbar k/me) en la mayor parte de la banda, pasa por un maximo y cae a cero justo\n');
fprintf('  antes del borde; el ancho de la region donde cae esta fijado por la brecha.\n');
