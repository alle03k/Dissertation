function net = SoftMaxLayer_Neural_Network(trainData, testData, maxEpochs, lossfunction, numCoeff)
%manage the data into the correct format
numTrain = size(trainData, 2);
numTest = size(testData, 2);
class = zeros(1,numTest);
for i = 1:numTest
    a = testData{2,i};
    class(1,i) = a;
end
c = unique(class);
numClass = size(c,2);
trainDataVal = zeros(numCoeff,numTrain);
trainDataClass = zeros(numClass,numTrain);
testDataVal = zeros(numCoeff,numTest);
testDataClass = zeros(numClass, numTest);

for i = 1:numTrain
    if(i < (numTest + 1))
        a = testData{3,i};
        testDataVal(1:numCoeff,i) = a(1:numCoeff)';
        a = testData{2,i};
        testDataClass(a,i) = 1;
    end
    a = trainData{3,i};
    trainDataVal(1:numCoeff,i) = a(1:numCoeff)';
    a = trainData{2,i};
    trainDataClass(a,i) = 1;
end
if(lossfunction == 1)
    loss = 'crossentropy';
else
    loss = 'mse';
end

%train and the test the nerual net using the data that is sorted above.
net = trainSoftmaxLayer(trainDataVal,trainDataClass, 'LossFunction', loss, 'MaxEpochs', maxEpochs, 'ShowProgressWindow', false);
result = net(testDataVal);
plotconfusion(testDataClass, result);
end