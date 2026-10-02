% Diferencia entre la parte real e imaginario. Si es imaginaria sustituye
% por Nan en el vector real

function [rkvE, ikvE] = k(E)
    
    kE=kv(E); 
    ikvE = imag(kE);

    for j=1:1:length(kE) 
        if (abs(kE(j)) ~= real(kE(j)))  
            kE(j)=NaN; 
        end
    end
    rkvE = real(kE);
end


