function [predict_dpm]=gt_bgf_bbox(model, im, bbox,mask, mode)

% visualizes a detection (including parts) on an image, compatible with occlusion
% filters
% model         model used for detection to access the connections
% im            image the detection was done on
% bbox          the parts bbox output of the detection function

if nargin<4
    mode = 0;
    C = length(model.rules{model.start});
    ind = C+1;
    mask = zeros(model.numfilters, 1);
    for i = C * 4 + 5 : 8 : size(bbox, 2) - 4
        if sum(bbox(1, i:i+3))
            bbox(1,i-4:i-1) = bbox(1,i:i+3);
            bbox(1,i:i+3) = 0;
            mask(ind) = 1;
        end
        ind = ind + 2;
    end
end




%load('colors.mat');
colors = lines;

ps = zeros(1000, 1);
cs = zeros(1000, 1);

for c = 1 : length(model.rules{model.start})
    [pps ccs] = gt_getConnectivities(model, model.start, c);
    ps = ps + pps;
    cs = cs + ccs;
end

width = size(im, 2);


xs=[];
ys=[];

if size(bbox, 1)
    for i = 1 : 4 : size(bbox, 2) - 4
        if sum(bbox(1, i:i+3))
            fNum = (i - 1) / 4 + 1;
            parent = ps(fNum);
            %fNum
            %parent
            x1 = bbox(1, i);
            x2 = bbox(1, i + 2);
            y1 = bbox(1, i + 1);
            y2 = bbox(1, i + 3);            
            xc = (bbox(1, i) + bbox(1, i + 2)) / 2;
            yc = (bbox(1, i + 1) + bbox(1, i + 3)) / 2;
            xs(fNum) = xc;
            ys(fNum) = yc;
%            filledCircle([xc yc], width / 70, 100, colors(cs(fNum), :));
%            line([xc xs(parent)], [yc ys(parent)], 'LineWidth', width / 100, 'Color', 'b');
            %if mode == 0
            %line([xc xs(parent)], [yc ys(parent)], 'LineWidth', 6, 'Color', 'b');
                %line([xc xs(parent)], [yc ys(parent)], 'LineWidth', 4, 'Color', 'b');
            if mode == 1
                %filledCircle([xc yc], 6, 100, colors(cs(fNum), :));
                %filledCircle([xc yc], 3, 100, colors(cs(fNum), :));
                if ~mask(fNum)
                    %plot([x1 x1 x2 x2 x1], [y1 y2 y2 y1 y1], 'LineWidth', 2, 'Color', colors(cs(fNum), :));
                    if cs(fNum)>1
                        predict_dpm(cs(fNum)-1).bbox = [x1 y1 x2 y2];
                    end
                else
                    %plot([x1 x1 x2 x2 x1], [y1 y2 y2 y1 y1], '--', 'LineWidth', 2, 'Color', colors(cs(fNum), :));
                    if cs(fNum)>1
                        predict_dpm(cs(fNum)-1).bbox = [x1 y1 x2 y2];
                    end
                end
            end
        end
    end
end

if mode == 0
    [predict_dpm]=gt_bgf_bbox(model, im, bbox, mask, 1);
else
    return;
end




