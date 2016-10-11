function out = VKCM_K()
    %argumentos de entrada: 
        %conjunto de dados de entrada X = {x1,...xn}
        %número de Clusters K=3
    
    %INICIALIZAÇÃO:
    p=4; %tamanho p (número de atributos)
    K=3; %definição de valores do número de partições
    n=4177; %número de objetos presentes na base de dados
    %%%%%%FALTA DEFINIR O VETOR X DE ENTRADAS
    
    %definindo os valores iniciais do vetor de pesos lambda
    lambda = ones([1,p]);
    v = ones([K,p]); %preenchendo o vetor de cluster centroids com 1 (precisa ser aleatório?)
    
    %CÁLCULO DOS CLUSTER CENTROIDS (Equação 12):
    while (test ~= 0) %enquanto a condição de para não for satisfeita
        for k=1:K
           for j=1:p
               v(k,j) = v_func(v(k,j),K,j);
           end 
        end

        %CÁLCULO DOS PESOS DAS VARIÁVEIS (Equação 16):

        %%seção incompleta, precisa saber quem é o índice i a ser colocado na
        %%função
        for i=1:p
            v_lambda(i) = lambda(); %%???????????????????
        end


        %ATUALIZAÇÃO DOS CLUSTERS
    
        test =0;

        val = ones([1,K]);

        for i=1:n

            for k=1:K
               val(k) = phi_2(x,v,i,k,lambda,p);
            end
                [dist ind] = min(val); %mostra o indice da menor distância encontrada

            h = ind; %h recebe o índice da menor distância

            %descobre se x_i exite em P_k
            existe = ismember(P(:,:,k),X(i,:),'rows');

            if (existe == 1) && (h ~= k)
               test=1;
               %%inserir x_i na h-ésima partição P

               %%remove x_i da k-ésima partição P

            end
        end
    end
    
    
end