% V1kp
% Primer coeficiente de Fourier del potencial de Kronig-Penney, ecuacion (12).
%
% Con la barrera de altura V0 y ancho d centrada en el origen:
%
%   V1 = (1/a) int_{-d/2}^{d/2} V0 exp(-2 pi i x/a) dx = (V0/pi) sin(pi d/a)
%
% El modulo no depende de donde se ponga el origen, asi que 2|V1| = (2 V0/pi) sin(pi d/a)
% es la prediccion de electrones casi libres para la primera brecha. Para d = a/2
% queda 2|V1| = 2 V0/pi = 0.6366 V0, proporcional a V0.
function [res] = V1kp()

global V0 a d

res = (V0/pi)*sin(pi*d/a);

end
