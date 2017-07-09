clc;clear;
addPaths;

%%get detected bounding boxes and parts
imgPath = 'Data/Img&Anno/origin/original shoe sketch/';
%sketchPath = 'Data/Img&Anno/origin/original shoe sketch/';

HEIGHT = 64;
fileNamePre = dir(strcat(imgPath,'*.jpg'));
numFile = length(fileNamePre);
fileName = cell(numFile,1);
for j = 1:numFile/3
    fileName{j} = fileNamePre((j-1)*3+1).name;
    fileName{j+304} = fileNamePre((j-1)*3+2).name;
    fileName{j+608} = fileNamePre((j-1)*3+3).name;
end

Parts = cell(numFile, 1);
%Parts_Img = uint8(ones(numFile, 
Parts_Hog = cell(numFile, 1);

for i = 1:numFile
    disp( i );
    i = 2;
    tempFileName = fileName{i};
    imPath = [imgPath, tempFileName];
    im = imread(imPath);
    imshow(im);
    im_final = trans_img(im, 256, 128, 1, 64);
    imwrite(im_final,'result.jpg');
    %im_final = trans_img(im, 256, 128, 3, 64);
    [m, n] = size(im_final);
    bbox = SSDPM_detect(im_final);
    parts = cell(4,1);
    parts_img = cell(4, 1);
    parts_hog = cell(4, 1);
    for j= 1:4
        box = bbox(j).bbox;
        x1 = box(1); x2 = box(3);
        y1 = box(2); y2 = box(4);
        parts{j} = [x1, x2, y1, y2];
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
         
        %part_img = im_final(y1:y2,x1:x2,:);
        part_img = im_final(y1:y2,x1:x2);
        parts_img = trans_img(part_img, 64, 128, 1);
        imshow(parts_img);
        part_hog = vl_hog(single(parts_img), 16, 'verbose', 'variant', 'dalaltriggs');
        imhog = vl_hog('render', part_hog, 'verbose', 'variant', 'dalaltriggs') ;
        imshow(imhog);
        parts_hog{j} = part_hog(:);
%        imshow(parts_img);   
%         %visualize bouding box
%         %color = lines(4);
%         %plot([x1 x1 x2 x2 x1], [y1 y2 y2 y1 y1], '--', 'LineWidth', 2, 'Color', color(j,:));   
    end
    Parts{i} = parts;
    Parts_Hog{i} = parts_hog;
 end
save PBox_Sketch Parts;
save PHOG_Sketch Parts_Hog;

