function [x1, dist] = SolverQuasiNewton(z)
% This function solves the optimisation problem by using the Quasi-Newton
% approach.  The user inputs an images and the output is the coefficient
% vector and the error of the produced vector.  

% Load the Zernike basis function library
load('ZernikeTest.mat');
dim = size(Zernike, 1);
c = ones(1,dim);
f = @(x)DistanceCalcAbs2(x,z);
% Use the matlab optimisation library to compute the coefficient vector.
options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'MaxFunEvals', 5000);
[x, dist] = fminunc(f, c, options);
x1 = round(x,1);