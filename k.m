function [rkvE, ikvE] = k(E)
    
    kE=kv(E); 
    ikvE = imag(kE);

    for j=1:1:length(kE) 
        if (abs(kE(j)) ~= real(kE(j))) % returns NaN in 
            kE(j)=NaN; % the band gap 
        end
        
    end
    rkvE =  kE;
end


