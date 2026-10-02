function [rkvE, ikvE] = k(E)
% k(E)  parte real de kv(E); NaN dentro de las brechas.
% Segunda salida: parte imaginaria (estados de superficie).
% La zona extendida va en kext.m: ke = kext(E).

    kE   = kv(E);
    ikvE = imag(kE);
    rkvE = real(kE);
    rkvE(abs(ikvE) > 1e-10) = NaN;

end
