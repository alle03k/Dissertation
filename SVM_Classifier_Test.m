function [EvaluationMatrix] = SVM_Classifier_Test(data)
% This function tests a created SVM classifier using the saved classifier
% object and the user inputted test 'data'.  It uses the model to classify
% every image within the data and produces an 'Evaluation Matrix' to show
% the results. It is of the form:
%
% Evaluations Matrix: 
% |   | 1 | 2 | 3 |
% | 1 | x | x | x |
% | 2 | x | x | x |
% | 3 | x | x | x |
% |NumMissClassified | Error |
%
% Where the top row represents the actual class of an image, the columns
% value represents the class the SVM model allocated it and each x is the
% number of images classified at that position.  Thee number of
% missclassified results and the testing error is also inclued on the final
% row.

%Set up evaluation matrix for result information
EvaluationMatrix = zeros(4);
EvaluationMatrix(1,1) = NaN;
EvaluationMatrix(1,2:4) = [1,2,3];
EvaluationMatrix(2:4,1) = [1,2,3]';
numMisClassified = 0;
load SVM_Classifier_Data;

% set up other testing data requirements
numData = size(data, 2);
numCoeff = size(bestSetCoeffs,2);
quantData = zeros(numData, numCoeff);
dataClasses = zeros(numData, 1);

% Calculate qunatifications of all images.
for i = 1:numData
    if(data{3,i} ~= 0)
        a = data{3,i};
    else
        [a,dist] = Coefficient_Solver(data{1,i});
    end
    quantData(i,1:numCoeff) = a(bestSetCoeffs,1)';
    a = data{2,i};
    dataClasses(i,1) = a;
end

% Classify all images using their quantifications
[a,b] = predict(bestSVM, quantData);
numMissClassified = 0;
for i = 1:numData
    c = a{i,1};
    c = str2num(c);
    % Increments the x's in the evaluation matrix depending on the correct
    % class and the class it was given by the model.
    EvaluationMatrix(1+c, 1+dataClasses(i,1)) =  EvaluationMatrix(1+c, 1+dataClasses(i,1)) + 1;
    if(c ~= dataClasses(i,1))
        numMissClassified = numMissClassified + 1;
    end
end

%finish of filling evaluation matrix by calculating testing error
error = numMissClassified / numData;
EvaluationMatrix(5,1) = numMisClassified;
EvaluationMatrix(5,2) = error;
end