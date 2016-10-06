function s = distance(x,v,p,sigma,@gaussian_kernel)

    %recebe o x_j-ésimo atributo
    %calcula a j-esima distancia a partir da equacao 6 do paper
    %p: tamanho do somatorio
    %i: i-ésimo objeto (vetor de atributos)
    %k: k-ésimo objeto (vetor de atributos)
    %sigma: necessário para o kernel gaussiano
    
    soma =0;
    
    for j=1:p
        soma = soma + gaussian_kernel(x,x,sigma) - 2*gaussian_kernel(x,v,sigma) + gaussian_kernel(v,v,sigma);
    end
    
    s = soma;
    
end