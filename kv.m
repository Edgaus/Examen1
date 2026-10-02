% kv(E)  Soluciona las ecuaciones del modelo Kroing-Penney

function ik = kv(E)
    global me hbar V0 a d
    s = a-d;

    E(E <= 0) = eps;
    E(abs(E - V0) < 1e-12) = V0 + 1e-12;

    alpha = sqrt( 2*me.*E/hbar^2   );       % pozo, ancho d
    beta  = sqrt( 2*me.*(E-V0)/hbar^2   );  % barrera, ancho s

    F = cos(alpha.*d).*cos(beta.*s) - ((alpha.^2 + beta.^2)./(2.*alpha.*beta)).*sin(alpha.*d).*sin(beta.*s);
    F = real(F);
    ik = acos(F) ./ a;
end

