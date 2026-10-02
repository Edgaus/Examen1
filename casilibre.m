% casilibre
% Electron casi libre: se levanta la barrera a V0 = 0.1 eV y se compara la
% primera brecha con 2|V1|, el primer coeficiente de Fourier del potencial.
% Requiere haber ejecutado main.m antes.

global me hbar V0 a d

a = 4.05/sqrt(3);   % el periodo sigue siendo la distancia entre planos (111)
d = a/2;

% La barrera es baja comparada con la energia cinetica en el borde de la
% primera zona, que es la escala con la que hay que comparar V0.
Eborde = (hbar^2/(2*me))*(pi/a)^2;
fprintf('Energia cinetica en el borde de zona: %.4f eV\n', Eborde)

% Paso fino: con 0.1 eV la brecha de ~0.06 eV no se resuelve.
E = 0.001:1e-4:30;

for v = [0.1 0.2]
    V0 = v;                            % V0 es global; no puede ser indice del for
    [Ef, Et, E2] = bordes(E);
    Eg = E2 - Et;
    V1 = (V0/pi)*sin(pi*d/a);          % ecuacion (12)
    fprintf('V0=%.2f  Ef=%.4f  Eg=%.5f  2|V1|=%.5f  cociente=%.3f\n', ...
            V0, Ef, Eg, 2*abs(V1), Eg/(2*abs(V1)))
end

V0 = 0.1;
rk = k(E);

% La rama k < 0 es el reflejo de la positiva, porque E(k) = E(-k).
% El NaN evita que plot una las dos ramas con un segmento espurio.
kk = [-fliplr(rk), NaN, rk];
EE = [ fliplr(E),  NaN,  E];

figure
plot(kk, EE, 'b')
xlabel('k (Å^{-1})')
ylabel('E (eV)')
title('Estructura de bandas: electrón casi libre, V_0 = 0.1 eV')
xlim([-pi/a pi/a])
grid on
