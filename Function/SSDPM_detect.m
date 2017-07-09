function bbox = SSDPM_detect(im)
addPaths;
% dataset year
year = '001';

% animal class, can be from {bird, cat, cow, dog, horse, or sheep}
cls = 'shoe';
% load the model
load(['Data/DPMs/model_' cls year '_C3.mat']);
%load('C:\Users\N550J\Desktop\final\ydw\Data\DPMs\model_shoe001_C3.mat')
%predict_num = zeros(1,4);
% load an image
thresh = -1.5;
color = lines(4);

[dets, boxes, info] = imgdetect(im, model, thresh);
bbox = gt_bgf_bbox(model,im,boxes);
% imshow(im);
% for i= 1:4
%     box = bbox(i).bbox;
%     hold on;
%     x1 = box(1); x2 = box(3);
%     y1 = box(2); y2 = box(4);
%     plot([x1 x1 x2 x2 x1], [y1 y2 y2 y1 y1],  'LineWidth', 1.5, 'Color', color(i,:));
%     
% end
% hold off;
