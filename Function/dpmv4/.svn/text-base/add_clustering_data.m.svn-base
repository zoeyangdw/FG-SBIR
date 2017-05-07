function pos = add_clustering_data(pos)

for p = 1 : length(pos)
   width = pos(p).x2 - pos(p).x1;
   x1 = pos(p).x1;
   y1 = pos(p).y1;
   x2 = pos(p).x2;
   y2 = pos(p).y2;
   pos(p).ratio = (pos(p).y2 - pos(p).y1) / width;
   for pa = 1 : length(pos(p).parts)
       if pos(p).parts(pa).present
        pos(p).parts(pa).rx1 = (pos(p).parts(pa).bbox(1) - x1) / width;
        pos(p).parts(pa).rx1_m = (x2 - pos(p).parts(pa).bbox(3)) / width;
        pos(p).parts(pa).ry1 = (pos(p).parts(pa).bbox(2) - y1) / width;
        pos(p).parts(pa).scale = (pos(p).parts(pa).bbox(3) - pos(p).parts(pa).bbox(1)) / width;
        pos(p).parts(pa).ratio = (pos(p).parts(pa).bbox(4) - pos(p).parts(pa).bbox(2)) / (pos(p).parts(pa).bbox(3) - pos(p).parts(pa).bbox(1));
       end
   end
end