
function posteriori = ProbabilidadePosteriori(elemento, K, priori, densidade)
    posteriori = zeros(1, K);    

    denominador = 0;

    for k = 1 : K
        denominador = denominador + densidade(elemento, k) * priori(k);
    end

    for k = 1 : K        
        posteriori(k) = densidade(elemento, k) * priori(k) / denominador;
    end
end