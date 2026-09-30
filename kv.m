function ik = kv(E)
    
    global me hbar V0 a d
    s = a-d;

    alpha = sqrt( 2*me.*E/hbar^2   );
    beta =  sqrt( 2*me.*(E-V0)/hbar^2   );

    F = cos(alpha.*d).*cos(beta.*s) - ((beta.^2 + alpha.^2)./(2.*alpha.*beta)).*sin(alpha.*d).*sin(beta.*s);
    ik = acos(F) ./ a;
end