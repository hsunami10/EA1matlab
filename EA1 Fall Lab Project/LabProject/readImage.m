function image = readImage(imgName)

imageVec = imread(imgName);
if(length(size(imageVec)) > 2)
    image = im2double(rgb2gray(imageVec));
else
    image = im2double(imageVec);
end