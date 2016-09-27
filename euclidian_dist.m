function z = euclidian_dist(x,y,n)
	%x e y: vetores de entrada.
	%n tamanho (dimensão) do vetor de entrada; se n=1, é apenas uma distância entre elementos unitários (não há vetores)
	
	sum=0;
	%Somatório da equação
	for i=1:n
		sum = sum + (y(i) - x(i))^2;
	end
	
	z = sqrt(sum);
	
end