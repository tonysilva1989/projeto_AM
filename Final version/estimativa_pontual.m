
function taxa_erro = estimativa_pontual(classes, clusters, N, K)
    
    taxa_erro = 0;
    
    for i = 1 : N    
        if (classe_elemento(classes, K, i) ~= classe_elemento(clusters, K, i))
            taxa_erro = taxa_erro + 1;
        end
    end
    
    taxa_erro = (taxa_erro / N);

end
