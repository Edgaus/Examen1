% ext_superred
% EXTENSION: el mismo analisis aplicado a una superred de semiconductores a lo
% largo de la direccion de crecimiento [001], que es donde el modelo de
% Kronig-Penney deja de ser una caricatura y pasa a ser EL modelo estandar: en una
% superred el potencial periodico de pozos y barreras es literalmente el que se
% fabrica por epitaxia, y el periodo a = Lw + Lb es de nm en vez de A.
%
% Respecto al examen hay dos cambios fisicos:
%   - las masas efectivas del pozo y de la barrera son distintas, lo que obliga a
%     usar la condicion de frontera de BenDaniel-Duke (continuidad de (1/m)dpsi/dx
%     en vez de dpsi/dx) -> ver ext_Fsl.m, que se reduce a la ecuacion (10) del
%     guion cuando mw = mb;
%   - hay que repetir el calculo para electrones y para huecos pesados, porque lo
%     que se mide opticamente es la suma de los anchos de las dos minibandas.
%
% Referencias para comparar:
%   - R. Dingle, A. C. Gossard y W. Wiegmann, Phys. Rev. Lett. 34, 1327 (1975):
%     primera observacion de la formacion de minibandas en una superred.
%   - K. Fujiwara et al., Phys. Rev. B 49, 1809 (1994): singularidades de borde de
%     minibanda en superredes GaAs/AlAs, con "excelente acuerdo entre las energias
%     de transicion observadas y los anchos de minibanda deducidos de calculos
%     con el modelo de Kronig-Penney".
%   - J. Appl. Phys. 59, 3835 (1986): KP frente a fotoluminiscencia y PLE, y
%     sensibilidad al offset de banda de conduccion.
%   - Caso A de abajo: superred GaAs(4.1 nm)/AlAs(0.90 nm), para la que se midio
%     un ancho optico de minibanda de 24 +- 3 meV (Solid State Commun. 1989,
%     doi:10.1016/0038-1098(89)90123-3).
%   - Para barreras de AlAs ultradelgadas hay mezcla Gamma-X, que el KP simple no
%     contiene: N. J. Pulsford et al., Phys. Rev. Lett. 63, 2284 (1989), y la
%     extension del KP de Zhang, Cohen y Louie, Phys. Rev. B 43, 9951 (1991).
%   - Comparacion [001] frente a [110]: Semicond. Sci. Technol. 5, 015 (1990),
%     que usa precisamente KP mas pseudopotenciales.

kpmain
global me

EgGaAs = 1.519;      % brecha del GaAs a 2 K [eV]

% Parametros de cada caso: Lw [A], Lb [A], Vb_e, mw_e, mb_e, Vb_h, mw_h, mb_h
% (masas en unidades de me; offsets con la regla 65:35)
casos = { ...
    'A: GaAs 4.1 nm / AlAs 0.90 nm',      41, 9,  1.047, 0.067, 0.150, 0.563, 0.340, 0.476; ...
    'B: GaAs 5 nm / Al(0.3)Ga(0.7)As 2 nm', 50, 20, 0.243, 0.067, 0.092, 0.131, 0.340, 0.400};

fprintf('\n===== EXT: superred de semiconductores a lo largo de [001] =====\n');

for i = 1:1:size(casos, 1)
    nombre = casos{i,1};
    Lw_ = casos{i,2};  Lb_ = casos{i,3};
    [e1, e2, We] = ext_minibanda(1, casos{i,4}, casos{i,5}*me, casos{i,6}*me, Lw_, Lb_, 0.99*casos{i,4});
    [h1, h2, Wh] = ext_minibanda(1, casos{i,7}, casos{i,8}*me, casos{i,9}*me, Lw_, Lb_, 0.99*casos{i,7});

    fprintf('\n%s   (periodo a = %.1f A = %.2f nm)\n', nombre, Lw_ + Lb_, (Lw_ + Lb_)/10);
    fprintf('  minibanda e1 : %7.2f ... %7.2f meV   ancho %6.2f meV\n', 1e3*e1, 1e3*e2, 1e3*We);
    fprintf('  minibanda hh1: %7.2f ... %7.2f meV   ancho %6.2f meV\n', 1e3*h1, 1e3*h2, 1e3*Wh);
    fprintf('  transicion e1-hh1: %.4f eV en el centro de la mini-zona (Gamma),\n', EgGaAs + e1 + h1);
    fprintf('                     %.4f eV en el borde (pi/a)  ->  ancho optico %.1f meV\n', ...
            EgGaAs + e2 + h2, 1e3*(We + Wh));

    % Estructura de minibandas
    E = linspace(1e-4, 0.99*casos{i,4}, 40001);
    global mw mb Vb Lw Lb
    mw = casos{i,5}*me; mb = casos{i,6}*me; Vb = casos{i,4}; Lw = Lw_; Lb = Lb_;
    aSL = Lw + Lb;
    kk = real(acos(ext_Fsl(E)))/aSL;
    kk(abs(ext_Fsl(E)) > 1) = NaN;

    figure(10 + i); clf
    plot(kk*aSL/pi, 1e3*E, 'b-', 'LineWidth', 2)
    xlabel('k a/\pi'); ylabel('E [meV]')
    title(sprintf('Minibandas de electrones, %s', nombre))
    xlim([0 1]); grid on
end

fprintf('\nAVISO IMPORTANTE sobre el caso A: el KP simple da un ancho optico de\n');
fprintf('  unos 67 meV frente a los 24 +- 3 meV medidos. La discrepancia no es un\n');
fprintf('  error del programa sino fisica que falta en el modelo: con barreras de\n');
fprintf('  AlAs de menos de ~1.5 nm los estados X del AlAs se mezclan con los Gamma\n');
fprintf('  del GaAs (mezcla Gamma-X) y el ancho optico medido esta ademas reducido por\n');
fprintf('  efectos excitonicos, que cambian de un borde de minibanda al otro.\n');
fprintf('  Para quedarse en el regimen donde el KP simple es fiable conviene usar\n');
fprintf('  barreras de 2 nm o mas y Al(x)Ga(1-x)As con x <= 0.3, como en el caso B.\n');
