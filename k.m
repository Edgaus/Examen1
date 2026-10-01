% k(E)
% k(E) calculates the real part of the wave vector as a function of
% energy. Devuelve NaN dentro de las brechas de energia, de modo que plot(k(E),E)
% dibuja directamente la estructura de bandas en la primera zona de Brillouin.
function [res] = k(E)

vect = kv(E);
le = length(vect);
for j = 1:1:le
    if (abs(vect(j)) ~= real(vect(j)))      % returns NaN in
        vect(j) = NaN;                      % the band gap
    end
end
res = vect;

end
