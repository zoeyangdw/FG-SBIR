function r= convall(feat, filters)
r={};
parfor i=1:length(filters)
    f = filters{i};
    r{i}=convn(feat,f(end:-1:1,end:-1:1,end:-1:1),'valid');
end
end