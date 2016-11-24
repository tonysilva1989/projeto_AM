function s = distance(x,v,p,ind)

    %recebe o x_j-ésimo atributo
    %calcula a j-esima distancia a partir da equacao 6 do paper
    %p: tamanho do somatorio (número de variáveis ou atributos)
    %i: i-ésimo objeto (vetor de atributos)
    %k: k-ésimo objeto (vetor de atributos)
    %ind: necessário para o kernel gaussiano (posição ind do vetor sigma
    
    soma =0;
    
    for j=1:p
        soma = soma + gaussian_kernel(x,x,ind) - 2*gaussian_kernel(x,v,ind) + gaussian_kernel(v,v,ind);
    end
    
    s = soma;
    
end
