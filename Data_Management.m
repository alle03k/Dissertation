Usable_Data_2 = cell(10,2);
count = 1;
for i = 1:252
    if(Usable_Data{i,3} == 0)
        Usable_Data_2{count, 1} = Usable_Data{i,1};
        Usable_Data_2{count, 2} = Usable_Data{i,2};
        count = count + 1;
    end
end
        

Usabel1 = cell(2,10);
counter1 = 1;
Usabel2 = cell(2,10);
counter2 = 1;
Usabel3 = cell(2,10);
counter3 = 1;
for i = 1:181
    x = Usable_Data{i,2};
    if(x == 1)
        Usabel1{1,counter1} = Usable_Data{i,1};
        Usabel1{2,counter1} = Usable_Data{i,2};
        counter1 = counter1 + 1;
    elseif(x == 2)
        Usabel2{1,counter2} = Usable_Data{i,1};
        Usabel2{2,counter2} = Usable_Data{i,2};
        counter2 = counter2 + 1;
    else
        Usabel3{1,counter3} = Usable_Data{i,1};
        Usabel3{2,counter3} = Usable_Data{i,2};
        counter3 = counter3 + 1;
    end
end

Usable_Data_Ordered = cell(2,181);
for i = 1:20
    Usable_Data_Ordered{1,i} = Usabel1{1,i};
    Usable_Data_Ordered{2,i} = Usabel1{2,i};
end
for i = 1:99
    Usable_Data_Ordered{1,20+i} = Usabel2{1,i};
    Usable_Data_Ordered{2,20+i} = Usabel2{2,i};
end
for i = 1:62
    Usable_Data_Ordered{1,119+i} = Usabel3{1,i};
    Usable_Data_Ordered{2,119+i} = Usabel3{2,i};
end

for i = 1:181
    Usable_Data_Ordered{3,i} = Coefficient_Solver(Usable_Data_Ordered{1,i},1);
end

Complete_Data = cell(3,10);
datacounter = 1;
for a = 1:3
    for i = 1:298
        x = Uncentred_Complete_Data{2,i};
        if(x == a)
            Complete_Data{1,datacounter} = Uncentred_Complete_Data{1,i};
            Complete_Data{2,datacounter} = Uncentred_Complete_Data{2,i};
            Complete_Data{3,datacounter} = Uncentred_Complete_Data{3,i};
            datacounter = datacounter + 1;
        end
        if(i < 182)
            x = Usable_Data_Ordered_49{2,i};
            if(x == a)
                Complete_Data{1,datacounter} = Usable_Data_Ordered_49{1,i};
                Complete_Data{2,datacounter} = Usable_Data_Ordered_49{2,i};
                Complete_Data{3,datacounter} = Usable_Data_Ordered_49{3,i};
                datacounter = datacounter + 1;
            end
        end
    end
end
            
neuralTrainData13v2Class = zeros(2,70);
neuralTrainData13v2Values = zeros(105,70);
neuralTestData13v2Class = zeros(2,36);
neuralTestData13v2Values = zeros(105,36);
coeffs = [1:105];

for i = 1:70
    if(i <= 36)
        a = testData13v2{3,i};
        b = testData13v2{2,i};
        vals = a(coeffs);
        neuralTestData13v2Values(1:105,i) = vals';
        neuralTestData13v2Class(b,i) = 1;
    end
    a = trainingData13v2{3,i};
    b = trainingData13v2{2,i};
    vals = a(coeffs);
    neuralTrainData13v2Values(1:105,i) = vals';
    neuralTrainData13v2Class(b,i) = 1;
end

for i = 1:479
    [a,b] = Coefficient_Solver(cent{1,i}, 1);
    Complete_Data{3,i} = a;
end

counter = 1;
for i = 1:479
    if(mock{1,i} == 0)
        
    else
        mocker{1,counter} = mock{1,i};
        mocker{2,counter} = mock{2,i};
        mocker{3,counter} = mock{3,i};
        counter = counter + 1;
    end
end

for i = 1:357
a = r(i);
mock{1,a} = 0;
mock{2,a} = [];
mock{3,a} = [];
end
            
