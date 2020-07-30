function coeffUsedError = Knn_Class_Build(totaldata, numCoeff, k, errorcalc)
% This function builds a KNN classifier with the user defined inputs:
% numCoeff = the number of coefficients allowed to use, k = the k value to
% use, totaldata = the training data set, errorcalc = 1 or 2 1 = average 
% error, 2 = 3 prioritised error. 

%split data into classification 
typeoferrorcalc = errorcalc;
numData = size(totaldata, 2);
numData2 = size(totaldata, 1);
data = cell(1,numData);

%count number of each class
classifier = zeros(numData,1);
num1Class = 0;
num2Class = 0;
num3Class = 0;
for i = 1:numData
    classifier(i,1) = totaldata{2,i};
    if(classifier(i,1) == 1)
        num1Class = num1Class + 1;
    elseif(classifier(i,1) == 2)
        num2Class = num2Class + 1;
    else
        num3Class = num3Class + 1;
    end
    if(numData2 < 3)
        data{i} = totaldata{1,i};
    end
end

%Calculate coefficients for all the data
ClassifierData = zeros(numData, numCoeff);
for i = 1:numData
    if(numData2 < 3)
        coeff = SolverLinearSquare(data{i});
    else
        coeff = totaldata{3, i};
    end
    ClassifierData(i,1:numCoeff) = coeff(1:numCoeff);
end

%create the powerset array
A = 1:numCoeff;
n = length(A);
int=1-n:1:0;
N=2^n-1;
pws=cell(1,N);
S=1:N;
ind=rem(floor(S(:)*pow2(int)),2)==1;
for p=1:N, pws{p} = A(ind(p,:));end
powerset = pws;

%Create a cell that will hold the error rate for every set of coefficients
%in the powerset.
X = [];
minVals = cell(2,1);

%Work out the required coeffiient to keep, try for every combination within
%the power set.
numPowerSetData = size(powerset,2);
for i = 1:numPowerSetData
    p = powerset{i};
    
    %grab the information requried from each data set
    for j = 1:numData
        a = ClassifierData(j,:);
        b = a(p);
        X(j,1:length(b)) = b;
    end
    x = X;
    
    num1MissC = 0;
    num2MissC = 0;
    num3MissC = 0;
    for l = 1:numData
        distances = [numData, 2];
        for j = 1:numData
            if (j == l)
                distances(j,1) = NaN;
                distances(j,2) = j;
            else
                distances(j,1) = (x(l,:) - x(j,:))*(x(l,:) - x(j,:))';
                distances(j,2) = j;
            end
        end
        
        %Calculate the closest neighbours
        imageClass = zeros(k,1);
        for j = 1:k
            [a,pos] = min(distances(:,1));
            val = distances(pos,2);
            distances(pos,:) = [];
            imageClass(j,1) = classifier(val,1);
        end        
        clasification = mode(imageClass);
        if(clasification ~= classifier(l,1))
            if(classifier(l,1) == 1)
                num1MissC = num1MissC + 1;
            elseif(classifier(l,1) == 2)
                num2MissC = num2MissC + 1;
            else
                num3MissC = num3MissC + 1;
            end
        end
    end
    error = 0;
    % This is where the difference occurs, the value of the number of class
    % 3 correctly classified is more highly weighted.
    if(num1Class == 0)
        if(typeoferrorcalc == 1)
            error = ((num2MissC/num2Class) + (num3MissC/num3Class)) / 2;
        elseif(typeoferrorcalc == 2)
            error = ((num2MissC/num2Class) + 3*(num3MissC/num3Class)) / 4;
        end
    elseif(num2Class == 0)
        if(typeoferrorcalc == 1)
            error = ((num1MissC/num1Class) + (num3MissC/num3Class)) / 2;
        elseif(typeoferrorcalc == 2)
            error = ((num1MissC/num1Class) + 3*(num3MissC/num3Class)) / 4;
        end        
    elseif(num3Class == 0)
        error = ((num1MissC/num1Class) + (num2MissC/num2Class)) / 2;
    else
        if(typeoferrorcalc == 2)
            error = ((num1MissC/num1Class) + (num2MissC/num2Class) + 3*(num3MissC/num3Class)) / 5;
        elseif(typeoferrorcalc == 1)
            error = ((num1MissC/num1Class) + (num2MissC/num2Class) + (num3MissC/num3Class)) / 3;
        end
    end
    
    if(minVals{2,1} ~= 0)
        if(error < minVals{2,1})
            minVals{1,1} = powerset{i};
            minVals{2,1} = error;
        end
    else
        minVals{1,1} = powerset{i};
        minVals{2,1} = error;
    end
    X = [];
end

%Identify optimal coefficients
coeffUsed = minVals{1,1};
error = minVals{2,1};
coeffUsedError = [coeffUsed, error];

%pull optimal coefficients from the data set and design the data set that
%will hold all the information requried for the classifier to classify a
%future image
Classifier_Data = zeros(numData + 1, length(coeffUsed) + 1);
Classifier_Data(1,1:length(coeffUsed)) = coeffUsed;
Classifier_Data(1, length(coeffUsed) + 1) = k;
Classifier_Data(2:numData+1,  length(coeffUsed) + 1) = classifier;
for i = 2:(numData + 1)
   a = ClassifierData(i-1,:);
   Classifier_Data(i,1:length(coeffUsed)) = a(coeffUsed);
end

%Save the data
save KNN_Classifier_Data Classifier_Data
end