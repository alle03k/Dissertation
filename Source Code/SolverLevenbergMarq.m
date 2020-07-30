function [x1, dist] = SolverLevenbergMarq(z)
% This function solves the optimisation problem by using the
% Levenberg-Marquardt approach.  The user inputs an images and the output 
% is the coefficient vector and the error of the produced vector.  

% Load the Zernike basis function library
load('ZernikeTest.mat');
dim = size(Zernike, 1);
c = ones(1,dim);
% Define the options and distance function of the optimisation method.  Use
% the optimisation toolbox to compute the Levenberg-Marquardt result.
f = @(x)DistanceCalcAbs2(x,z);
options = optimoptions(@lsqnonlin, 'Algorithm', 'Levenberg-Marquardt', 'StepTolerance', 0.005);
[x, dist] = lsqnonlin(f, c, [], [], options);
x1 = round(x,1);
end