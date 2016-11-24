
function [particao] = SVM()

abalone = importdata ('abalone.data',',');
X = abalone.data; %matriz de atributos
Y = abalone.textdata; %array de rotulos


t = templateSVM('Standardize',1,'KernelFunction','gaussian');

Mdl = fitcecoc(X,Y,'Learners',t,'FitPosterior',1,'ClassNames',{'M','F','I'},'Verbose',2);

CVMdl = crossval(Mdl);

oosLoss = kfoldLoss(CVMdl);

[label,~,~,Posterior] = resubPredict(Mdl,'Verbose',1);
Mdl.BinaryLoss

idx = randsample(size(X,1),10,1);

count=0;
N=4177;
K=3;

particao = cell(1,K);

real = zeros(1,N);
predict = zeros(1,N);

for k = 1:N
   if (strcmp(Y(k),label(k)) == 1)
       count=count+1;
   end
   
   if (ismember(Y(k),'M'))
       real(k) = 1;
   elseif(ismember(Y(k),'F'))
       real(k)=2;
   elseif(ismember(Y(k),'I'))
       real(k)=3;
   end
   
   if(ismember(label(k),'M'))
       predict(k) = 1;
       particao{1} = [particao{1} k];

   elseif(ismember(label(k),'F'))
       predict(k)=2;
       particao{2} = [particao{2} k];
   elseif(ismember(label(k),'I'))
       predict(k)=3;
       particao{3} = [particao{3} k];
   end
end  
       
prec= count/N;

nbMVResubErr = 1-prec;

confusion(real,predict)

%Mdl.ClassNames
%table(Y(idx),label(idx),Posterior(idx,:),'VariableNames',{'True','Predict','Posterior'})
end