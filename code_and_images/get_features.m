close all
clear
run('VLFEATROOT/toolbox/vl_setup')

pos_imageDirT = 'training_set_faces';
pos_imageListT = dir(sprintf('%s/*.jpg',pos_imageDirT));
pos_nImagesT = length(pos_imageListT);

neg_imageDirT = 'training_set_not_faces';
neg_imageListT = dir(sprintf('%s/*.jpg',neg_imageDirT));
neg_nImagesT = length(neg_imageListT);

cellSize = 6;
featSize = 31*cellSize^2;

pos_featsT = zeros(pos_nImagesT,featSize);
for i=1:pos_nImagesT
    im = im2single(imread(sprintf('%s/%s',pos_imageDirT,pos_imageListT(i).name)));
    feat = vl_hog(im,cellSize);
    pos_featsT(i,:) = feat(:);
    fprintf('got feat for pos image %d/%d\n',i,pos_nImagesT);
end

neg_featsT = zeros(neg_nImagesT,featSize);
for i=1:neg_nImagesT
    im = im2single(imread(sprintf('%s/%s',neg_imageDirT,neg_imageListT(i).name)));
    feat = vl_hog(im,cellSize);
    neg_featsT(i,:) = feat(:);
    fprintf('got feat for neg image %d/%d\n',i,neg_nImagesT);
end

save('pos_neg_featsTraining.mat','pos_featsT','neg_featsT','pos_nImagesT','neg_nImagesT')

%% Not Faces
pos_imageDirV = 'validation_set_faces';
pos_imageListV = dir(sprintf('%s/*.jpg',pos_imageDirV));
pos_nImagesV = length(pos_imageListV);

neg_imageDirV = 'validation_set_not_faces';
neg_imageListV = dir(sprintf('%s/*.jpg',neg_imageDirV));
neg_nImagesV = length(neg_imageListV);

cellSize = 6;
featSize = 31*cellSize^2;

pos_featsV = zeros(pos_nImagesV,featSize);
for i=1:pos_nImagesV
    im = im2single(imread(sprintf('%s/%s',pos_imageDirV,pos_imageListV(i).name)));
    feat = vl_hog(im,cellSize);
    pos_featsV(i,:) = feat(:);
    fprintf('got feat for pos image %d/%d\n',i,pos_nImagesV);
end

neg_featsV = zeros(neg_nImagesV,featSize);
for i=1:neg_nImagesV
    im = im2single(imread(sprintf('%s/%s',neg_imageDirV,neg_imageListV(i).name)));
    feat = vl_hog(im,cellSize);
    neg_featsV(i,:) = feat(:);
    fprintf('got feat for neg image %d/%d\n',i,neg_nImagesV);
end

save('pos_neg_featsValidation.mat','pos_featsV','neg_featsV','pos_nImagesV','neg_nImagesV')