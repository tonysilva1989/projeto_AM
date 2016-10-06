function v_kj = v_func(x,v,P,n,j,@gaussian_kernel)

	%n: tamanho do vetor x de atributos
	%P(i): x_i-�simo objeto (vetor de atributos) no vetor de Parti��es
    %v: � assumido que se est� recebendo o kj-�simo vetor
    
	lenght_P = size(P); %tamanho do vetor de part��es escolhido
	soma = 0;
    soma_denom = 0;
    
	for i=1:lenght_P
		soma = soma + gaussian_kernel(P(i,j),v)*P(i,j); %passa o x_ij elemento do vetor x_i do k-�simo vetor de parti��o P
        soma_denom = soma_denom + gaussian_kernel(P(i,j),v);
    end
    
    v_kj = soma/soma_denom;
    
end