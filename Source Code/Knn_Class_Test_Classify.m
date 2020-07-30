function EvaluationMatrix = Knn_Class_Test_Classify(data)
% This function tests the KNN that has been created. It checks first that 
% one is available to test and then calculates the test error upon it. 
% It uses the model to classify every image within the data and produces an
% 'Evaluation Matrix' to show the results. It is of the form:
%
% Evaluations Matrix: 
% |   | 1 | 2 | 3 |
% | 1 | x | x | x |
% | 2 | x | x | x |
% | 3 | x | x | x |
% |NumMissClassified | Error |
%
% Where the top row represents the actual class of an image, the columns
% value represents the class the KNN model allocated it and each x is the
% number of images classified at that position.  Thee number of
% missclassified results and the testing error is also inclued on the final
% row.

%Set up evaluation matrix, result table is as below
EvaluationMatrix = zeros(4);
EvaluationMatrix(1,1) = NaN;
EvaluationMatrix(1,2:4) = [1,2,3];
EvaluationMatrix(2:4,1) = [1,2,3]';
numMisClassified = 0;

%classify each data point.
numData = size(data, 2);
for i = 1:numData
    class = Knn_Class_Classify(data{1,i});
    EvaluationMatrix(1+class, 1+data{2,i}) =  EvaluationMatrix(1+class, 1+data{2,i}) + 1;
    if (class ~= data{2,i})
        numMisClassified = numMisClassified + 1;
    end
end
EvaluationMatrix(5,1) = numMisClassified;
EvaluationMatrix(5,2) = numMisClassified / numData;

end