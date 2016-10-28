function out = VKCM_K()
    %argumentos de entrada: 
        %conjunto de dados de entrada X = {x1,...xn}
        %n�mero de Clusters K=3
    
    %INICIALIZA��O:
    p=4; %tamanho p (n�mero de atributos)
    K=3; %defini��o de valores do n�mero de parti��es
    n=4177; %n�mero de objetos presentes na base de dados
    %%%%%%FALTA DEFINIR O VETOR X DE ENTRADAS
    
    %definindo os valores iniciais do vetor de pesos lambda
    lambda = ones([1,p]);
    v = ones([K,p]); %preenchendo o vetor de cluster centroids com 1 (precisa ser aleat�rio?)
    
    %Etapa de criação do vetor sigma
    
    sigma_array = sigma(x,v);
    
    while (test ~= 0) %enquanto a condi��o de para n�o for satisfeita
        
        %C�LCULO DOS CLUSTER CENTROIDS (Equa��o 12):
        for k=1:K
           for j=1:p
               v(k,j) = v_func(v(k,j),K,j,sigma_array);
           end  
        end

        %C�LCULO DOS PESOS DAS VARI�VEIS (Equa��o 16):

        %%se��o incompleta, precisa saber quem � o �ndice i a ser colocado na
        %%fun��o
        for j=1:p
            v_lambda(j) = lambda(P,v,j,K,sigma_array); 
        end


        %ATUALIZA��O DOS CLUSTERS
    
        test =0;

        val = ones([1,K]);

        for i=1:n

            for k=1:K
               val(k) = phi_2(x,v,i,k,lambda,p);
            end
                [dist ind] = min(val); %mostra o indice da menor dist�ncia encontrada

            h = ind; %h recebe o �ndice da menor dist�ncia

            %descobre se x_i exite em P_k
            existe = ismember(P(:,:,k),X(i,:),'rows');

            if (existe == 1) && (h ~= k)
               test=1;
               %%inserir x_i na h-�sima parti��o P

               %%remove x_i da k-�sima parti��o P

            end
        end
    end
    
    
    %dados de sa�da: cluster centroides v_k
    %                o conjunto de parti��es P
end
