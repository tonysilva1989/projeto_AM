
function [X, N, p, K, particaoClasses, classesPadroes] = ler_dados()

    fid = fopen('/home/phmb2/Área de Trabalho/Projeto_AM/abalone.data');

    file = textscan(fid, '%s%s%s%s%s%s%s%s%s', 'delimiter', ',');

    H = horzcat(file{:});

    A = H(:, 2:end);   
    
    N = size(A, 1);

    p = size(A, 2);

    X = convertToDouble(A, N, p);

    X = normalizar(X, p);

    labels = ['M', 'F', 'I'];

    K = length(labels);
   
    classes = H(:, 1);
    
    classes = cell2mat(classes);
    
    [particaoClasses, classesPadroes] = criarParticaoClasses(classes, N, K, labels);
end

function X = convertToDouble(A, N, p)
    X = zeros(N, p);
    
    for i = 1 : N 
        for j = 1 : p
            X(i, j) = str2double(A(i, j));
        end
    end
end

function X = normalizar(X, p)
    for j = 1 : p
        X(:, j) = (X(:, j) - min(X(:, j))) ./ (max(X(:, j) - min(X(:, j))));
    end
end

function [particaoClasses, classesPadroes] = criarParticaoClasses(classes, N, K, labels) 
    particaoClasses = cell(1, K);
    classesPadroes = zeros(1, N);
    
    for i = 1 : N
       classe = find(labels == classes(i));        
       particaoClasses{1, classe} = [particaoClasses{1, classe} i];	
       classesPadroes(i) = classe;  
    end
end
