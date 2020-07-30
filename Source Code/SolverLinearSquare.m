function [a, dist] = SolverLinearSquare(data)
% This function uses the linear square with gaussian elimination method to
% compute the coefficient vector.  The user inputs an images and the output
% is the coefficient vector and the error of the produced vector.

%Load Zernike basis function library
load('ZernikeTest.mat')

% Resize the image if the dimensions don't match those specified.
[nr nc]=size(data);
I=imresize(double(data),256/nr);
I1=I.*Zernike{1};

% Calculate number of radial degrees and number of zernike coefficients
R=14;
M=(R*(R+1))/2;

% Find coefficients using linear least squares
I_size = size(I1);
I2 = reshape(I1,I_size(1)^2,1);
Z = zeros(I_size(1)^2,M);
for i=1:M
	Z(:,i) = reshape(Zernike{i},I_size(1)^2,1);
end
a=Z'*Z\Z'*I2;

% Reconstruct
J=zeros(256,256);
for i=1:M
    J=J+a(i)*Zernike{i};
end

% Calculate the Error
E=(I-J).*Zernike{1};
dist = DistanceCalcAbs2(a,data);

% subplot(2,3,1); imshow(I.*Zernike{1},[]); % Mask out the edges
% title('Data');
% subplot(2,3,2); imshow(J,[])
% title('Z-fit');
% subplot(2,3,3), imshow(E,[]);
% title('Error');
% 
% subplot(2,3,4); mesh(x,y,I.*Zernike{1}); % Mask out the edges
% title('Data');
% subplot(2,3,5); mesh(x,y, J);
% title('Z-fit'); 
% subplot(2,3,6); mesh(x,y,E);
% title('Error');

end