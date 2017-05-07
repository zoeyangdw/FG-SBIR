clc;clear;
addPaths;

%%get detected bounding boxes and parts
imgPath = 'Data/Img&Anno/origin/original shoe image/';
%sketchPath = 'Data/Img&Anno/origin/original shoe sketch/';

HEIGHT = 64
fileName = dir(strcat(imgPath,'*.jpg'));
numFile = length(fileName);

Parts = cell(numFile, 1);
%Parts_Img = uint8(ones(numFile, 
Parts_Hog = cell(numFile, 1);

for i = 1:numFile
    tempFileName = fileName(i).name;
    imPath = [imgPath, tempFileName];
    im = imread(imPath);
    im_final = trans_img(im, 256, 128, 3, 64);
    %hog = vl_hog(single(im_final), 16, 'verbose', 'variant', 'dalaltriggs');
    bbox = SSDPM_detect(im_final);
    parts = cell(4,1);
%     parts_img = cell(4, 1);
    parts_hog = cell(4, 1);
    for j= 1:4
        box = bbox(j).bbox;
        x1 = box(1); x2 = box(3);
        y1 = box(2); y2 = box(4);
        parts{j} = [x1, x2, y1, y2];
        part_img = im_final(y1:y2,x1:x2,:);
        %imshow(part);
        parts_img = trans_img(part_img, 64, 128, 3);
        part_hog = vl_hog(single(parts_img), 16, 'verbose', 'variant', 'dalaltriggs');
        parts_hog{j} = part_hog(:);
        %imshow(parts{j});   
        %visualize bouding box
        %color = lines(4);
        %plot([x1 x1 x2 x2 x1], [y1 y2 y2 y1 y1], '--', 'LineWidth', 2, 'Color', color(j,:));   
    end
    Parts{i} = parts;
    Parts_Hog{i} = parts_hog;
end
save PBox Parts;
save PHOG Parts_Hog;

