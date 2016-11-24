
function priori = ProbabilidadePriori(N, K, particaoClasses)
    priori = zeros(1, K);
    
    for j = 1 : K
        priori(j) = length(particaoClasses{1, j}) / N;
    end
end