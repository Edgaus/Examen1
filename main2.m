% main.m
% Estructura de bandas de Al [111] con el modelo de Kronig-Penney.


global me hbar V0 a d

me = 5.68572e-32;  hbar = 6.58199e-16;
c  = 2.99792458e18;        % velocidad de la luz en A/s
a  = 4.05/sqrt(3);         % distancia entre planos (111) del Al = 2.3383 A
d  = a/2;
V0 = 0;                    % electron libre

set(groot, 'defaultLineLineWidth', 2)
set(groot, 'defaultAxesLineWidth', 1)
set(groot, 'defaultAxesFontSize', 17)

%% Electron libre: zona reducida y zona extendida
V0 = 0;
E = 0.1:0.01:30;

rk = k(E);
ke = kext(E);              % zona extendida (archivo kext.m)
kk  = [-fliplr(rk), NaN, rk];
EE  = [ fliplr(E),  NaN,  E];
kke = [-fliplr(ke), NaN, ke];
kl  = fek(E);
kkl = [-fliplr(kl), NaN, kl];

fig = figure;
t = tiledlayout(2,1,'TileSpacing','compact','Padding','compact');
sgtitle(t, 'Electrón libre')
nexttile
plot(kk, EE, 'b', kkl, EE, 'r--')
ylabel('E (eV)')
title('(a) Zona reducida')
legend('Kronig-Penney', 'Electrón libre exacto', 'Location', 'best')
grid on
nexttile
plot(kke, EE, 'b', kkl, EE, 'r--')
xline([-pi/a pi/a], 'k:')
xlabel('k (Å^{-1})')
ylabel('E (eV)')
title('(b) Zona extendida')
legend('Kronig-Penney desplegado', 'Electrón libre exacto', 'Location', 'best')
grid on
guardarfig(fig, fullfile(figdir, 'fig_libre.png'));


%% Electron casi libre
a = 4.05/sqrt(3);
d = a/2;
Max = (hbar^2/(2*me))*(pi/a)^2;
fprintf('Eborde = %.4f eV;  V0 = 0.1 eV es el %.2f %% \n', ...
        Eborde, 100*0.1/Max)

E = 0.001:1e-4:30;
for v = [0.1 0.2]
    V0 = v;
    [Ef, Et, E2] = bordes(E);
    Eg = E2 - Et;
    V1 = (V0/pi)*sin(pi*d/a);
    fprintf('V0=%.2f  Eg=%.5f  2|V1|=%.5f  cociente=%.3f\n', ...
            V0, Eg, 2*abs(V1), Eg/(2*abs(V1)));
end

V0 = 0.1;
[~, Et, E2] = bordes(E);
rk = k(E);
kk = [-fliplr(rk), NaN, rk];
EE = [ fliplr(E),  NaN,  E];

fig = figure;
t = tiledlayout(2,1,'TileSpacing','compact','Padding','compact');
sgtitle(t, 'Electrón casi libre, V_0 = 0.1 eV')
nexttile
plot(kk, EE, 'b')
ylabel('E (eV)')
title('(a) Estructura de bandas')
xlim([-pi/a pi/a])
grid on
nexttile
plot(kk, EE, 'b')
yline(Et, 'r--')
yline(E2, 'r--')
xlabel('k (Å^{-1})')
ylabel('E (eV)')
title(sprintf('(b) Zoom'))
xlim([-pi/a pi/a])
ylim([Et-0.15, E2+0.15])
grid on
guardarfig(fig, fullfile(figdir, 'fig_casilibre.png'));

%% Potencial fuerte y estados de superficie
a  = 4.05/sqrt(3);
d = a/2;  V0 = 0.1;
[~, Et_nfe, E2_nfe] = bordes(0.001:1e-4:30);
Eg_nfe = E2_nfe - Et_nfe;

d  = 1;  V0 = 5;
E  = 0.01:0.005:35;
[Ef, Et, E2] = bordes(E);
Eg = E2 - Et;
fprintf('Potencial fuerte: banda 1 = %.3f a %.3f eV\n', Ef, Et)
fprintf('Primera brecha Eg = %.3f eV  (casi libre Eg = %.4f eV)\n', Eg, Eg_nfe)
fprintf('La primera brecha aumento por un factor %.1f\n', Eg/Eg_nfe)

[rk, ik] = k(E);
ik = abs(ik);
ik(ik == 0) = NaN;
kk  = [-fliplr(rk), NaN, rk];
kki = [-fliplr(ik), NaN, ik];
EE  = [ fliplr(E),  NaN,  E];

fig = figure;
t = tiledlayout(2,1,'TileSpacing','compact','Padding','compact');
sgtitle(t, sprintf('Potencial fuerte'))
nexttile
plot(kk, EE, 'b')
ylabel('E (eV)')
title('(a) Estructura de bandas')
xlim([-pi/a pi/a])
grid on
nexttile
hold on
plot(kk,  EE, 'b')
plot(kki, EE, 'r')
hold off
xlabel('k (Å^{-1})')
ylabel('E (eV)')
title('(b) Estados de superficie: Re k e Im k')
legend('Re k', 'Im k', 'Location', 'southeast')
grid on
guardarfig(fig, fullfile(figdir, 'fig_fuerte.png'));

Ec = (Et + E2)/2;
[~, kappa] = k(Ec);
kappa = abs(kappa);
fprintf('Centro de la 1a brecha: E = %.3f eV, |Im k| = %.4f 1/A\n', Ec, kappa)
fprintf('Longitud de decaimiento = %.2f A = %.2f capas atomicas\n', 1/kappa, 1/(kappa*a))

%% Velocidad de grupo y masa efectiva
a  = 4.05/sqrt(3);
d  = a/2;
V0 = 0.1;
[Ef, Et] = bordes(0.001:1e-4:30);
E  = linspace(Ef + 1e-3, Et - 1e-3, 200001);
dk = gradient(k(E), E);
vgE = 1./(hbar*dk);
ms  = -(hbar^2)*dk.^3./(me*gradient(dk, E));
fprintf('vg max = %.4e A/s = %.3f%% de c\n', max(abs(vgE)), 100*max(abs(vgE))/c);

rk = k(E);
kk = [-fliplr(rk), NaN, rk];
vv = [-fliplr(vgE), NaN, vgE];

fig = figure;
t = tiledlayout(2,1,'TileSpacing','compact','Padding','compact');
nexttile
plot(kk, vv, 'b')
yline(0, 'k:')
xlabel('k (Å^{-1})')
ylabel('v_g (Å/s)')
title('(a) Velocidad de grupo')
grid on
nexttile
plot(E, ms, 'b')
yline(0, 'k:')
ylim([-5 5])
xlabel('E (eV)')
ylabel('m^*/m_e')
title('(b) Masa efectiva')
grid on
guardarfig(fig, fullfile(figdir, 'fig_vgmasa.png'));

%% --------- funcion local ---------

function guardarfig(fig, archivo)
% exportgraphics sobre el handle, no print(gcf): print dispara el
% exportHelper de la barra de la figura y truena si la figura ya no vale.
    if ~isgraphics(fig, 'figure'), return; end
    try
        exportgraphics(fig, archivo, 'Resolution', 200);
    catch ME
        warning('No se pudo guardar %s: %s', archivo, ME.message);
    end
end