function allGens = GeneticAlgorithmGeneticManipulator(instruc, set, min)
% this is the genentic manipulator for the genetic algorithm.  It performs
% the breeding and mutation techniques on the population to create the new
% populations.

rng('shuffle');

if(instruc == 1)
    allGens = round((3*rand(1000,21) - 1) .* sign(rand(1000,1)),3);
elseif(instruc == 2)
    allGens = zeros(50,21);
    a = randi(10,[1,50]);
    for i = 1:50
        b = randi(3);
        b2 = randi(4);
        if(a(1,i) < 4)
            allGens(i,1:21) = round(((5 * set(b*b2,1:21) + 3 * set(1,1:21) + 2 * set(2,1:21))/10),3);
        elseif(a(1,i) >= 4 && a(1,i) < 6)
            allGens(i,1:21) = round(((5 * set(b2*b + 2,1:21) + 3 * set(1,1:21) + 2 * set(2,1:21))/10),3);
        elseif(a(1,i) >= 6 && a(1,i) < 7)
            allGens(i,1:21) = round(((5 * set(b2*b + 4,1:21) + 3 * set(1,1:21) + 2 * set(2,1:21))/10),3);
        elseif(a(1,i) >= 7 && a(1,i) < 8)
            b = randi(21,[1,8]);
            allGens(i,1:21) = set(1,1:21);
            for j = 1:size(b)
                if(min < 0.01)
                    allGens(i,b(1,j)) = allGens(i,b(1,j)) + (0.0001 .* sign(randn(1,1)));
                else
                    allGens(i,b(1,j)) = allGens(i,b(1,j)) + (0.01 .* sign(randn(1,1)));
                end
            end
        elseif(a(1,i) == 9)
            b = randi(21,[1,8]);
            allGens(i,1:21) = set(1,1:21);
            for j = 1:size(b)
                if(min < 0.001)
                    allGens(i,b(1,j)) = allGens(i,b(1,j)) + (0.00001 .* sign(randn(1,1)));
                else
                    allGens(i,b(1,j)) = allGens(i,b(1,j)) + (0.001 .* sign(randn(1,1)));
                end
            end
        else
            b = randi(21,[1,8]);
            c = randi(21,[1,4]);
            allGens(i,1:21) = set(1,1:21);
            count = 1;
            for j = 1:4
                allGens(i,b(1,(2*j - 1))) = allGens(i,c(1,count));
                allGens(i,b(1,(2*j))) = allGens(i,c(1,count));
                count = count + 1;
            end
        end
    end
end

end