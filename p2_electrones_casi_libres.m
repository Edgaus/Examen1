% p2_electrones_casi_libres
% PREGUNTAS (pag. 8 y 9, en rojo):
%   1) "Now raise the potential barrier to 0.1 eV. Why is this a low barrier -
%       to which quantity should you compare in order to decide whether the
%       barrier is low or high?"
%   2) "Can you find any energy gap between the first and second band? - Zoom
%       into the figure in order to determine the size of the bandgap. Note that
%       you will obtain too large a value if you plot in large steps."
%   3) "Calculate V1 and compare 2|V1| with the value that you obtained from your
%       plot. [...] Set V0 = 0.2 and check whether this is true for your KP model."

kpmain
global me hbar V0 a d

d = a/2;

% --- Escalas de energia con las que hay que comparar la barrera ---------------
Eza = (hbar^2/(2*me))*(pi/a)^2;   % energia del electron libre en el borde de zona
EF3D = 11.7;                       % energia de Fermi del Al metalico [eV], referencia

fprintf('\n===== P2: electrones casi libres =====\n');
fprintf('a = %.4f A, d = a/2 = %.4f A\n', a, d);
fprintf('Energia de electron libre en el borde de zona, E(pi/a) = %.4f eV\n', Eza);
fprintf('Ancho de la primera banda (V0=0) = %.4f eV\n', Eza);
fprintf('Energia de Fermi del Al (3D, referencia) = %.1f eV\n', EF3D);
fprintf(['RESPUESTA 1: "alta" o "baja" no tiene sentido en absoluto, hay que comparar\n' ...
         '  V0 con la escala de energia cinetica del electron en la red, es decir con el\n' ...
         '  ancho de banda / la energia del electron libre en el borde de zona\n' ...
         '  E(pi/a) = hbar^2 pi^2/(2 me a^2) = %.2f eV (equivalentemente con E_F).\n' ...
         '  V0 = 0.1 eV es solo el %.2f%% de esa energia (%.2f%% de E_F del Al), de modo\n' ...
         '  que el potencial es una perturbacion debil: regimen de electrones casi libres.\n'], ...
        Eza, 100*0.1/Eza, 100*0.1/EF3D);

% --- Brecha para V0 = 0.1 y V0 = 0.2 -----------------------------------------
V0lista = [0.1 0.2];
gap1 = zeros(size(V0lista));
V1v  = zeros(size(V0lista));

for i = 1:1:length(V0lista)
    V0 = V0lista(i);

    [bandas, gaps] = brechas(1e-4, 30);
    gap1(i) = gaps(1, 2) - gaps(1, 1);
    V1v(i)  = V1kp();

    fprintf('\n--- V0 = %.2f eV ---\n', V0);
    fprintf('Primera banda : %.6f  ...  %.6f eV\n', bandas(1,1), bandas(1,2));
    fprintf('Segunda banda : %.6f  ...  %.6f eV\n', bandas(2,1), bandas(2,2));
    fprintf('Primera brecha: %.6f  ...  %.6f eV  ->  Eg1 = %.6f eV\n', ...
            gaps(1,1), gaps(1,2), gap1(i));
    fprintf('V1 = (V0/pi) sin(pi d/a) = %.6f eV   ->   2|V1| = %.6f eV\n', V1v(i), 2*abs(V1v(i)));
    fprintf('Eg1(KP)/2|V1| = %.4f\n', gap1(i)/(2*abs(V1v(i))));

    % Efecto del paso de la malla: con pasos de 0.1 eV la brecha se sobreestima
    Eg = 0.1:0.1:30;
    kg = k(Eg);
    i0 = find(~isnan(kg), 1);                    % primer punto permitido
    ih = find(isnan(kg(i0:end)), 1);             % primer hueco tras la primera banda
    if isempty(ih)
        fprintf('Con pasos de 0.1 eV la brecha no se resuelve: ningun punto cae dentro\n');
    else
        idx = i0 + ih - 1;
        n = 0;
        while idx + n <= length(kg) && isnan(kg(idx + n))
            n = n + 1;
        end
        fprintf('Con pasos de 0.1 eV la brecha aparente seria ~%.2f eV (sobreestimada)\n', (n + 1)*0.1);
    end

    figure(1 + i); clf
    E = linspace(1e-3, 30, 40001);
    subplot(1, 2, 1)
    plot(k(E), E, 'b-', 'LineWidth', 2)
    xlabel('k [1/A]'); ylabel('E [eV]')
    title(sprintf('KP, V_0 = %.2f eV, d = a/2', V0)); grid on
    axis([0 pi/a 0 30])

    subplot(1, 2, 2)
    Ez = linspace(gaps(1,1) - 10*gap1(i), gaps(1,2) + 10*gap1(i), 20001);
    plot(k(Ez), Ez, 'b-', 'LineWidth', 2); hold on
    plot([0 pi/a], [gaps(1,1) gaps(1,1)], 'r--')
    plot([0 pi/a], [gaps(1,2) gaps(1,2)], 'r--')
    hold off
    xlabel('k [1/A]'); ylabel('E [eV]')
    title(sprintf('Zoom 1a brecha: E_g = %.4f eV', gap1(i))); grid on
end

fprintf('\nRESPUESTA 2: si, hay brecha en el borde de zona k = pi/a. Para V0 = 0.1 eV\n');
fprintf('  vale Eg1 = %.5f eV (obtenida resolviendo |F(E)| = 1 por biseccion, no leyendo\n', gap1(1));
fprintf('  la malla del grafico: con pasos de 0.1 eV el valor saldria sobreestimado).\n');
fprintf('RESPUESTA 3: 2|V1| = 2(V0/pi) sin(pi d/a) = 2 V0/pi para d = a/2:\n');
fprintf('  V0 = 0.10 eV  ->  2|V1| = %.5f eV,  Eg1(KP) = %.5f eV  (cociente %.3f)\n', ...
        2*abs(V1v(1)), gap1(1), gap1(1)/(2*abs(V1v(1))));
fprintf('  V0 = 0.20 eV  ->  2|V1| = %.5f eV,  Eg1(KP) = %.5f eV  (cociente %.3f)\n', ...
        2*abs(V1v(2)), gap1(2), gap1(2)/(2*abs(V1v(2))));
fprintf('  Eg1(0.2)/Eg1(0.1) = %.4f y 2|V1|(0.2)/2|V1|(0.1) = %.4f: al duplicar V0 se\n', ...
        gap1(2)/gap1(1), abs(V1v(2))/abs(V1v(1)));
fprintf('  duplica la brecha, es decir Eg1 es proporcional a V0 y el modelo KP confirma\n');
fprintf('  la prediccion de electrones casi libres Eg1 = 2|V1|.\n');
