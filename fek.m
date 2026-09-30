% Free electons model exact

function fekE = fek(E)

    global me hbar

    fekE = sqrt(2*me.*E/hbar^2);

end

