function K = gaussian_kernel(x,v)

	sigma = 1;
	K = exp(-((abs(v-x))^2)/2*sigma);
	
end