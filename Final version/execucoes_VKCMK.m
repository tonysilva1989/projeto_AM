
function [melhorExecucao, particaoMelhorExecucao, lambdaMelhorExecucao, melhorJ] = execucoes_VKCMK(X, N, p, K, particaoClasses)

    melhorJ = Inf; 
    
    for i = 1 : 100
        
        [clusters, lambda, J] = VKCMK(X, K, N, p, i);  
        
        [indiceRandCorrigido, tabelaContingencia] = indice_rand_corrigido(particaoClasses, clusters, N, K);
        
        fprintf('\nIRC(%d) = %.12f', i, indiceRandCorrigido);  
        fprintf('\nTabela de Conting�ncia(%d):\n', i);
        fprintf(tabelaContingencia);   
        
        if(J < melhorJ)    
           melhorExecucao = i;
           particaoMelhorExecucao = clusters;
           lambdaMelhorExecucao = lambda;
           melhorJ = J;  
        end

    end
end
