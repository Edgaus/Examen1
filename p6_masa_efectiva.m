% p6_masa_efectiva
% PREGUNTAS (pag. 10, en rojo):
%   "Calculate the effective mass normalized to the mass of a free electron as a
%    function of the energy and discuss the results. Give a physical
%    interpretation of the change in sign of the effective mass."

kpmain
global V0 a d

casos  = [0.1 a/2; 5 1];
mfondo = nan(size(casos, 1), 3);     % m*/me en el fondo de cada banda

figure(8); clf

fprintf('\n===== P6: masa efectiva m*/me =====\n');
fprintf('m*/me = -hbar^2 k''(E)^3/(me k''''(E)), con k(E) = acos(F(E))/a\n');

for i = 1:1:size(casos, 1)
    V0 = casos(i, 1);
    d  = casos(i, 2);

    [bandas, gaps] = brechas(1e-6, 35);

    nc = size(casos, 1);
    fprintf('\n--- V0 = %.2f eV, d = %.3f A ---\n', V0, d);
    fprintf('Banda   E_inf     E_sup     ancho    m*/me (fondo)  m*/me (techo)\n');

    for nb = 1:1:min(3, size(bandas, 1))
        E1 = bandas(nb, 1);
        E2 = bandas(nb, 2);
        E  = linspace(E1 + 1e-3*(E2 - E1), E2 - 1e-3*(E2 - E1), 4001);
        mm = mef(E);

        subplot(2, nc, i); hold on
        plot(E, mm, 'LineWidth', 2)

        if E2 > 35 - 1e-6
            nota = '  (banda cortada por el limite del barrido)';
        else
            nota = '';
        end
        fprintf('  %d   %8.4f  %8.4f  %7.4f   %+10.4f     %+10.4f%s\n', ...
                nb, E1, E2, E2 - E1, mm(1), mm(end), nota);
        mfondo(i, nb) = mm(1);
    end

    subplot(2, nc, i)
    plot([0 35], [0 0], 'k:'); plot([0 35], [1 1], 'k--'); hold off
    xlabel('E [eV]'); ylabel('m^*/m_e')
    title(sprintf('V_0 = %.2f eV, d = %.3f A', V0, d))
    ylim([-5 5]); grid on

    % Abajo: zoom en el entorno de la primera brecha, donde m* diverge y cambia
    % de signo (en el eje de energias completo esa estructura es invisible).
    W   = bandas(1,2) - bandas(1,1);
    Ea  = linspace(bandas(1,2) - 0.25*W, bandas(1,2) - 1e-3*W, 2001);
    Eb  = linspace(bandas(2,1) + 1e-3*W, bandas(2,1) + 0.25*W, 2001);
    subplot(2, nc, nc + i); hold on
    plot(Ea, mef(Ea), 'LineWidth', 2)
    plot(Eb, mef(Eb), 'LineWidth', 2)
    plot([bandas(1,2) bandas(1,2)], [-5 5], 'k--')
    plot([bandas(2,1) bandas(2,1)], [-5 5], 'k--')
    plot([Ea(1) Eb(end)], [0 0], 'k:')
    hold off
    xlabel('E [eV]'); ylabel('m^*/m_e')
    title('Zoom en la 1a brecha: m^* diverge y cambia de signo')
    xlim([Ea(1) Eb(end)]); ylim([-5 5]); grid on
    legend('techo de la 1a banda', 'fondo de la 2a banda', 'Location', 'east')
end

% Valores concretos para la discusion, con el potencial debil
V0 = 0.1;  d = a/2;
[bandas, gaps] = brechas(1e-6, 35);
E1 = bandas(1,1);  E2 = bandas(1,2);
% El margen debe ser mayor que el paso h de mef(), que necesita E +- h dentro de la banda
E  = linspace(E1 + 1e-3, E2 - 1e-3, 200001);
mm = mef(E);
% Energia donde m* cambia de signo: ahi 1/m* = 0 y |m*| diverge (punto de
% inflexion de E(k))
jc = find(diff(sign(mm)) ~= 0, 1);

fprintf('\nRESPUESTA:\n');
fprintf('  Con V0 = 0.1 eV (electrones casi libres) la masa efectiva en el fondo de la\n');
fprintf('  primera banda es m*/me = %+.4f, practicamente la del electron libre: cerca del\n', mm(1));
fprintf('  fondo E(k) es la parabola libre y la red casi no se nota.\n');
if ~isempty(jc)
    fprintf('  m* diverge (1/m* = 0) en E = %.4f eV, el punto de inflexion de E(k), y cambia\n', ...
            0.5*(E(jc) + E(jc+1)));
    fprintf('  de signo por encima de esa energia.\n');
end
fprintf('  En el techo de la banda m*/me = %+.4f, es decir negativa y pequena en modulo\n', mm(end));
fprintf('  (para electrones casi libres |m*|/me ~ Eg/(2 E(pi/a)) en el borde de banda).\n');
fprintf('  Interpretacion fisica del cambio de signo: m* mide la respuesta del electron a\n');
fprintf('  una fuerza externa incluyendo ya la fuerza que ejerce la red. En el fondo de la\n');
fprintf('  banda E(k) es convexa (d2E/dk2 > 0) y el electron acelera en el sentido de la\n');
fprintf('  fuerza, como una particula libre. Al acercarse al borde de zona la difraccion de\n');
fprintf('  Bragg hace que E(k) se curve hacia abajo (d2E/dk2 < 0): el momento que el\n');
fprintf('  electron gana del campo lo transfiere a la red, de modo que su aceleracion es\n');
fprintf('  opuesta a la fuerza aplicada y m* sale negativa. Un estado cerca del techo de la\n');
fprintf('  banda se comporta por tanto como una carga positiva, que es el origen del\n');
fprintf('  concepto de hueco. En el punto de inflexion d2E/dk2 = 0 y |m*| diverge.\n');
fprintf('  Con V0 = 5 eV y d = 1 A las bandas se aplanan y la curvatura de E(k) disminuye,\n');
fprintf('  de modo que |m*| crece: en el fondo de la segunda banda pasa de %.4f a %.4f me.\n', ...
        mfondo(1,2), mfondo(2,2));
fprintf('  Es el camino hacia el limite de enlace fuerte: el electron esta mas localizado\n');
fprintf('  en los pozos y responde peor al campo externo. La primera banda sigue siendo\n');
fprintf('  ancha, por eso en su fondo m* todavia vale ~%.2f me.\n', mfondo(2,1));
