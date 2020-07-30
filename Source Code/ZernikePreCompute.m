function ZernikePreCompute()
% This function creates the premade Zernike Library of all Zernike Basis
% function from n = 1:13 and m = -13:13.  No inputs are required from the
% user.  If the images being quantified are of a different dimension to
% 256x256 then the value of dim below can be altered to match and the
% library will be created accordingly.

dim = 256;
%Set Zernike Number values
n = [0  1 1 2  2 2  3 3  3 3 4  4 4  4 4  5 5  5 5  5 5 6  6 6  6 6  6 6  7 7  7 7  7 7  7 7 8  8 8  8 8  8 8  8 8  9 9  9 9  9 9  9 9  9 9 10 10 10 10 10 10 10 10 10  10 10 11 11 11 11 11 11 11 11 11 11  11 11 12 12 12 12 12 12 12 12 12  12 12  12 12 13 13 13 13 13 13 13 13 13 13  13 13  13 13];
m = [0 -1 1 0 -2 2 -1 1 -3 3 0 -2 2 -4 4 -1 1 -3 3 -5 5 0 -2 2 -4 4 -6 6 -1 1 -3 3 -5 5 -7 7 0 -2 2 -4 4 -6 6 -8 8 -1 1 -3 3 -5 5 -7 7 -9 9  0 -2  2 -4  4 -6  6 -8  8 -10 10 -1  1 -3  3 -5  5 -7  7 -9  9 -11 11  0 -2  2 -4  4 -6  6 -8  8 -10 10 -12 12 -1  1 -3  3 -5  5 -7  7 -9  9 -11 11 -13 13];

%Define output Cell of zernike plots
Zernike = cell(size(n, 2), 1);

%Set Dimensions
inc = 2/(dim - 1);

%Run loop to calculate all values for all zernike numbers
for i = 1:size(n, 2)
   
    %Set initialisers for values
    x = -1;
    y = -1;
    count1 = 1;
    count2 = 1;
    Z = zeros(dim,dim);
    currn = n(i);
    currm = m(i);
    
    %Calculate zernike values for every point in the 2D array
    while (x < 1)
        while (y < 1)       
            phi = atan(y/x);
            p = y/sin(phi);
            M = abs(currm);
            
            %Calculate radial polynomial
            Sumation = 0;
            for k = 0:((currn-M)/2)
                currNumer = (-1)^k * (factorial(currn - k));
                currDenom = factorial(k) * factorial(((currn + M)/2) - k) * factorial(((currn - M)/2) - k);
                currTerm = (currNumer / currDenom) * (p^(currn-2*k));
                Sumation = Sumation + currTerm;
            end
            
            if(currm < 0)
              Magnitude = Sumation * sin(currm * phi);
            else
              Magnitude = Sumation * cos(currm * phi);
            end        
            if(p > 1 || p < -1 || x == 1 || y == 1)
                Magnitude = 0;
            end
            Z(dim + 1 - count2,count1) = Magnitude;
            count2 = count2 + 1;
            y = y + inc;
        end
       count2 = 1;
       count1 = count1 + 1;
       y = -1;
       x = x + inc;
    end
    
    %Assign values into the cell array to be saved
    Zernike{i} = Z;
end

%Saves the cell into a object ZernikeTest
save ZernikeTest Zernike