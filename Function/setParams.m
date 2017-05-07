function setParams(inparams)
global params
%params = [];
if nargin == 1
    params = inparams;
end

if ~isfield(params, 'cls')
    params.cls = 'cow';		% change the default value of the PASCAL VOC class
end
if ~isfield(params, 'year')
    params.year = '2010';	% change the default value of the PASCAL VOC year
end

%params.vocdevkit_path = ['/home/hossein/codes/LSVM-NEW/voc-release4/VOC' params.year '/']; % where to look for annotations and images -- change on different machines --
params.vocdevkit_path = '/Users/kaiyue.pang/Desktop/data/'; % where to look for annotations and images -- change on different machines --
params.cachedir = ['../cache/' params.cls '_' params.year ]; % where we save intermediate files
mkdir(params.cachedir);
params.annodir = ['../data/VOC' params.year '/' params.cls params.year '_anno/']; % where the annotation xml files are located, these files are in the same format as the PASCAL VOC but have additional annotation for parts, do not change if you get the whole package and are using our annotation

params.FAST_RUN = false;        % if true, it runs with lowest number of training data and less iterations to check the code as fast as possible

if ~isfield(params, 'C')
    params.C = 5;               % number of clusters
end
if ~isfield(params, 'W')
    params.W = 1;               % weight of aspect ratio during clustering
end

params.KMEANS_TRIALS = 100; 	% number of trials for pose clustering using the modified kmeans clustering

params.VISIBILITY_THRESH = 0.3; % any part which appears in more than VISIBILITY_THRESH * 100% of a cluster will be assigned a filter in the corresponding mixture 
params.MIN_PART_OVERLAP = 0.3;	% minimum tolerance on the agreement between the GT part annotation and the filter position, be aware a low amount will discard many positive samples since there will be no configuration possible to respect the overlap (e.g. because of different aspect ratio, etc.)
params.USE_ORIG_PARTS = false;	% if true, in addition to the annotated it will find and use automatic parts using the same heuristic as Felzenszwalb. et. al. vocrelease4.1 code

rng('default');
