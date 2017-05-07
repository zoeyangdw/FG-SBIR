%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocess images and sketches to 128*256 and retain their original
% aspect ratio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imgPath = '../Data/origin/original shoe image/';
sketchPath = '../Data/origin/original shoe sketch/';

img_res_Path = '../Data/Preprocess/image/';
if ~exist(img_res_Path, 'dir')
    mkdir(img_res_Path);
end

sketch_res_Path = '../Data/Preprocess/sketch/';
if ~exist(sketch_res_Path, 'dir')
    mkdir(sketch_res_Path);
end

WIDTH = 256;
HEIGHT = 128;

fileName = dir(strcat(imgPath,'*.jpg'));
numFile = length(fileName);
for i = 1:numFile
    tempFileName = fileName(i).name;
    imPath = [imgPath, tempFileName];
    im = imread(imPath);
    if ndims(im) < 3
        [h, w] = size(im);
        k = 1;
    else
        [h, w, k] = size(im);
    end
    
    if (h*WIDTH) > (w*HEIGHT)
        im_res = imresize(im, [HEIGHT, w*HEIGHT/h]);
    else
        im_res = imresize(im, [h*WEIGHT/w, WIDTH]);
    end
    
    if ndims(im_res) < 3
        [h, w] = size(im_res);
        k = 1;
    else
        [h, w, k] = size(im_res);
    end
    
    if (h*WIDTH) > (w*HEIGHT)
        pad = WIDTH - w;
        left_pad = floor(pad/2);
        right_pad = ceil(pad/2);
        im_final = [255*ones(h, left_pad, k), im_res, 255*ones(h, right_pad, k)];
    else
        pad = HEIGHT - h;
        top_pad = floor(pad/2);
        bot_pad = ceil(pad/2);
        im_final = [255*ones(top_pad, w, k), im_res, 255*ones(bot_pad, w, k)];
    end
    imwrite(im_final, [img_res_Path, tempFileName]);      
end
        
