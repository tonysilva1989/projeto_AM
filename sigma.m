function out = sigma(x,v,i,k,p)
    %x,v: vetores de atributos e centroides
    %i,j: i-ésima e k-ésima posições dos vetores de entrada
    
    ind =1;
    %o tamanho de array será (n-1)??
    for j=1:p
        
        for i=1:n
            for k=1:n
                if (i ~= k)
                   array(ind) = (abs(x(i,j) - v(k,j)))^2;
                   ind = ind+1;
                end                
            end
        end
            ind =1;
        
        sigma(j) = (quantile(array,0.1) + quantile(array,0.9))/2.0; %valor do vetor sigma
        
    end
    
    
end