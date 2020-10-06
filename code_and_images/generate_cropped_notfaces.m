% you might want to have as many negative examples as positive examples
clc;
clear;
%% 1.1
n_have = 0;
n_want = numel(dir('cropped_training_images_faces/*.jpg'));

imageDir = 'images_notfaces';
imageList = dir(sprintf('%s/*.jpg',imageDir));
nImages = length(imageList);

new_imageDir = 'cropped_training_images_not_faces';
mkdir(new_imageDir);

dim = 36;
count = 1;

while n_have < n_want
    % generate random 36x36 crops from the non-face images
    if count == nImages
        count = 1;
    end 
    imgName = imageList(count).name;
    imgPath = append(imageList(count).folder, append('\', imgName));
    curr_img = rgb2gray(imread(imgPath));
    [x,y,~] = size(curr_img);
    x_rand_start = randi(x - dim + 1);
    x_rand_end = x_rand_start + dim - 1;
    y_rand_start = randi(y - dim + 1);
    y_rand_end = y_rand_start + dim - 1;
    cropped_img = curr_img(x_rand_start: x_rand_end, y_rand_start: y_rand_end);
    
    croppedImgsPath = fullfile(new_imageDir, append(string(n_have), '.jpg'));
    imwrite(cropped_img, croppedImgsPath);
    count = count + 1;
    n_have = n_have + 1;
end

%% 1.2

%% Not Faces
n_have = 1;

new_imageDir = 'training_set_not_faces';
mkdir(new_imageDir);

new_imageDir2 = 'validation_set_not_faces';
mkdir(new_imageDir2);

imageDir = 'cropped_training_images_not_faces';
imageList = dir(sprintf('%s/*.jpg',imageDir));
nImages = length(imageList);

nTrainingSet = 0.8*nImages;

while n_have <= nTrainingSet
    imgName = imageList(n_have).name;
    imgPath = append(imageList(n_have).folder, append('\', imgName));
    image = imread(imgPath);
    croppedImgsPath = fullfile(new_imageDir, imgName);
    imwrite(image, croppedImgsPath);
    n_have = n_have + 1;
end

while n_have > nTrainingSet && n_have <=nImages
    imgName = imageList(n_have).name;
    imgPath = append(imageList(n_have).folder, append('\', imgName));
    image = imread(imgPath);
    croppedImgsPath = fullfile(new_imageDir2, imgName);
    imwrite(image, croppedImgsPath);
    n_have = n_have + 1;
end

%% Faces
n_have2 = 1;

new_imageDir3 = 'training_set_faces';
mkdir(new_imageDir3);

new_imageDir4 = 'validation_set_faces';
mkdir(new_imageDir4);

imageDir2 = 'cropped_training_images_faces';
imageList2 = dir(sprintf('%s/*.jpg',imageDir2)); 
nImages2 = length(imageList2);
nTrainingSet2 = 0.8*nImages2;

while n_have2 <= nTrainingSet2
    imgName = imageList2(n_have2).name;
    imgPath2 = append(imageList2(n_have2).folder, append('\', imgName));
    image2 = imread(imgPath2);
    croppedImgsPath2 = fullfile(new_imageDir3, imgName);
    imwrite(image2, croppedImgsPath2);
    n_have2 = n_have2 + 1;
end
while n_have2 > nTrainingSet2 && n_have2 <=nImages2
    imgName = imageList2(n_have2).name;
    imgPath2 = append(imageList2(n_have2).folder, append('\', imgName));
    image2 = imread(imgPath2);
    croppedImgsPath2 = fullfile(new_imageDir4, imgName);
    imwrite(image2, croppedImgsPath2);
    n_have2 = n_have2 + 1;
end
