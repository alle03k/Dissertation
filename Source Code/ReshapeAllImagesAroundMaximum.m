function shapedImage = ReshapeAllImagesAroundMaximum(data)
% This function reshapes all the images in the data set so that their
% central point is their maximum value.  It saves as much information as
% possible.  The user inputs the data set and the output is the centred
% versions of all the data in that set.

len = size(data, 2);
shapedImage = data;
for i = 1:len
    %formatt the image correctly
    Image = data{1,i};
    load('ZernikeTest.mat');
    dim = size(Image, 1);
    
    % resize the image if it has the wrong dimensions
    Image = imresize(double(Image), 256/dim);
    Image = Image.*Zernike{1};
    
    %find the maximum value in the image
    maxPoint = max(Image(:));
    [Maxrow, Maxcol] = find(Image == maxPoint);
    
    %find the closest border to incororpate as much data as possible
    distance = 0;
    checker = 0;
    while checker == 0
        distance = distance + 1;
        if((Image(Maxrow + distance, Maxcol) == 0))
            distance = distance - 1;
            checker = 1;
        elseif(Image(Maxrow , Maxcol + distance) == 0)
            distance = distance - 1;
            checker = 1;
        elseif(Image(Maxrow , Maxcol - distance) == 0)
            distance = distance - 1;
            checker = 1;
        elseif(Image(Maxrow - distance, Maxcol) == 0)
            distance = distance - 1;
            checker = 1;
        end
    end
    
    %create new image using the boundary value
    NewImage = Image((Maxrow - distance):(Maxrow + distance),((Maxcol - distance):(Maxcol + distance)));
    sizeNewImage = size(NewImage, 1);
    
    %resize image to the same size as the other training images
    reshapedImage = imresize(NewImage, 256/sizeNewImage);
    reshapedImage = reshapedImage.*Zernike{1};
    centeredIm = ReshapeImageAroundMax(data{1,i});
    shapedImage{1,i} = centeredIm;
end
end