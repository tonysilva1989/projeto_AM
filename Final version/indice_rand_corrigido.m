
function [indiceRandCorrigido, tabela] = indice_rand_corrigido(P1, P2, N, K)
    
    X = 0;
    
    tabela = '\t\tv1\t\tv2\t\tv3\t\tT';  
        
    NI = zeros(1, K);
    NJ = zeros(1, K);
    
    for k = 1 : K
       NI(1, k) = size(P1{1, k}, 2); 
       NJ(1, k) = size(P2{1, k}, 2); 
    end
    
    NIJ = zeros(K, K);
        
    for elemento = 1 : N
        i = classe_elemento(P1, K, elemento);            
        j = classe_elemento(P2, K, elemento);  
                
        NIJ(i, j) = NIJ(i, j) + 1;
    end    
     
    for i = 1 : K
        tabela = strcat(tabela, strcat('\nu', num2str(i)));
        
        for j = 1 : K    
            if(NIJ(i, j) >= 2)
                X = X + nchoosek(NIJ(i, j), 2);
            end
           
            tabela = strcat(tabela, strcat('\t\t', num2str(NIJ(i, j))));
        end
        
        tabela = strcat(tabela, strcat('\t\t', num2str(sum(NIJ(i, :)))));
    end   
    
    tabela = strcat(tabela, '\nT');
    
    for i = 1 : K
        tabela = strcat(tabela, strcat('\t\t', num2str(sum(NIJ(:, i)))));
    end
    
    tabela = strcat(tabela, strcat('\t\t', strcat(num2str(sum(sum(NIJ))), '\n')));

    n2 = nchoosek(N, 2);
    
    mult1 = 0;
    mult2 = 0;
    
    for k = 1 : K
        if(NI(1, k) >= 2)
            mult1 = mult1 + nchoosek(NI(1, k), 2);
        end
        
        if(NJ(1, k) >= 2)
            mult2 = mult2 + nchoosek(NJ(1, k), 2);
        end
    end  
    
    Y = (mult1 * mult2) / n2;
       
    Z = (mult1 + mult2) / 2;
    
    indiceRandCorrigido = (X - Y) / (Z - Y);

end
