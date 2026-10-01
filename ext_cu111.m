% ext_cu111
% EXTENSION: el mismo analisis del examen aplicado a Cu(111) en lugar de Al(111).
%
% Es el cambio minimo posible (Cu tambien es fcc y se mira la misma direccion
% [111]: solo cambian a y V0) y a la vez el caso con mas datos experimentales con
% los que comparar, porque la brecha L2'-L1 del Cu es una brecha de electron casi
% libre y aloja el estado de superficie de Shockley mas estudiado que existe.
%
% Procedimiento de verificacion:
%   1) a = a0/sqrt(3) con a0(Cu) = 3.615 A.
%   2) Se ajusta V0 (el unico parametro libre) para reproducir el ancho de la
%      brecha L medida por fotoemision: de -0.9 eV a +4.2 eV respecto a E_F.
%   3) Con V0 ya fijado, el modelo PREDICE sin parametros libres: la longitud de
%      decaimiento del estado de superficie dentro de la brecha, el numero de
%      capas atomicas sobre las que se extiende y la masa efectiva. Esas tres
%      cosas estan medidas en la literatura (ver las referencias al final).
%
% Referencias para comparar:
%   - N. V. Smith, Phys. Rev. B 32, 3549 (1985): analisis de electron casi libre
%     de cinco brechas del Cu, entre ellas la brecha L en Cu(111).
%   - S. D. Kevan y R. H. Gaylord, Phys. Rev. Lett. 57, 2975 (1986) y
%     Phys. Rev. B 36, 5809 (1987): longitud de decaimiento del estado de
%     superficie medida en funcion de la energia DENTRO de la brecha L2'-L1,
%     que es exactamente la curva que calcula imk(E), y la masa efectiva de la
%     relacion de dispersion compleja.
%   - F. Reinert et al., Phys. Rev. B 63, 115415 (2001): dispersion del estado de
%     Shockley en Cu(111), Ag(111) y Au(111) por ARPES de alta resolucion.
%   - P. O. Gartland y B. J. Slagsvold, Phys. Rev. B 12, 4047 (1975): estado de
%     superficie 0.40 +- 0.02 eV por debajo de E_F con m* = (0.42 +- 0.05) me.

kpmain
global V0 a d me hbar

a0 = 3.615;          % parametro de red cubico del Cu [A]
a  = a0/sqrt(3);     % distancia entre planos (111) = 2.0871 A
d  = a/2;            % misma eleccion que en el examen

% Datos experimentales con los que se compara (eV, respecto a E_F)
Einf_exp = -0.9;     % borde inferior de la brecha proyectada (L2')
Esup_exp = +4.2;     % borde superior (L1)
Eg_exp   = Esup_exp - Einf_exp;
Ess_exp  = -0.435;   % estado de Shockley (Reinert et al. 2001)

fprintf('\n===== EXT: Cu(111), misma geometria que Al(111) =====\n');
fprintf('a = a0/sqrt(3) = %.4f A   (Al: 2.3383 A)\n', a);
fprintf('E(pi/a) de electron libre = %.3f eV\n', (hbar^2/(2*me))*(pi/a)^2);

% --- 1) Ajuste de V0 al ancho de brecha medido -------------------------------
lo = 0.1;  hi = 30;
for it = 1:1:60
    V0 = 0.5*(lo + hi);
    [~, g] = brechas(1e-4, 60, 60001);
    if (g(1,2) - g(1,1)) < Eg_exp
        lo = V0;
    else
        hi = V0;
    end
end
V0 = 0.5*(lo + hi);
[bandas, gaps] = brechas(1e-4, 60);

fprintf('\nAjuste del unico parametro libre:\n');
fprintf('  V0 = %.4f eV reproduce Eg = %.4f eV (medido %.2f eV)\n', ...
        V0, gaps(1,2) - gaps(1,1), Eg_exp);
fprintf('  comprobacion de electron casi libre: 2|V1| = 2V0/pi = %.4f eV\n', 2*abs(V1kp()));

% Origen de energias del modelo que hace coincidir el borde inferior con -0.9 eV
EF = gaps(1,1) - Einf_exp;
fprintf('  (E_F del modelo queda en %.4f eV; a partir de aqui todo va referido a E_F)\n', EF);

% --- 2) Predicciones del modelo ----------------------------------------------
Ess   = EF + Ess_exp;              % energia del estado de superficie en el modelo
kap   = imk(Ess);
Ec    = 0.5*(gaps(1,1) + gaps(1,2));
kapc  = imk(Ec);

fprintf('\nPredicciones del modelo con V0 ya fijado:\n');
fprintf('  Estado de superficie medido en E - E_F = %.3f eV (%.3f eV sobre el borde inferior):\n', ...
        Ess_exp, Ess_exp - Einf_exp);
fprintf('    |Im k| = %.4f 1/A, longitud de penetracion 1/|Im k| = %.2f A = %.2f capas (111)\n', ...
        kap, 1/kap, 1/(kap*a));
fprintf('  Centro de la brecha (E - E_F = %.3f eV):\n', Ec - EF);
fprintf('    |Im k| = %.4f 1/A, 1/|Im k| = %.2f A = %.2f capas\n', kapc, 1/kapc, 1/(kapc*a));
fprintf('  Masa efectiva a lo largo de [111]: m*/me = %+.4f en el techo de la banda 1,\n', ...
        mef(bandas(1,2) - 0.01));
fprintf('    %+.4f en el fondo de la banda 2 y %+.4f en el fondo de la banda 1\n', ...
        mef(bandas(2,1) + 0.01), mef(bandas(1,1) + 0.01));
fprintf('    (ojo: el 0.42 me de ARPES es la masa PARALELA a la superficie, no esta;\n');
fprintf('     lo comparable con este calculo es la masa de la banda compleja de\n');
fprintf('     Kevan y Gaylord, que ellos encuentran ~2 veces mayor que la extrapolada\n');
fprintf('     de calculos de banda de volumen)\n');

% --- 3) Figuras ---------------------------------------------------------------
E = linspace(1e-3, 30, 60001);
figure(10); clf
subplot(1, 2, 1); hold on
plot(k(E), E - EF, 'b-', 'LineWidth', 2)
plot([0 pi/a], [Einf_exp Einf_exp], 'r--')
plot([0 pi/a], [Esup_exp Esup_exp], 'r--')
plot([0 pi/a], [0 0], 'k:')
hold off
xlabel('k [1/A]'); ylabel('E - E_F [eV]')
title(sprintf('Cu(111): KP con V_0 = %.2f eV', V0))
axis([0 pi/a -10 10]); grid on
legend('KP', 'bordes de la brecha L medidos', 'E_F', 'Location', 'southeast')

subplot(1, 2, 2); hold on
plot(imk(E), E - EF, 'r-', 'LineWidth', 2)
plot(kap, Ess_exp, 'ko', 'MarkerFaceColor', 'k')
hold off
xlabel('|Im k| [1/A]'); ylabel('E - E_F [eV]')
title('Decaimiento en la brecha y estado de Shockley')
ylim([Einf_exp - 1, Esup_exp + 1]); grid on
legend('|Im k(E)|', 'estado de superficie medido', 'Location', 'northeast')
