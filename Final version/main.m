
function main()

    [X, N, p, K, particaoClasses, classesPadroes] = ler_dados();    
    
    [melhorExecucao, particaoMelhorExecucao, lambdaMelhorExecucao, melhorJ] = execucoes_VKCMK(X, N, p, K, particaoClasses);
    
    fprintf('\nMelhor Execução = %d', melhorExecucao);  
    fprintf('\nMelhor J = %.12f\n\n', melhorJ);  
    
    for i = 1 : K
        fprintf('Cluster %d\n', i);
        disp(particaoMelhorExecucao{i}); 
    end
    
    for i = 1 : K
       fprintf('Vetor de Pesos %d\n', i);
       disp(lambdaMelhorExecucao{i}); 
    end
    
    [indiceRandCorrigido, tabelaContingencia] = indice_rand_corrigido(particaoClasses, particaoMelhorExecucao, N, K);
    
    fprintf('\nIRC = %.12f\n', indiceRandCorrigido);  
    fprintf('\nTabela de Conting�ncia:\n');
    fprintf(tabelaContingencia); 

    priori = ProbabilidadePriori(N, K, particaoClasses);

    numeroFoldes = 10;
            
    fold = foldes(particaoClasses, numeroFoldes);

    [particaoMaximaVerossimilhanca, errosMaximaVerossimilhanca] = EstimacaoMaximaVerossimilhanca(X, N, p, K, classesPadroes, priori, numeroFoldes, fold);
    
    estimativaPontualMaximaVerossimilhanca = estimativa_pontual(particaoClasses, particaoMaximaVerossimilhanca, N, K);
    
    [minML, maxML] = intervalo_confianca(estimativaPontualMaximaVerossimilhanca, N);
    
    imprimirResultados(particaoClasses, particaoMaximaVerossimilhanca, estimativaPontualMaximaVerossimilhanca, minML, maxML, N, K);
    
    [particaoMLP, errosMLP] = MLP(X, K, classesPadroes, numeroFoldes, fold);
    
    estimativaPontualMLP = estimativa_pontual(particaoClasses, particaoMLP, N, K);
 
    [minMLP, maxMLP] = intervalo_confianca(estimativaPontualMLP, N);

    imprimirResultados(particaoClasses, particaoMLP, estimativaPontualMLP, minMLP, maxMLP, N, K);
    
    errosSVM = [0.462829736211036 0.452153110047852 0.440191387559813 0.447368421052636 0.435406698564598 0.444976076555029 0.449760765550244 0.444976076555029 0.417266187050364 0.410071942446047];            
    csv = csvread('SVM_predict_new.csv');
    
    particaoSVM = cell(1, K);
    
    for i = 1:N
        classe = find(csv(i, :) == 1);
        particaoSVM{classe} = [particaoSVM{classe} i];
    end
    
    estimativaPontualSVM = estimativa_pontual(particaoClasses, particaoSVM, N, K);
 
    [minSVM, maxSVM] = intervalo_confianca(estimativaPontualSVM, N);

    imprimirResultados(particaoClasses, particaoSVM, estimativaPontualSVM, minSVM, maxSVM, N, K);
  
    [particaoRegraVotoMajoritario, errosRegraVotoMajoritario] = ClassificadorRegraVotoMajoritario(N, K, classesPadroes, particaoMaximaVerossimilhanca, particaoMLP, particaoSVM, numeroFoldes, fold);

    estimativaPontualRegraVotoMajoritario = estimativa_pontual(particaoClasses, particaoRegraVotoMajoritario, N, K);

    [minRegraVotoMajoritario, maxRegraVotoMajoritario] = intervalo_confianca(estimativaPontualRegraVotoMajoritario, N);

    imprimirResultados(particaoClasses, particaoRegraVotoMajoritario, estimativaPontualRegraVotoMajoritario, minRegraVotoMajoritario, maxRegraVotoMajoritario, N, K);
    
    %Friedman e Nemenyi Testes
    matrizErros = vertcat(errosMaximaVerossimilhanca, errosMLP, errosSVM, errosRegraVotoMajoritario);
    
    matrizErros = matrizErros';
    
    friedman_nemenyi(matrizErros, 'MaximaVerossimilhança MLP SVM VotoMajoritário');
  
end

function imprimirResultados(particaoClasses, particaoClusters, estimativaPontual, min, max, N, K)
    [indiceRandCorrigido, tabelaContingencia] = indice_rand_corrigido(particaoClasses, particaoClusters, N, K);
    
    fprintf('\nIRC = %.12f\n', indiceRandCorrigido);  
    fprintf('\nTabela de Conting�ncia:\n');
    fprintf(tabelaContingencia);  
    fprintf('Estimativa Pontual (Taxa de Erro) = %4f\n', estimativaPontual);  
    fprintf('IC(95 por cento) = (%4f, %4f)\n', min, max);  
end
