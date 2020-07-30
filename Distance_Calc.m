function [distance] = Distance_Calc(poly, mappingImage)
% this calculates the distance function.  It takse in the coefficient
% polynomial and the original image and either calculates the Euclidean or
% the Relative error.

% [Z] = ZernikeCalcWithPoly(poly);

load('ZernikeTest.mat')
len = size(Zernike, 2);
Z = zeros(len, len);
for i = 1:length(poly)
      Z = Z + (Zernike{i} * poly(i));
end
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
Z = Z/maxval;

dimImage = size(mappingImage, 2);
vD=imresize(double(Z),dimImage/256);

distance = 0;
% base Euclidean
for x = 1:81
    for y = 1:81
        distance = distance + (mappingImage(x,y) - Z(x,y))^2;
    end
end

% % Base Relative Error
% vR = reshape(mappingImage,1,dimImage*dimImage);
% vD = reshape(vD,1,dimImage*dimImage);
% in = find(vR);
% distance = 100 * abs(vD(in) - vR(in)) / abs(vD(in));
end
