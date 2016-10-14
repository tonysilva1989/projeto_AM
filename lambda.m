function out = lambda(P,v,i,k,v_distance,l,j,P_k,K)

    %P,v; vetores de entrada x e v (P refer-se aos objetos x que pertencem
    %� k-�sima parti��o fornecida
    %i,k: i-�simo vetor x e k-�simo vetor v
    %distance: vetor que armazena os valores de dist�ncia
    %l,j: posi��es do vetor de dist�ncia que ser�o utilizadas
    %P_k: tamanho da k-�sima parti��o P ( os 3 possuem o msm tamanho?)
    %@distance: fun��o para calcular a dist�ncia
    %K: limite superior do 2� somat�rio (centroides v)
    
    p=3; %n�mero de atributos (da base de dados?)
    prod=1; %inicializa��o do produt�rio
    numer =0;
    
    %calculando o numerador:
    for l=1:p
        for k=1:K
            for i=1:P_k
               v_distance(l) = v_distance(l) + distance(P(i,l,k),v(k,l),p);
            end
        end
        prod = prod*v_distance(l); %opera��o de produt�rio
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