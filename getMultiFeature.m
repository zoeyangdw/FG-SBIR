clc;clear;
addPaths;

%% low-level feature Image
 load PCA_HOG_Image.mat;
 [num_p, num, num_f] = size(feature_pca);
% low = zeros(num, num_p*num_f);
% for i = 1: num
%     temp = [ ];
%     for j = 1: num_p
%         f = squeeze(feature_pca(j, i, :));
%         temp = [temp, f'] ;
%     end
%     low(i, :) = temp;   
% end
% save Image_Low low;

%% mid-level feature
% load PBox_Image.mat
% mid = zeros(num, num_p*(num_p-1)/2);
% for i = 1:num
%     mid(i,:) = getStructure(Parts{i}, num_p);
% end
% save Image_Mid mid;

%% fine-grained attribute
%round, toe-open(2), ornament or brand on body, on vamp(4), low heel, high
%piller, cone, slender, thick(1), low boot, middle, high boot(3)
load SVMs_Image.mat
num_svm = length(svms_img);
high = zeros(num, num_svm);
for i = 1:num
    for j = 1:2
        model = svms_img(j);
        hog = (squeeze(feature_pca(2, i, :)))';
        label = 0;
        [predict_label] = svmpredict(label, hog, model);
        high(i, j) = predict_label;
    end
    for j = 3:4
        model = svms_img(j);
        hog = (squeeze(feature_pca(4, i, :)))';
        label = 0;
        [predict_label] = svmpredict(label, hog, model);
        high(i, j) = predict_label;
    end
    for j = 5:10
        model = svms_img(j);
        hog = (squeeze(feature_pca(1, i, :)))';
        label = 0;
        [predict_label] = svmpredict(label, hog, model);
        high(i, j) = predict_label;
    end
    for j = 11:13
        model = svms_img(j);
        hog = (squeeze(feature_pca(3, i, :)))';
        label = 0;
        [predict_label] = svmpredict(label, hog, model);
        high(i, j) = predict_label;
    end
end
save Image_High high;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% low-level feature Sketch
load PCA_HOG_Sketch.mat;
[num_p, num, num_f] = size(feature_pca);
low = zeros(num, num_p*num_f);
for i = 1: num
    temp = [ ];
    for j = 1: num_p
        f = squeeze(feature_pca(j, i, :));
        temp = [temp, f'] ;
    end
    low(i, :) = temp;   
end
save Sketch_Low low;

%% mid-level feature
load PBox_Sketch.mat
mid = zeros(num, num_p*(num_p-1)/2);
for i = 1:num
    mid(i,:) = getStructure(Parts{i}, num_p);
end
save Sketch_Mid mid;

%% fine-grained attribute
%round, toe-open(2), ornament or brand on body, on vamp(4), low heel, high
%piller, cone, slender, thick(1), low boot, middle, high boot(3)
load SVMs_Sketch.mat
num_svm = length(svms_sketch);
high = zeros(num, num_svm);
for i = 1:num
    for j = 1:2
        model = svms_sketch(j);
        hog = (squeeze(feature_pca(2, i, :)))';
        label = 0;
        [predict_label] = svmpredict(label, hog, model);
        high(i, j) = predict_label;
    end
    for j = 3:4
        model = svms_sketch(j);
        hog = (squeeze(feature_pca(4, i, :)))';
        label = 0;
        [predict_label] = svmpredict(label, hog, model);
        high(i, j) = predict_label;
    end
    for j = 5:10
        model = svms_sketch(j);
        hog = (squeeze(feature_pca(1, i, :)))';
        label = 0;
        [predict_label] = svmpredict(label, hog, model);
        high(i, j) = predict_label;
    end
    for j = 11:13
        model = svms_sketch(j);
        hog = (squeeze(feature_pca(3, i, :)))';
        label = 0;
        [predict_label] = svmpredict(label, hog, model);
        high(i, j) = predict_label;
    end
end
save Sketch_High high;

