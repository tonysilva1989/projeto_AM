function K = gaussian_kernel(x,v,i)

	K = exp(-((abs(v-x))^2)/2*sigma_array(i));
	
end
