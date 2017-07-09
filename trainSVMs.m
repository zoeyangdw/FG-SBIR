clc;clear;
addPaths;

%Data structure of lable
% 1-2: toe cap
% 3-4: body or vamp
% 5- 10: heel
% 11-13: boot

% part 1: Heel { low heel, high heel, pillar heel, cone heel, slender
%heel,thick heel }
% part 2: toe cap { round, toe-open }
% part 3: Boot { low boot, middle boot, high boot }
% part 4: Body or vamp { ornament or brand on body side, ornament or
% shoelace on vamp }

num_p = 4;

% load 13_A_sketch_label.mat
% a = 37;
% b = 56;
% c = 304+107;
% d = 304+126;
% e = 608+252;
% f = 608+271;
% test_label = [sketch_label(a:b,13); sketch_label(c:d,13); sketch_label(e:f,13)];
% train_label = [sketch_label(1:a-1,13); sketch_label(b+1:c-1,13); sketch_label(d+1:e-1,13); sketch_label(f+1:912,13)];
% %train_label = image_label(1:206,3);
% load PCA_HOG_Sketch.mat
% test_feature = [squeeze(feature_pca(3,a:b,:)); squeeze(feature_pca(3,c:d,:)); squeeze(feature_pca(3,e:f,:))];
% train_feature = [squeeze(feature_pca(3,1:a-1,:)); squeeze(feature_pca(3,b+1:c-1,:)); squeeze(feature_pca(3,d+1:e-1,:)); squeeze(feature_pca(3,f+1:912,:))];
% %train_feature = squeeze(feature_pca(4,1:206,:));
% 
% [bestacc, bestc, bestg] = SVMcg(train_label, train_feature,-5,5,-5,5,3,1,1);
% ss = ['-t 2 -c ', num2str(bestc),' -g ',num2str(bestg),' -q'];
% model = svmtrain(train_label,train_feature,ss);
% [predict_label, accuracy, dec_values] = svmpredict(test_label, test_feature, model);
% 
% load SVMs_Sketch;
% a = length(svms_sketch);
% svms_sketch(a+1) = model;
% %svms_sketch = model;
% save SVMs_Sketch svms_sketch;

load 13_A_image_label.mat
i = 8;
j = 1;
a = 39;
b = 63;
test_label = image_label(a:b,i);
train_label = [image_label(1:a-1,i); image_label(b+1:304,i)];
%train_label = image_label(1:206,3);
load PCA_HOG_Image.mat
test_feature = squeeze(feature_pca(j,a:b,:));
train_feature = [squeeze(feature_pca(j,1:a-1,:)); squeeze(feature_pca(j,b+1:304,:))];
%train_feature = squeeze(feature_pca(4,1:206,:));

[bestacc, bestc, bestg] = SVMcg(train_label, train_feature,-5,5,-5,5,3,1,1);
ss = ['-t 2 -c ', num2str(bestc),' -g ',num2str(bestg),' -q'];
model = svmtrain(train_label,train_feature,ss);
[predict_label, accuracy, dec_values] = svmpredict(test_label, test_feature, model);

 load SVMs_Image;
 a = length(svms_img);
 svms_img(a+1) = model;
 %svms_img = model;
save SVMs_Image svms_img;

%test attribute toe cap of rou
%load 13_A_sketch_label.mat
% label = zeros(297, 1);
% col = 11;
% for i = 1:99
%     for j = 1:3
%         label(3*(i-1)+j, 1) = sketch_label(304*(j-1)+i,col);
%     end
% end
% 

% load PCA_HOG_Sketch.mat
% feature = svm_scale(squeeze(feature_pca(3, :,:)));
% train_feature =feature(1:265,:);
% test_feature = feature(266:297,:);
%(data - repmat(min(data,[],1),size(data,1),1))*spdiags(1./(max(data,[],1)-min(data,[],1))',0,size(data,2),size(data,2));
% c =power(2,(12.5-10));
% g = power(2,(8.5-10));
 %ss = ['-t 2 -c ',num2str(c),' -g ',num2str(g),' -q'];
% model = svmtrain(train_label,train_feature,ss);