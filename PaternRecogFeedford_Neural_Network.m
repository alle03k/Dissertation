function [net, error] = PaternRecogFeedford_Neural_Network(data, numCoeff, lossfunction, networkTopog)
%Sort out data
dataSize = size(data, 2);
r = randperm(dataSize);
class = zeros(1,dataSize);
for i = 1:dataSize
    a = data{2,i};
    class(1,i) = a;
end
NeuralDataValues = zeros(numCoeff, dataSize);
NeuralDataClass = zeros(3, dataSize);
for i = 1:dataSize
    a = data{3,i};
    NeuralDataValues(1:numCoeff,i) = a(1:numCoeff)';
    a = data{2,i};
    NeuralDataClass(a,i) = 1;
end
if(lossfunction == 1)
    loss = 'crossentropy';
else
    loss = 'mse';
end

% Splitt data in to the correct sets
data1 = NeuralDataValues(1:numCoeff,r(1:floor(dataSize*7/10)));
class1 = NeuralDataClass(1:3,r(1:floor(dataSize*7/10)));
trainin = 1:floor(dataSize*7/10);
data2 = NeuralDataValues(1:numCoeff,r((floor(dataSize*7/10)+1):floor(dataSize*85/100)));
class2 = NeuralDataClass(1:3,r((floor(dataSize*7/10)+1):floor(dataSize*85/100)));
valin = floor((dataSize*7/10)+1):floor(dataSize*85/100);
data3 = NeuralDataValues(1:numCoeff,r((floor(dataSize*85/100)+1):dataSize));
class3 = NeuralDataClass(1:3,r((floor(dataSize*85/100)+1):dataSize));
testin = (floor(dataSize*85/100)+1):dataSize;
data4 = [data1,data2,data3];
class4 = [class1,class2,class3];

%set up network
net = patternnet(networkTopog, 'performFcn', loss);
net.divideFcn = 'divideind';
net.divideParam.trainInd = trainin;
net.divideParam.valInd = valin;
net.divideParam.testInd = testin;

%train and test network
[net,tr] = train(net, data4, class4);
y = net(data3);
numMissClass = 0;
for i = 1:size(class3,2)
    high = 0;
    num = 0;
    currclass = 0;
    for j = 1:size(class3,1)
       if(y(j,i) > high)
           num = j;
           high = y(j,i);
       end
       if(class3(j,i) == 1)
           currclass = j;
       end
    end
    if(currclass ~= num)
        numMissClass = numMissClass + 1;
    end
end
error = numMissClass / size(class3,2);
plotconfusion(class3,y);