function [Z] = ZernikeCalcWithPoly(poly)
% This function takes in a coefficient polynomial and re-creates the image
% out of this polynomial and the saved Zernike basis function library.  The
% input is the polynomial of any length up to 105 and the output is the 2D
% representation of the image.

%Load precomputed Zernike values
load('ZernikeTest.mat')

%Define new 2d space for generated values
len = size(Zernike, 2);
Z = zeros(len, len);

%combine the polynomial with the preset zernike value 
%to compute the whole map
for i = 1:length(poly)
      Z = Z + (Zernike{i} * poly(i));
end

%Calculate the Max value of the Z array
maxval = 0.0;
for i = 1:81
    for j = 1:81
        a = Z(i,j);
        if(a < 0)
            a = a * -1;
        end
        if a > maxval
            maxval = a;
        end
    end
end

%Normalise the data in the array
Z = Z/maxval;

end