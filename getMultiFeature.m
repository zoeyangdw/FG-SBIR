clc;clear;
addPaths;

%get three-level features

%% low-level feature
load PCA_HOG.mat;
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

%% mid-level feature
load PBox.mat
mid = zeros(num, num_p*(num_p-1)/2);
for i = 1:num
    mid(i,:) = getStructure(Parts{i}, num_p);
end

%% fine-grained attribute


