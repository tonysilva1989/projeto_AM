function z = phi_2(x,v,lambda,p)
	%p: número de atributos ou variáveis
	%lambda está sujeito ao comprimento máximo p
	
	sum=0;
	for i = 1:p
		%euclidian distance measure
		sum = sum + lambda[i]*euclidian_dist(x(i),y(i));		
	end
		
end