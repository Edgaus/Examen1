% p4_estados_superficie
% PREGUNTAS (pag. 9, en rojo):
%   "Plot the imaginary part of k[E]. To this end, implement a function imk(E)
%    that calculates the imaginary part of the wave vector. Comment on your
%    results. [...] Over how many atomic layers does a surface state extend in
%    the center of the first bandgap?"

kpmain
global V0 a d

V0 = 5;  d = 1;          % se continua con el potencial fuerte del apartado anterior

[bandas, gaps] = brechas(1e-4, 35);
E = linspace(1e-3, 35, 60001);

figure(6); clf
subplot(1, 2, 1)
plot(k(E), E, 'b-', 'LineWidth', 2)
xlabel('Re k [1/A]'); ylabel('E [eV]')
title('Parte real: bandas permitidas'); grid on
axis([0 pi/a 0 35])

subplot(1, 2, 2)
plot(imk(E), E, 'r-', 'LineWidth', 2)
xlabel('|Im k| [1/A]'); ylabel('E [eV]')
title('Parte imaginaria: solo existe en las brechas'); grid on
ylim([0 35])

fprintf('\n===== P4: estados de superficie (parte imaginaria de k) =====\n');
fprintf('V0 = %.1f eV, d = %.1f A, a = %.4f A\n', V0, d, a);

fprintf('\nBrecha  E_inf     E_sup     E_centro   |Im k|_centro  1/|Im k|   capas = 1/(|Im k| a)\n');
for i = 1:1:min(4, size(gaps, 1))
    Ec  = 0.5*(gaps(i,1) + gaps(i,2));
    kap = imk(Ec);
    fprintf('  %d   %8.4f  %8.4f  %8.4f   %10.5f   %8.4f A   %6.2f\n', ...
            i, gaps(i,1), gaps(i,2), Ec, kap, 1/kap, 1/(kap*a));
end

Ec1   = 0.5*(gaps(1,1) + gaps(1,2));
kap1  = imk(Ec1);
ncapas = 1/(kap1*a);

fprintf('\nRESPUESTA: dentro de la brecha F(E) > 1 en valor absoluto, acos(F) es complejo y\n');
fprintf('  k = Re k + i|Im k| con Re k = 0 o pi/a. |Im k| se anula en los bordes de banda,\n');
fprintf('  crece hacia el interior de la brecha y es maxima aproximadamente en su centro:\n');
fprintf('  es exactamente el comportamiento de la figura 12 (pag. 196) de Kittel, 7a ed.\n');
fprintf('  Esa k imaginaria no describe estados de volumen (la amplitud divergeria en una\n');
fprintf('  direccion) sino estados de superficie: con B = 0 en la ecuacion (13) la funcion\n');
fprintf('  de onda vale A en la superficie y decae como exp(-|Im k| x) hacia el interior.\n');
fprintf('  En el centro de la primera brecha (E = %.4f eV): |Im k| = %.5f 1/A,\n', Ec1, kap1);
fprintf('  longitud de penetracion 1/|Im k| = %.4f A, es decir %.2f capas atomicas\n', 1/kap1, ncapas);
fprintf('  (a = %.4f A). O sea que el estado de superficie esta confinado a unas %d-%d\n', ...
        a, floor(ncapas), ceil(ncapas));
fprintf('  capas atomicas: cuanto mayor es la brecha, mas localizado esta el estado.\n');
