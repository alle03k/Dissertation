% Classifier tool
net = patternnet(1, 'performFcn', 'mse');
net.divideFcn = 'divideind';
net.divideParam.trainInd = trainin;
net.divideParam.valInd = valin;
net.divideParam.testInd = testin;
[net,tr] = train(net, NeuralDataValues, NeuralDataClass);

% Use this to combinew all the data into one data set
% for i = 1:36
%     neuralTrainData1v2v3Values(1:105,70+i) = neuralTestData1v2v3Values(1:105,i);
%     neuralTrainData1v2v3Class(1:3,70+i) = neuralTestData1v2v3Class(1:3,i);
% end

