function [results, saved] = SolverGeneticAlgorithm(z)
% This function solves the optimisation problem by using the Genetic
% algorithm approach.  The user inputs an image and the output is the 
% coefficient vector and the error of the produced vector.  

% Initialise all required variables
solved = 1;
counter = 1;
results = zeros(5,3);
minval = 1000000;
saved = zeros(10,22);
load('ZernikeTest.mat')
currbest = 0;
for i = 1:20
    for j = 1:22
        saved(i,j) = 10000;
    end
end

% using the genetic manipulator run the first devolpment cycle of the
% algorithms which creats your initial population.
init = SolverGeneticAlgorithmGeneticManipulator(1, saved, minval);
for i = 1:1000
    % Evaluate the error of each chromosome
    init(i,22) = DistanceCalcAbs2(init(i,1:21),z);
    % check if error already present in top data set
    for j = 1:20
        add = 0;
        if(round(init(i,22),4) == round(saved(j,22),4))
            add = 1;
            break
        end
    end
    % Save the top 20 results of the initial data set.
    if(add == 0)
        for j = 1:20
            if(init(i,22) < saved(j,22))
                saved(j,1:22) = init(i,1:22);
                break
            end
        end
    end
end
% Sort the row and work out the currrent best result.
sortrows(saved,22);
currbest = saved(1,1:21);
Z = ZernikeCalcWithPoly(currbest);
E=(z-Z).*Zernike{1};
maxval = 0.0;
% ensure all values in the 2D array are between -1 and 1 by finding the
% maximum value and dividing the whole image by it.
for i = 1:256
    for j = 1:256
        a = E(i,j);
        if(a < 0)
            a = a * -1;
        end
        if a > maxval
            maxval = a;
        end
    end
end
E = E/maxval;

% Calculate the next generation using the top 20 values
new = SolverGeneticAlgorithmGeneticManipulator(2, saved, minval);

while solved == 1
    for i = 1:50
        % calculate errors for new population
        new(i,22) = DistanceCalcAbs2(new(i,1:21),z);
        for j = 1:20
            add = 0;
            if(round(new(i,22),4) == round(saved(j,22),4))
                add = 1;
                break
            end
        end
        % Save top 20 chromosomes
        if(add == 0)
            for j = 1:20
                if(new(i,22) < saved(j,22))
                    saved(j,1:22) = new(i,1:22);
                    break
                end
            end
        end
    end
    % Wokr out current best error
    [minval, minidx] = min(saved(:,22));
    if(mod(counter,10) == 0)
        results(counter/10,1) = counter;
        results(counter/10,2) = minval;
        results(counter/10,3) = time;
        %check if the error hasn't changed in the last 10 generations
        if(counter ~= 10)
            if(minval == results((counter/10) - 1,2))
                solved = 0;
            end
        end
    end
    
    % Checks for stopping conditions of algorithm
    if(counter == 500 || minval < 5)
        solved = 0;
        sortrows(saved,22);
    % If none are made continue
    else
        %Sort the rows and create another generation using top values
        sortrows(saved,22);
        new = SolverGeneticAlgorithmGeneticManipulator(2, saved, minval);
        counter = counter + 1;
        
        % Normalise the images.
        if(mod(counter, 20) == 0)
            currbest = saved(1,1:21);
            Z = ZernikeCalcWithPoly(currbest);
            E=(z-Z).*Zernike{1};
            maxval = 0.0;
            for i = 1:256
                for j = 1:256
                    a = E(i,j);
                    if(a < 0)
                        a = a * -1;
                    end
                    if a > maxval
                        maxval = a;
                    end
                end
            end
            counter
            minval
        end
    end
end

% Once finishing condition has been met return results.
results = saved(1,1:21);
saved = saved(1,22);
