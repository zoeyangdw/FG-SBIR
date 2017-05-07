clc;clear;
addPaths;

%%Train PCAS and get part features processed by PCA
load PHOG.mat;
num = length(Parts_Hog);%304
num_parts = length(Parts_Hog{1});%4
num_hog = length(Parts_Hog{1}{1});%1152
feature = zeros(num_parts, num, num_hog);
feature_pca = zeros(num_parts, num, 250);
pcas = zeros(num_parts, num_hog, 250);

for i = 1: num
    for j = 1:num_parts
        temp = Parts_Hog{i}{j};
        feature(j, i, :) = (Parts_Hog{i}{j})';
    end
end

for k = 1:num_parts
    temp = squeeze(feature(k, :, :));
    [pc, score, latent, tsquare] = pca(temp);
    tran = pc(:, 1:250);
    temp = temp*tran;
    pcas(k, :, :) = tran;
    feature_pca(k, :, :) = temp;
end
save PCAs pcas;
save PCA_HOG feature_pca;

