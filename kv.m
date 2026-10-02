% kv(E)
% kv(E) calcula k a partir de la ecuacion (10) del guion.
%
% Region II (pozo, iones): ancho d,  alpha = sqrt(2 m E)/hbar
% Region I  (barrera):     ancho s,  beta  = sqrt(2 m (E-V0))/hbar
%
% F = cos(alpha d) cos(beta s) - ((alpha^2+beta^2)/(2 alpha beta))
%     * sin(alpha d) sin(beta s)

function ik = kv(E)
    global me hbar V0 a d
    s = a-d;

    E(E <= 0) = eps;                        % evita alpha = 0  -> 0/0
    E(abs(E - V0) < 1e-12) = V0 + 1e-12;    % evita beta  = 0  -> 0/0

    alpha = sqrt( 2*me.*E/hbar^2   );       % region II, pozo de ancho d
    beta  = sqrt( 2*me.*(E-V0)/hbar^2   );  % region I,  barrera de ancho s

    F = cos(alpha.*d).*cos(beta.*s) - ((alpha.^2 + beta.^2)./(2.*alpha.*beta)).*sin(alpha.*d).*sin(beta.*s);
    % Eq. (10) is real. For E < V0, beta is imaginario y MATLAB deja un
    % residuo complejo en F: acos(F) sale complejo, k.m pone NaN en toda
    % la banda y bordes truena (find vacio).
    F = real(F);
    ik = acos(F) ./ a;
end
