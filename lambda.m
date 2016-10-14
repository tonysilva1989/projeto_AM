function out = lambda(P,v,i,k,v_distance,l,j,P_k,K)

    %P,v; vetores de entrada x e v (P refer-se aos objetos x que pertencem
    %à k-ésima partição fornecida
    %i,k: i-ésimo vetor x e k-ésimo vetor v
    %distance: vetor que armazena os valores de distância
    %l,j: posições do vetor de distância que serão utilizadas
    %P_k: tamanho da k-ésima partição P ( os 3 possuem o msm tamanho?)
    %@distance: função para calcular a distância
    %K: limite superior do 2º somatório (centroides v)
    
    p=3; %número de atributos (da base de dados?)
    prod=1; %inicialização do produtório
    numer =0;
    
    %calculando o numerador:
    for l=1:p
        for k=1:K
            for i=1:P_k
               v_distance(l) = v_distance(l) + distance(P(i,l,k),v(k,l),p);
            end
        end
        prod = prod*v_distance(l); %operação de produtório
    end
    
    numer = prod^(1/p);
    
    %calculando o denominador:
    for k=1:K
        for i=1:P_k
           v_distance(j) = v_distance(j) + distance(P(i,j,k),v(k,j),p);
        end
    end

    out = numer/v_distance(j);
    
    
    
end