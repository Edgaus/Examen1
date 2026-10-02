% main.m
% Estructura de bandas de Al [111] con el modelo de Kronig-Penney.
% Equivalente al live script main.mlx, para incluirlo en el apendice.

global me hbar V0 a d

me = 5.68572e-32;  hbar = 6.58199e-16;
c  = 2.99792458e18;        % velocidad de la luz en A/s
a  = 4.05/sqrt(3);         % distancia entre planos (111) del Al = 2.3383 A
d  = a/2;
V0 = 0;                    % electron libre

set(groot, 'defaultLineLineWidth', 2)
set(groot, 'defaultAxesLineWidth', 1)
set(groot, 'defaultAxesFontSize', 12)

if ~exist('figures','dir'), mkdir('figures'); end

%% Electron libre: zona reducida y zona extendida
V0 = 0;
E = 0.1:0.01:30;

[rk, ~, ke] = k(E);
kk  = [-fliplr(rk), NaN, rk];
EE  = [ fliplr(E),  NaN,  E];
kke = [-fliplr(ke), NaN, ke];
kl  = fek(E);
kkl = [-fliplr(kl), NaN, kl];

figure
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
print(gcf, 'figures/fig_libre.png', '-dpng', '-r200');
max(abs(ke - fek(E)))

%% Electron casi libre
a = 4.05/sqrt(3);
d = a/2;
Eborde = (hbar^2/(2*me))*(pi/a)^2
fprintf('Eborde = %.4f eV;  V0 = 0.1 eV es el %.2f %% de esa escala.\n', ...
        Eborde, 100*0.1/Eborde)

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

figure
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
title(sprintf('(b) Zoom: E_g = %.4f eV  (2|V_1| = %.4f eV)', ...
      E2-Et, 2*abs((V0/pi)*sin(pi*d/a))))
xlim([-pi/a pi/a])
ylim([Et-0.15, E2+0.15])
grid on
print(gcf, 'figures/fig_casilibre.png', '-dpng', '-r200');

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

figure
t = tiledlayout(2,1,'TileSpacing','compact','Padding','compact');
sgtitle(t, sprintf('Potencial fuerte, V_0 = 5 eV, d = 1 Å  (E_g aumento x%.1f)', Eg/Eg_nfe))
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
print(gcf, 'figures/fig_fuerte.png', '-dpng', '-r200');

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

figure
t = tiledlayout(2,1,'TileSpacing','compact','Padding','compact');
sgtitle(t, 'Primera banda, V_0 = 0.1 eV')
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
print(gcf, 'figures/fig_vgmasa.png', '-dpng', '-r200');
