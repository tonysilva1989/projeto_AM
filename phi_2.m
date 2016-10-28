function z = phi_2(x,v,i,k,p)
	%p: número de atributos ou variáveis
	%lambda está sujeito ao comprimento máximo p
	%i,k : i-�simos e k-�simos objetos 
    
	sum=0;
	for j = 1:p
		%euclidian distance measure
		sum = sum + lambda(j)*distance(x(i,j),v(k,j),p,@gaussian_kernel);		
    end
    
		z = sum;
end
