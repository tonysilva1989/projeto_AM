
function k = classe_elemento(particao, K, elemento)
    for k = 1 : K
        if (any(particao{1, k} == elemento))
            break;
        end
    end    
end