
function [particao, erros] = EstimacaoMaximaVerossimilhanca(X, N, p, K, classesPadroes, priori, numeroFoldes, foldes) 
    densidade = zeros(N, K);
    
    classes = 1 : K;
    
    estimacao = zeros(N, K);
    
    erros = zeros(1, numeroFoldes);
    
    particao = cell(1, K);
        
    for f = 1 : numeroFoldes
        teste = foldes{f};

        if(f == 1)
            treinamento = horzcat(foldes{f + 1 : numeroFoldes});
        elseif(f == numeroFoldes)
            treinamento = horzcat(foldes{1 : f - 1});
        else
            treinamento = [foldes{1 : f - 1} foldes{f + 1 : numeroFoldes}];
        end
    
        tamanhoTeste = length(teste);

        for k = 1 : K  
            indices = (classesPadroes(treinamento) == classes(k));

            treinamentoClasse = treinamento(indices);

            media = mean(X(treinamentoClasse, :));

            sigma = cov(X(treinamentoClasse, :));

            for t = 1 : tamanhoTeste
                indiceTeste = teste(t);
                
                densidade(indiceTeste, k) = normalMultivariada(media, sigma, X, p, indiceTeste);               
            end
        end
        
        erroClassificacao = 0;
        
        for t = 1 : tamanhoTeste
            indiceTeste = teste(t);
            
            estimacao(indiceTeste, :) = ProbabilidadePosteriori(indiceTeste, K, priori, densidade);
                    
            [~, classe] = max(estimacao(indiceTeste, :));
            
            particao{1, classe} = [particao{1, classe} indiceTeste];
            
            if (classesPadroes(indiceTeste) ~= classe)
                erroClassificacao = erroClassificacao + 1;
            end
        end
        
        erros(f) = erroClassificacao / tamanhoTeste;
    end
end

function valor = normalMultivariada(media, sigma, X, p, indiceTeste)  
    a = (2 * pi) ^ -(p / 2) * det(sigma) ^ -0.5;                
    padrao = X(indiceTeste, :);                
    Y = padrao - media;                
    b = exp(-0.5 * Y / sigma * Y.');            
    valor = a * b;  
end
