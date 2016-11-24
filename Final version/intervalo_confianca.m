
function [pMin, pMax] = intervalo_confianca(estimativaPontual, N)

    desvioPadrao = sqrt(estimativaPontual * (1 - estimativaPontual) / N);
   
    z = 1.96; % valor cr�tico de z para um n�vel de 95% de confian�a

    pMin = estimativaPontual - z * desvioPadrao;
    
    pMax = estimativaPontual + z * desvioPadrao;

end
