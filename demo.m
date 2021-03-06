clc;clear;
addPaths;
%addpath(genpath('../Functions'));
%load('/Users/kaiyue/Dropbox/Academic_shared/cvpr2016_tf/shoes_sketch_db_val.mat');
temp = imread('C:\Users\N550J\Desktop\final\FG-SBIR\Data\Img&Anno\origin\Sketch\089-3.jpg');
%temp = squeeze(data(72,:,:));
temp(find(temp>245))=255;
[a,b] = find(temp<255);
leftmost = min(b);
rightmost = max(b);
topmost = min(a);
bottommost = max(a);
imBdBox = temp(topmost:bottommost, leftmost:rightmost);
%imshow(imBdBox);
% 
imBdBox_trans = imresize(imBdBox, [64, (64/(bottommost-topmost))*(rightmost-leftmost)]);
trans_width = floor((64/(bottommost-topmost))*(rightmost-leftmost));
im_final = uint8(ones(128,256)*255);
%im_final = ones(128,256)*255;
im_final(33:96, floor(128-trans_width/2):floor((128-trans_width/2))+trans_width)=imBdBox_trans;
%im_final = trans_img(temp, 256, 128, 1, 64);
% im_final = trans_img(im_final, 256, 128, 1, 64);
bbox = SSDPM_detect(im_final);