function [a, dist] = Coefficient_Solver(data,algorithmUsed)
% Algorthim Used value defines with method to use
% 1 = Linear Square with Gaussian ELimination
% 2 = Quasi Newton
% 3 = Levenberg Marquardt
% 4 = Genetic Algorithm

load('ZernikeTest.mat');
if(algorithmUsed == 1)
    % This function uses the linear square with gaussian elimination method to
    % compute the coefficient vector.  The user inputs an images and the output
    % is the coefficient vector and the error of the produced vector.

    [nr nc]=size(data);
    I=imresize(double(data),256/nr);
    I1=I.*Zernike{1};
    R=14;
    M=(R*(R+1))/2;
    I_size = size(I1);
    I2 = reshape(I1,I_size(1)^2,1);
    Z = zeros(I_size(1)^2,M);
    for i=1:M
        Z(:,i) = reshape(Zernike{i},I_size(1)^2,1);
    end
    a=Z'*Z\Z'*I2;
    J=zeros(256,256);
    for i=1:M
        J=J+a(i)*Zernike{i};
    end
    E=(I-J).*Zernike{1};
    dist = Distance_Calc(a,data);
    
elseif(algorithmUsed == 2)
    % This function solves the optimisation problem by using the Quasi-Newton
    % approach.  The user inputs an images and the output is the coefficient
    % vector and the error of the produced vector.  

    dim = size(Zernike, 1);
    c = ones(1,dim);
    f = @(x)Distance_Calc(x,data);
    options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'Display', 'iter', 'MaxFunEvals', 5000);
    [a, dist] = fminunc(f, c, options);
    
elseif(algorithmUsed == 3)
    % This function solves the optimisation problem by using the
    % Levenberg-Marquardt approach.  The user inputs an images and the output 
    % is the coefficient vector and the error of the produced vector.  

    dim = size(Zernike, 1);
    c = ones(1,dim);
    f = @(x)Distance_Calc(x,data);
    options = optimoptions(@lsqnonlin, 'Algorithm', 'Levenberg-Marquardt', 'Display', 'iter', 'StepTolerance', 0.005);
    [a, dist] = lsqnonlin(f, c, [], [], options);
    
else
    % This function solves the optimisation problem by using the Genetic
    % algorithm approach.  The user inputs an image and the output is the 
    % coefficient vector and the error of the produced vector.  

    solved = 1;
    counter = 1;
    results = zeros(5,3);
    minval = 1000000;
    saved = zeros(10,22);
    currbest = 0;
    for i = 1:20
        for j = 1:22
            saved(i,j) = 10000;
        end
    end

    init = GeneticAlgorithmGeneticManipulator(1, saved, minval);
    for i = 1:1000
        init(i,22) = Distance_Calc(init(i,1:21),z);
        for j = 1:20
            add = 0;
            if(round(init(i,22),4) == round(saved(j,22),4))
                add = 1;
                break
            end
        end
        if(add == 0)
            for j = 1:20
                if(init(i,22) < saved(j,22))
                    saved(j,1:22) = init(i,1:22);
                    break
                end
            end
        end
    end
    sortrows(saved,22);
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
    E = E/maxval;

    new = GeneticAlgorithmGeneticManipulator(2, saved, minval);
    while solved == 1
        for i = 1:50
            new(i,22) = Distance_Calc(new(i,1:21),z);
            for j = 1:20
                add = 0;
                if(round(new(i,22),4) == round(saved(j,22),4))
                    add = 1;
                    break
                end
            end
            if(add == 0)
                for j = 1:20
                    if(new(i,22) < saved(j,22))
                        saved(j,1:22) = new(i,1:22);
                        break
                    end
                end
            end
        end
        [minval, minidx] = min(saved(:,22));
        if(mod(counter,10) == 0)
            results(counter/10,1) = counter;
            results(counter/10,2) = minval;
            results(counter/10,3) = time;
            if(counter ~= 10)
                if(minval == results((counter/10) - 1,2))
                    solved = 0;
                end
            end
        end

        if(counter == 500 || minval < 5)
            solved = 0;
            sortrows(saved,22);
        else
            sortrows(saved,22);
            new = GeneticAlgorithmGeneticManipulator(2, saved, minval);
            counter = counter + 1;

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
            end
        end
    end

    a = saved(1,1:21);
    dist = saved(1,22);
end