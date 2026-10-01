% p3_potencial_fuerte
% PREGUNTAS (pag. 9, en rojo):
%   "Consider now stronger potential wells by increasing V0 to 5 eV and reducing
%    d to 1 A. Plot the band structure for energies from 0 to 35 eV. Have the
%    band gaps increased in size? By which factor has the first gap increased?"

kpmain
global V0 a d

% Caso de referencia: potencial debil del apartado anterior (V0 = 0.2, d = a/2)
V0 = 0.2;  d = a/2;
[bandas_ref, gaps_ref] = brechas(1e-4, 35);
gaps_ref_tam = gaps_ref(:,2) - gaps_ref(:,1);

% Caso del enunciado: potencial fuerte
V0 = 5;    d = 1;
[bandas, gaps] = brechas(1e-4, 35);
gaps_tam = gaps(:,2) - gaps(:,1);

E = linspace(1e-3, 35, 60001);
figure(4); clf
plot(k(E), E, 'b-', 'LineWidth', 2)
xlabel('k [1/A]'); ylabel('E [eV]')
title(sprintf('KP con V_0 = %.1f eV, d = %.1f A, a = %.4f A', V0, d, a))
axis([0 pi/a 0 35]); grid on

figure(5); clf; hold on
plot(kext(E), E, 'b-', 'LineWidth', 2)
plot(fek(E), E, 'r--')
hold off
xlabel('k [1/A]'); ylabel('E [eV]')
title('Zona extendida: KP con potencial fuerte vs electron libre')
legend('KP: kext(E)', 'electron libre', 'Location', 'southeast'); grid on

fprintf('\n===== P3: estructura de bandas con potencial mas fuerte =====\n');
fprintf('Referencia  V0 = 0.2 eV, d = a/2 = %.4f A\n', a/2);
for i = 1:1:min(4, size(gaps_ref, 1))
    fprintf('  brecha %d: %8.4f ... %8.4f eV   (Eg = %.4f eV)\n', ...
            i, gaps_ref(i,1), gaps_ref(i,2), gaps_ref_tam(i));
end
fprintf('Caso nuevo  V0 = 5 eV, d = 1 A\n');
for i = 1:1:min(4, size(gaps, 1))
    fprintf('  brecha %d: %8.4f ... %8.4f eV   (Eg = %.4f eV)\n', ...
            i, gaps(i,1), gaps(i,2), gaps_tam(i));
end
fprintf('Fondo de la primera banda: %.4f eV   (ancho de la 1a banda = %.4f eV)\n', ...
        bandas(1,1), bandas(1,2) - bandas(1,1));
fprintf('Prediccion de electrones casi libres 2|V1| = %.4f eV (ya no es fiable aqui,\n', 2*abs(V1kp()));
fprintf('  porque V0 = 5 eV ya no es una perturbacion pequena)\n');

nc = min(length(gaps_tam), length(gaps_ref_tam));
fprintf('RESPUESTA: si, las brechas aumentan mucho.\n');
fprintf('  Primera brecha: %.4f eV -> %.4f eV, es decir ha crecido un factor %.1f\n', ...
        gaps_ref_tam(1), gaps_tam(1), gaps_tam(1)/gaps_ref_tam(1));
for i = 2:1:nc
    if gaps_ref_tam(i) < 1e-2
        fprintf('  Brecha %d:       %.4f eV -> %.4f eV (el factor no es significativo: con\n', ...
                i, gaps_ref_tam(i), gaps_tam(i));
        fprintf('                  d = a/2 el coeficiente de Fourier V_2 ~ sin(2 pi d/a) se anula\n');
        fprintf('                  y la brecha de referencia era practicamente nula)\n');
    else
        fprintf('  Brecha %d:       %.4f eV -> %.4f eV, factor %.1f\n', ...
                i, gaps_ref_tam(i), gaps_tam(i), gaps_tam(i)/gaps_ref_tam(i));
    end
end
fprintf('  Dos efectos se suman: V0 pasa de 0.2 a 5 eV (la brecha crece casi\n');
fprintf('  proporcionalmente a V0) y d pasa de a/2 a 1 A, lo que cambia la relacion\n');
fprintf('  barrera/pozo y hace que los coeficientes de Fourier V_n con n > 1 dejen de\n');
fprintf('  anularse, de modo que ahora tambien hay brecha en el segundo borde de zona.\n');
fprintf('  Las bandas se estrechan y se aplanan al mismo tiempo que crecen las brechas:\n');
fprintf('  el electron esta cada vez mas localizado en los pozos y se pasa del limite de\n');
fprintf('  electron casi libre al de enlace fuerte.\n');
