
function [clusters, lambda, J] = VKCMK(X, K, N, p, execucao)

	lambda = criarVetoresPesosVariaveis(K, p);
	
	clusters = criarParticaoInicialAleatoria(X, K, N);
    
	matrizKernel = calcularMatrizKernel(X, N, p);
    	
	test = 1;
	
    while(test ~= 0)            

        D = calcularDistanciaEuclidianaQuadratica(N, K, matrizKernel, clusters, p);
        
        lambda = atualizarVetoresPesosVariaveis(K, p, D, clusters, lambda);

        [clusters, test] = atualizarClusters(clusters, N, K, p, lambda, D);
        
        J = calcularValorFuncaoObjetivo(clusters, K, lambda, D, p);
        
        fprintf('\nJ(%d) = %.12f', execucao, J);  
    end
end
 
function lambda = criarVetoresPesosVariaveis(K, p)
    lambda = cell(1, K);
    for k = 1 : K
        lambda{k} = ones(1, p);
    end
end

function clusters = criarParticaoInicialAleatoria(X, K, N) 

    R = randperm(N);
    
    centroides = R(1, 1:K);
    
    clusters = cell(1, K);

    for i = 1 : N

       dMin = Inf;
       selecionado = 1;
       
       for k = 1 : K
          d = calcularDistanciaEuclidiana(X, i, centroides(k));
          
          if(d < dMin)
             dMin = d;
             selecionado = k;
          end             
       end
       
       clusters{1, selecionado} = [clusters{1, selecionado} i];	
    end
end

function valor = calcularDistanciaEuclidiana(X, i, l)
    dif = X(i, :) - X(l, :);
    
    valor = sqrt(sum(dif .^ 2));
end

function matrizKernel = calcularMatrizKernel(X, N, p)

    matrizKernel = cell(1, p);
        
    distancias = zeros(p, (N ^ 2 - N) / 2);

    a = 1;

    for i = 1 : N
        for l = (i + 1) : N
            distancias(:, a) = ((X(i, :) - X(l, :)) .^ 2)';
            a = a + 1;
        end
    end
    
    for j = 1 : p

        matrizKernel{j} = ones(N, N);
        
        min = quantile(distancias(j, :), 0.1);
        
        max = quantile(distancias(j, :), 0.9);

        sigma = (min + max) / 2;
        
        for i = 1 : N
            for l = (i + 1) : N
                matrizKernel{j}(i, l) = calcularFuncaoKernelVariavel(X, j, i, l, sigma);				
                matrizKernel{j}(l, i) = matrizKernel{j}(i, l);
            end
        end
    end
end

function valor = calcularFuncaoKernelVariavel(X, j, i, l, sigmaJ)
	valor = (X(i, j) - X(l, j)) ^ 2;   
        valor = exp((-1) * valor / sigmaJ);
end

function D = calcularDistanciaEuclidianaQuadratica(N, K, matrizKernel, clusters, p) 
    D = cell(1, p); 
     
    for j = 1 : p 
        D{j} = zeros(N, K); 
 
        for k = 1 : K 
            tamanhoParticao = size(clusters{1, k}, 2); 
             
            matrizTerceiraParcela = matrizKernel{j}(clusters{1, k}, clusters{1, k}); 
             
            terceiraParcela = sum(sum(matrizTerceiraParcela)); 
 
            matrizSegundaParcela = matrizKernel{j}(clusters{1, k}, :); 
             
            vetorSomaSegundaParcela = sum(matrizSegundaParcela); 
             
            for i = 1 : length(vetorSomaSegundaParcela) 
                D{j}(i, k) = matrizKernel{j}(i, i) - (2 * vetorSomaSegundaParcela(i) / tamanhoParticao) + (terceiraParcela / (tamanhoParticao ^ 2)); 
            end 
        end 
    end   
end

function lambda = atualizarVetoresPesosVariaveis(K, p, D, clusters, lambda)
  
    matrizSoma = zeros(p, K);
    
    for j = 1 : p
        for k = 1 : K	
            matriz = D{j}(clusters{1, k}, k);            
            matrizSoma(j, k) = sum(matriz);
        end
    end 
    
    produto = prod(matrizSoma, 1);
        
    for k = 1 : K
        for j = 1 : p
            lambda{k}(j) = (produto(k) ^ (1 / p)) / matrizSoma(j, k);
        end
    end 
end

function [clusters, test] = atualizarClusters(clusters, N, K, p, lambda, D)
	test = 0;
	
	for i = 1 : N
		h = calcularClusterMenorDistanciaAdaptativa(lambda, D, K, p, i);
		
		for k = 1 : K
			if (any(clusters{1, k} == i) && h ~= k)	
				test = 1;
				clusters{1, h} = [clusters{1, h} i];	 
				clusters{1, k}(clusters{1, k} == i) = [];
				break;
			end
		end
	end
end

function h = calcularClusterMenorDistanciaAdaptativa(lambda, D, K, p, i)
	h = 1;
	
	menorDistanciaAdaptativa = Inf;
	
	for k = 1 : K
		distanciaAdaptativa = calcularDistanciaAdaptativa(lambda, D, i, k, p);
		
		if(distanciaAdaptativa < menorDistanciaAdaptativa)
			h = k;
			menorDistanciaAdaptativa = distanciaAdaptativa;			
		end
	end
end

function distanciaAdaptativa = calcularDistanciaAdaptativa(lambda, D, i, k, p)
    distanciaAdaptativa = 0;
		
    for j = 1 : p
        distanciaAdaptativa = distanciaAdaptativa + lambda{k}(j) * D{j}(i, k); 
    end
end

function J = calcularValorFuncaoObjetivo(clusters, K, lambda, D, p)
    J = 0;
    
    for k = 1 : K
		tamanhoParticao = size(clusters{1, k}, 2);
        
        for i = 1 : tamanhoParticao
            indice = clusters{1, k}(i);            
            J = J + calcularDistanciaAdaptativa(lambda, D, indice, k, p);
        end
    end
end
