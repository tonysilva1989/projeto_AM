function K = gaussian_kernel(x,v,sigma)

	K = exp(-((abs(v-x))^2)/2*sigma);
	
end