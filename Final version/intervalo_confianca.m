
function [pMin, pMax] = intervalo_confianca(estimativaPontual, N)

    desvioPadrao = sqrt(estimativaPontual * (1 - estimativaPontual) / N);
   
    z = 1.96; % valor crítico de z para um nível de 95% de confiança

    pMin = estimativaPontual - z * desvioPadrao;
    
    pMax = estimativaPontual + z * desvioPadrao;

end
