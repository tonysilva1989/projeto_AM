
abalone = importdata ('abalone.data',',');

x = abalone.data;
y = abalone.textdata;

SVMStruct = svmtrain(x,y); 
