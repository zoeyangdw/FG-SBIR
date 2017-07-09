clc;clear;
addPaths;

load new_pos_304.mat
num = length(pos2);
Parts = cell(num, 1);
Parts_Hog = cell(num, 1);

for i= 1:num
    parts = cell (4,1);
    pos = pos2(i);
    filename = getfield(pos, 'im');
    [name, a] = strtok(filename, '.');
    name = str2double(name);
    path = ['Data/Img&Anno/origin/Image/', filename];
    im = imread(path);
    img = trans_image(im);
    imshow(img);
    parts = cell(4,1);
    parts_hog = cell(4,1);
    bbox = getfield(pos, 'parts');
    for j = 1:4
        box = bbox(j).bbox;
        x1 = box(1);
        y1 = box(2);
        x2 = box(3);
        y2 = box(4);
         hold on;
         plot([x1 x1 x2 x2 x1], [y1 y2 y2 y1 y1], '--', 'LineWidth', 2);
         if j == 3 || j == 4
             j = 7-j;
         end
        parts{j} = [x1, x2, y1, y2];
        part_img = img(y1:y2,x1:x2,:);
       % imshow(part_img);
        parts_img = trans_img(part_img, 64, 128, 3);
        part_hog = vl_hog(single(parts_img), 16, 'verbose', 'variant', 'dalaltriggs');
        parts_hog{j} = part_hog(:);
    end
    hold off;
    Parts{name} = parts;
    Parts_Hog{name} = parts_hog;
end

save PBox_Image Parts;
save PHOG_Image Parts_Hog;
