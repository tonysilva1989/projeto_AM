
function [particao, erros] = ClassificadorRegraVotoMajoritario(N, K, classesPadroes, particaoMaximaVerossimilhanca, particaoMLP, particaoSVM, numeroFoldes, foldes)
    particao = cell(1, K);
    
    erros = zeros(1, numeroFoldes);
        
    for f = 1 : numeroFoldes
        teste = foldes{f};
        
        tamanhoTeste = length(teste);
        
        erroClassificacao = 0;
        
        for t = 1 : tamanhoTeste
            indiceTeste = teste(t);

            classeMV = classe_elemento(particaoMaximaVerossimilhanca, K, indiceTeste);
            classeMLP = classe_elemento(particaoMLP, K, indiceTeste);
            classeSVM = classe_elemento(particaoSVM, K, indiceTeste);

            if (classeMV == classeMLP || classeMV == classeSVM)
                classe = classeMV;
            elseif (classeMLP == classeSVM)
                classe = classeMLP;
            else
                classe = classeSVM;
            end
            
            particao{1, classe} = [particao{1, classe} indiceTeste];
            
            if (classesPadroes(indiceTeste) ~= classe)
                erroClassificacao = erroClassificacao + 1;
            end
        end
        
        erros(f) = erroClassificacao / tamanhoTeste;
    end
end