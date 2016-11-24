function [melhorParticao, melhoresErros] = MLP(X, K, classesPadroes, numeroFoldes, foldes)

    taxaAprendizagem = [0.001 0.05 0.1 0.5 0.8];
        
    numeroNeuronios = [3 6 8 12 20];
   
    menorErroMedio = Inf;
    
    for u = 1 : length(taxaAprendizagem)    
        for n = 1 : length(numeroNeuronios)    
            [particao, erros] = calcularMLP(X, K, classesPadroes, numeroFoldes, foldes, taxaAprendizagem(u), numeroNeuronios(n));

            erroMedio = mean(erros);

            if(erroMedio < menorErroMedio)
                menorErroMedio = erroMedio;
                melhorTaxaAprendizagem = taxaAprendizagem(u);
                melhorNumeroNeuronios = numeroNeuronios(n);
                melhorParticao = particao;
                melhoresErros = erros;
            end
        end
    end
    
    fprintf('Melhor Taxa de Aprendizagem: %f\n', melhorTaxaAprendizagem);
    fprintf('Melhor N�mero de Neur�nios: %d\n', melhorNumeroNeuronios);
end

function [mlp, erros] = calcularMLP(X, K, classesPadroes, numeroFoldes, foldes, taxaAprendizagem, numeroNeuronios)
   
    erros = zeros(1, numeroFoldes);
    
    mlp = cell(1, K);
    
    for f = 1 : numeroFoldes
        teste = foldes{f};

        if(f == 1)
            treinamento = horzcat(foldes{f + 1 : numeroFoldes});
        elseif(f == numeroFoldes)
            treinamento = horzcat(foldes{1 : f - 1});
        else
            treinamento = [foldes{1 : f - 1} foldes{f + 1 : numeroFoldes}];
        end
        
        padroesTreinamento = X(treinamento, :);
        
        classesTreinamento = transformacao(classesPadroes(treinamento));
                
        padroesTeste = X(teste, :);

        saida = treinarRede(taxaAprendizagem, numeroNeuronios, padroesTreinamento', classesTreinamento', padroesTeste');
        
        tamanhoTeste = length(teste);
        
        erroClassificacao = 0;
                
        for i = 1 : tamanhoTeste
            indiceTeste = teste(i);
            
            classe = saida(1, i);
            
            mlp{classe} = [mlp{classe} indiceTeste];
            
            if (classesPadroes(indiceTeste) ~= classe)
                erroClassificacao = erroClassificacao + 1;
            end
        end
        
        erros(f) = erroClassificacao / tamanhoTeste;
    end
end
    
function saida = treinarRede(taxaAprendizagem, numeroNeuronios, padroesTreinamento, classesTreinamento, padroesTeste)
    net = patternnet(numeroNeuronios);
    net.trainParam.lr = taxaAprendizagem;
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio = 1.0;
    net.divideParam.valRatio = 0.0;
    net.divideParam.testRatio = 0.0;
    net = train(net, padroesTreinamento, classesTreinamento);
    saida = net(padroesTeste);
    saida = vec2ind(saida);
end
    
function dados = transformacao(labels)
    dados = zeros(length(labels), 3);
    
    for i = 1 : length(dados)
        switch labels(i)
            
        case 1
            dados(i, :) = [1 0 0] ; %M
        case 2
            dados(i, :) = [0 1 0];  %F
        case 3
            dados(i, :) = [0 0 1];  %I
        end
    end
end

