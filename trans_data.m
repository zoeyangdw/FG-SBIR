path = 'C:\Users\N550J\Desktop\final\ydw\Data\Img&Anno\origin\original shoe image\';
ext = '*.jpg';
dis = dir([path ext]);
names = {dis.name};

a = imread([path names{1}]);
images = uint8(zeros( length(names), size(a, 1), size(a, 2)));

for k = 1: length(names)
    name = [path names{k}];
    img = imread(name);
    images(k, : , : ) = img;
end
