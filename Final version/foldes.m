
function foldes = foldes(particaoClasses, numeroFoldes)
    
    K = length(particaoClasses);

    foldes = cell(1, numeroFoldes);

    for k = 1 : K
       vetor = particaoClasses{k};
       
       tamanhoClasse = length(vetor);

       tamanho = ceil(tamanhoClasse / 10); 

       tamanho2 = tamanho - 1;

       resto = mod(tamanhoClasse, 10); 

       indice = 1;

       for f = 1 : numeroFoldes
          if(f > resto && resto > 0)
            tamanho = tamanho2;
          end

          foldes{f} = [foldes{f} vetor(indice : indice + tamanho - 1)];       
          indice = indice + tamanho;
       end
    end
    
    for f = 1 : numeroFoldes
      tamanho = length(foldes{f});
      foldes{f} = foldes{f}(randperm(tamanho)); 
    end
end
