function s = distance(x,v,p,ind)

    %recebe o x_j-�simo atributo
    %calcula a j-esima distancia a partir da equacao 6 do paper
    %p: tamanho do somatorio (n�mero de vari�veis ou atributos)
    %i: i-�simo objeto (vetor de atributos)
    %k: k-�simo objeto (vetor de atributos)
    %ind: necess�rio para o kernel gaussiano (posi��o ind do vetor sigma
    
    soma =0;
    
    for j=1:p
        soma = soma + gaussian_kernel(x,x,ind) - 2*gaussian_kernel(x,v,ind) + gaussian_kernel(v,v,ind);
    end
    
    s = soma;
    
end
