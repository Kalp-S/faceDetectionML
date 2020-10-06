run('VLFEATROOT/toolbox/vl_setup')
load('pos_neg_featsTraining.mat')

feats = cat(1,pos_featsT,neg_featsT);
labels = cat(1,ones(pos_nImagesT,1),-1*ones(neg_nImagesT,1));

lambda = 0.1;
[w,b] = vl_svmtrain(feats',labels',lambda);

fprintf('Classifier performance on train data:\n')
confidences = [pos_featsT; neg_featsT]*w + b;

[tp_rate, fp_rate, tn_rate, fn_rate] =  report_accuracy(confidences, labels);

%%
load('pos_neg_featsValidation.mat')
fprintf('Classifier performance on Validation data:\n')
labels = cat(1,ones(pos_nImagesV,1),-1*ones(neg_nImagesV,1));
confidences = [pos_featsV; neg_featsV]*w + b;
[tp_rate, fp_rate, tn_rate, fn_rate] =  report_accuracy(confidences, labels);

save('my_svm.mat','pos_featsV','w','b')