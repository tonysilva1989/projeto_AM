function v_kj = v_func(x,v,P,n,j,@gaussian_kernel)

	%n: tamanho do vetor x de atributos
	%P(i): x_i-ésimo objeto (vetor de atributos) no vetor de Partições
    %v: é assumido que se está recebendo o kj-ésimo vetor
    
	lenght_P = size(P); %tamanho do vetor de partções escolhido
	soma = 0;
    soma_denom = 0;
    
	for i=1:lenght_P
		soma = soma + gaussian_kernel(P(i,j),v)*P(i,j); %passa o x_ij elemento do vetor x_i do k-ésimo vetor de partição P
        soma_denom = soma_denom + gaussian_kernel(P(i,j),v);
    end
    
    v_kj = soma/soma_denom;
    
end