function im_final = trans_img(img, width, height, k, HEIGHT)
if nargin < 5
  HEIGHT = 0;
end

if HEIGHT == 0
    if ndims(img) < 3
        [h, w] = size(img);
    else
        [h, w, k] = size(img);
    end 
    if (h*width) > (w*height)
        im_res = imresize(img, [height, w*height/h]);
    else
        im_res = imresize(img, [h*width/w, width]);
    end 
    if ndims(im_res) < 3
        [h, w] = size(im_res);
        k = 1;
    else
        [h, w, k] = size(im_res);
    end 
    if (h*width) > (w*height)
        pad = width - w;
        left_pad = floor(pad/2);
        right_pad = pad-left_pad;
        im_final = [255*ones(h, left_pad, k), im_res, 255*ones(h, right_pad, k)];
    else
        pad = height - h;
        top_pad = floor(pad/2);
        bot_pad = pad-top_pad;
        im_final = [uint8(255*ones(top_pad, w, k)); im_res; uint8(255*ones(bot_pad, w, k))];
        %imshow(im_final);
    end
else
    if k == 1
        [a,b] = find(img<255);
        leftmost = min(b);
        rightmost = max(b);
        topmost = min(a);
        bottommost = max(a);
        imBdBox = img(topmost:bottommost, leftmost:rightmost);
        %imshow(imBdBox);
        imBdBox_trans = imresize(imBdBox, [HEIGHT, (HEIGHT/(bottommost-topmost))*(rightmost-leftmost)]);
        trans_width = (HEIGHT/(bottommost-topmost))*(rightmost-leftmost);
        im_final = uint8(ones(height,width)*255);
        %im_final = ones(128,256)*255;
        im_final(floor((height-HEIGHT)/2+1):floor(height-(height-HEIGHT)/2), floor(height-trans_width/2):floor((height-trans_width/2))+trans_width)=imBdBox_trans;
        %imshow(im_final);
    else
        gray = rgb2gray(img);
        [a,b] = find(gray<255);
        leftmost = min(b);
        rightmost = max(b);
        topmost = min(a);
        bottommost = max(a);
        imBdBox = img(topmost:bottommost, leftmost:rightmost,:);
        %imshow(imBdBox);
        imBdBox_trans = imresize(imBdBox, [HEIGHT, (HEIGHT/(bottommost-topmost))*(rightmost-leftmost)]);
        trans_width = (HEIGHT/(bottommost-topmost))*(rightmost-leftmost);
        im_final = uint8(ones(height,width,k)*255);
        %im_final = ones(128,256)*255;
        im_final(floor((height-HEIGHT)/2+1):floor(height-(height-HEIGHT)/2), floor(height-trans_width/2):floor((height-trans_width/2))+trans_width, :)=imBdBox_trans;
        %imshow(im_final);
    end
end