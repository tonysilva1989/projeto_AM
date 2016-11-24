<<<<<<< HEAD:tony - incompleta/sigma.m
function out = sigma(x,p)
    %x: vetor de atributos
    %i,j: i-ésima e k-ésima posições dos vetores de entrada
=======
function out = sigma(x,v,i,k,p)
    %x,v: vetores de atributos e centroides
    %i,k: i-ésima e k-ésima posições dos vetores de entrada
>>>>>>> 47ec1849ca476e6b005cd0062ab9d938f4fe0355:sigma.m
    
    ind =1;
    
    for j=1:p
        for i=1:n
            for k=1:n
                if (i ~= k)
                   array(ind) = (abs(x(i,j) - x(k,j)))^2;
                   ind = ind+1;
                end                
            end
        end
            ind =1;
        
        out(j) = (quantile(array,0.1) + quantile(array,0.9))/2.0; %valor do vetor sigma
        
    end
    
    
end
