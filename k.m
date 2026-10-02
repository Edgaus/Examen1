function [rkvE, ikvE] = k(E)

    kE   = kv(E);
    ikvE = imag(kE);
    rkvE = real(kE);
    rkvE(abs(ikvE) > 1e-10) = NaN;   % brecha: k complejo, no hay Bloch propagante

end
