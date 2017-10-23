close;
clear;
clc;

%% read image
filename = 'image2.jpg';
I = imread(filename);
figure('name', 'source image');
imshow(I);

%% ----- pre-lab ----- %%
% output = function(input1, input2, ...);
% grey_scale function
I2 = grey_scale(I);

%% ----- homework lab ----- %%
% flip function
I3 = flip(I,0);
I4 = flip(I,1);
I5 = flip(I,2);

% rotation function
I6 = rotation(I, pi/3);

%% show image
figure('name', 'grey scale image'),
imshow(I2);

figure('name', 'horizontally flipped image'),
imshow(I3);

figure('name', 'vertically flipped image'),
imshow(I4);

figure('name', 'horizontally & vertically flipped image'),
imshow(I5);

figure('name', 'rotated image'),
imshow(I6);

%% write image
% save image for your report
filename2 = 'grey_scale_image.jpg';
imwrite(I2, filename2);

filename3 = 'horizontally_flipped.jpg';
imwrite(I3, filename3);

filename4 = 'vertically_flipped.jpg';
imwrite(I4, filename4);

filename5 = 'horizontally_&_vertically_flipped.jpg';
imwrite(I5, filename5);

filename6 = 'rotated.jpg';
imwrite(I6, filename6);




