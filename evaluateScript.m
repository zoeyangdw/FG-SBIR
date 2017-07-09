img_low = getfield(load('Image_Low.mat'), 'low');
img_mid = getfield(load('Image_Mid.mat'), 'mid');
img_high = getfield(load('Image_High.mat'), 'high');

sketch_low = getfield(load('Sketch_Low.mat'), 'low');
sketch_mid = getfield(load('Sketch_Mid.mat'), 'mid');
sketch_high = getfield(load('Sketch_High.mat'), 'high');

val_X = [img_low, img_mid, img_high];
% val_X = [img_low(1:10,:), img_mid(1:10,:), img_high(1:10,:)];
 val_X1 = [sketch_low(1:10,:), sketch_mid(1:10,:), sketch_high(1:10,:)];
%val_X1 = [sketch_low, sketch_mid, sketch_high];
% 
 all_X = [val_X; val_X1];
 index = [ones(1000,1);ones(6,1)*2;ones(13,1)*3];
 [V, D] = MultiviewCCA(all_X, index, 0.1);
 D = D^2; 
 P = val_X*V*D;
 P1 = val_X1*V*D;

dMat = pdist2(P,P1);
M = 10; % number of test data
%sortMat: sortedMat, sortIdx: the index of the origin element
[sortMat,sortIdx] = sort(dMat',2,'ascend'); %Sort the distance matrix.
[i,matchRankNN]=find(sortIdx(:, 1:10) ==((1:M)'*ones(1,M)));  %Find the rank of the true match. Pefmect is all 1s.
cmcCCA_NN = cumsum(hist(matchRankNN, 1:M))/M;              %Generate the CMC curve of the matching.
erNN1  = mean(matchRankNN);
