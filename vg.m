% vg(E)
% Velocidad de grupo vg = (1/hbar) dE/dk, obtenida de k(E) por
% diferencias finitas: vg = 1 / (hbar * dk/dE).

function vgE = vg(E)
    global hbar
    dk = gradient(k(E), E);
    vgE = 1./(hbar * dk);
end
