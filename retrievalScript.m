clc;clear;
addPaths;
%300, 278, 265, 257, 200, 195
im = imread('Data/Img&Anno/origin/original shoe sketch/195-1.jpg');
right = imread('Data/Img&Anno/origin/Image/195.jpg');
load PCAs_Sketch.mat;
load SVMs_Sketch.mat;
img_low = getfield(load('Image_Low.mat'), 'low');
img_mid = getfield(load('Image_Mid.mat'), 'mid');
img_high = getfield(load('Image_High.mat'), 'high');
low = [ ];
mid = [ ] ;
high = zeros(1, 13);
centers = zeros(4, 2);
im_final = trans_img(im, 256, 128, 1, 64);
[m, n] = size(im_final);
bbox = SSDPM_detect(im_final);
for j= 1:4
   box = bbox(j).bbox;
    x1 = box(1); x2 = box(3);
    y1 = box(2); y2 = box(4);
    if x1 < 1
         x1 = 1;
     end
     if x2 > n
         x = n;
     end
     if y1 < 1
         y1 = 1;
     end
     if y2 > m
          y2 = m;
     end     
    part_img = im_final(y1:y2,x1:x2);
    parts_img = trans_img(part_img, 64, 128, 1);
    part_hog = vl_hog(single(parts_img), 16, 'verbose', 'variant', 'dalaltriggs');
    pca = squeeze(pcas(j,:,:));
    hog = part_hog(:)';
    hog = double(hog*pca);
    low = [low, hog];
    centers(j,1) = (x1+x2)/2;
    centers(j, 2) = (y1+y2)/2;
    switch j 
        case 1
            for k = 5:10
                model = svms_sketch(k);
                label = 0;
                [predict_label] = svmpredict(label, hog, model);
                high(k) = predict_label;
            end
        case 2
             for k = 1:2
                model = svms_sketch(k);
                label = 0;
                [predict_label] = svmpredict(label, hog, model);
                high(k) = predict_label;
             end
        case 3
            for k = 11:13
                model = svms_sketch(k);
                label = 0;
                [predict_label] = svmpredict(label, hog, model);
                high(k) = predict_label;
            end
        case 4
            for k = 3:4
                model = svms_sketch(k);
                label = 0;
                [predict_label] = svmpredict(label, hog, model);
                high(k) = predict_label;
             end
    end
end

for i = 1: 4
    for j = i+1: 4
        if i ~= j
            mid = [mid, norm(centers(i, :)-centers(j, :))];
        end
    end
end
mid = mid / sqrt(sum(mid.*mid));

val_X = [img_low, img_mid, img_high];
val_X1 = [low, mid, high];
all_X = [val_X; val_X1];
index = [ones(1000,1);ones(6,1)*1;ones(13,1)*2];
[V, D] = MultiviewCCA(all_X, index, 0.1); 
D = D^2;
P = val_X*V*D;
P1 = val_X1*V*D;

dMat = pdist2(P,P1);
[sortMat,sortIdx] = sort(dMat',2,'ascend'); %Sort the distance matrix.
subplot(2,4,1);
imshow(im); title('查询草图', 'FontSize', 15);
subplot(2,4,2);
imshow(right);title('正确图像', 'FontSize', 15);
for i = 1:4
    impath = ['Data/Img&Anno/origin/Image/', num2str(sortIdx(i)), '.jpg'];
    img = imread(impath);
    subplot(2,4, i+4);
    imshow(img); title(['排名' num2str(i)], 'FontSize', 15);
end
