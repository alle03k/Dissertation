function [bestNet, bestCoeff, bestError] = NeuralPowersetCalc(data, numCoeff, lossfunction, networkTopog)
%Sort out data
dataSize = size(data, 2);
r = randperm(dataSize);
class = zeros(1,dataSize);
for j = 1:dataSize
    a = data{2,j};
    class(1,j) = a;
end
NeuralDataValues = zeros(numCoeff, dataSize);
NeuralDataClass = zeros(3, dataSize);
for j = 1:dataSize
    a = data{3,j};
    NeuralDataValues(1:numCoeff,j) = a(1:numCoeff)';
    a = data{2,j};
    NeuralDataClass(a,j) = 1;
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
class4 = [class1,class2,class3];

%Calc the powerset
A = 1:15;
n = length(A);
int=1-n:1:0;
N=2^n-1;
pws=cell(1,N);
S=1:N;
ind=rem(floor(S(:)*pow2(int)),2)==1;
for p=1:N, pws{p} = A(ind(p,:));end
powerset = pws;
numPowerSetData = size(powerset,2);

bestError = 1;
bestCoeff = [];



for i = 1:numPowerSetData
    if(mod(i, 1000) == 0)
        i
    end
    p = powerset{i};
    data1a = data1(p,:);
    data2a = data2(p,:);
    data3a = data3(p,:);
    data4a = [data1a,data2a,data3a];
    %set up network
    net = patternnet(networkTopog, 'performFcn', loss);
    net.divideFcn = 'divideind';
    net.divideParam.trainInd = trainin;
    net.divideParam.valInd = valin;
    net.divideParam.testInd = testin;
    net.trainParam.showWindow = 0;
    [net,tr] = train(net, data4a, class4);
    y = net(data3a);
    numMissClass = 0;
    for j = 1:size(class3,2)
        high = 0;
        num = 0;
        currclass = 0;
        for k = 1:size(class3,1)
           if(y(k,j) > high)
               num = k;
               high = y(k,j);
           end
           if(class3(k,j) == 1)
               currclass = k;
           end
        end
        if(currclass ~= num)
            numMissClass = numMissClass + 1;
        end
    end
    error = numMissClass / size(class3,2);
    if (error < bestError)
        bestError = error
        bestNet = net;
        bestCoeff = p;
        plotconfusion(class3,y);
    end
end
