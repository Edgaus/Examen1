% kv(E) 
% kv(E) calculates the real part of the wave vector as a function of energy. 

function ik = kv(E)
    global me hbar V0 a d
    s = a-d;

    E(E <= 0) = eps;                        % evita alpha = 0  -> 0/0
    E(abs(E - V0) < 1e-12) = V0 + 1e-12;    % evita beta  = 0  -> 0/0

    alpha = sqrt( 2*me.*E/hbar^2   );
    beta =  sqrt( 2*me.*(E-V0)/hbar^2   );

    F = cos(beta.*d).*cos(alpha.*s) - ((beta.^2 + alpha.^2)./(2.*alpha.*beta)).*sin(beta.*d).*sin(alpha.*s);
    ik = acos(F) ./ a;
end

