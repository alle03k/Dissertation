function Class = Knn_Class_Classify(Image)
% This function takes in an image and using a allready defined KNN
% classifier allocates that image to a class.  The class is returned as a
% result.

%Check if there is a trained KNN by trying to load the data
try
    load('C:\Users\piers\Documents\MATLAB\Summer Work\KNN_Classifier_Data.mat');
    %find coefficient of image
    coeff = Coefficient_Solver(Image,1);
    
    %gather required coefficients
    numCoeff = size(Classifier_Data, 2) - 1;
    reqCoeff = zeros(1,numCoeff);
    for i = 1:numCoeff
        num = Classifier_Data(1,i);
        reqCoeff(i) = coeff(num);
    end
    
    %Calculate all distances
    length = size(Classifier_Data, 1) - 1;
    distances = zeros(length, 2);
    for j = 1:length
        distances(j,1) = (reqCoeff - Classifier_Data(j+1,1:numCoeff))*(reqCoeff - Classifier_Data(j+1,1:numCoeff))';
        distances(j,2) = j;
    end
    
    %load k and classification values from the knn classifier data
    k = Classifier_Data(1, numCoeff + 1);
    y = Classifier_Data(2:length + 1, numCoeff + 1);
    Imageclass = zeros(k,1);
    
    %work out the classification
    for j = 1:k
        [a,pos] = min(distances(:,1));
        Imageclass(j,1) = y(pos);
        distances(pos,:) = [];
    end
    Class = mode(Imageclass);
catch
    %no KNN classifier dat so display error
    disp 'No data to classify object';
    Class = 0;
end

end