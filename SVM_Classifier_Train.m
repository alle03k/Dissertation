function results = SVM_Classifier_Train(numCoeff, data)
% this function creates the SVM classifier.  There are two user defined
% inputs which are: numCoeff = the number of coefficients of the 
% quantification the classifier has access to; data: the training data set.
% The output is results which is a pair of values: the best error gained,
% and the coefficients that produced that error.

% Set up training requirements
coeffs = 1:numCoeff;
bestSetCoeffs = 0;
bestError = 1;
bestSVM = 0;
VectorCoeff = zeros(size(data, 2),105);
class = zeros(size(data, 2), 1);

% Calculate quantifications of all images in training set
for i = 1 : size(data, 2)
   if(data{3,i} ~= 0)
       a = data{3,i};
   else
       [a, dist] = Coefficient_Solver(data{1,i},1);
   end
   VectorCoeff(i,:) = a;
   a = data{2,i};
   class(i,1) = a;
end
c = unique(class');
c = int2str(c);
d = cell(1,2);
d{1,1} = c(1);
d{1,2} = c(4);

trainD = VectorCoeff(:,coeffs);
testD = trainD;
% train the model
SVMModel = fitcsvm(trainD, class,'Standardize',true,'ClassNames',d);
% calculate training error
[a,b] = predict(SVMModel, testD);
numMissClassified = 0;
for i = 1:size(data, 2)
    c = a{i,1};
    c = str2num(c);
    if(c ~= class(i,1))
        numMissClassified = numMissClassified + 1;
    end
end
% Save relevant information
error = numMissClassified / size(data, 2);
bestSVM = SVMModel;
bestSetCoeffs = coeffs;
bestError = error;
% return the results and save the optimal SVM model created as a matlab
% object so that it can be accessed by another function.
results = [bestError];
save SVM_Classifier_Data bestSVM bestSetCoeffs;