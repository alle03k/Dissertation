function [distance] = DistanceCalcAbs2(poly, mappingImage)
% this calculates the distance function.  It takse in the coefficient
% polynomial and the original image and either calculates the Euclidean or
% the Relative error.

[Z] = ZernikeCalcWithPoly(poly);
dimImage = size(mappingImage, 2);
vD=imresize(double(Z),dimImage/256);

% distance = 0;
% % base Euclidean
% for x = 1:81
%     for y = 1:81
%         distance = distance + (mappingImage(x,y) - Z(x,y))^2;
%     end
% end

% % Base Relative Error
vR = reshape(mappingImage,1,dimImage*dimImage);
vD = reshape(vD,1,dimImage*dimImage);
in = find(vR);
distance = 100 * abs(vD(in) - vR(in)) / abs(vD(in));
end
