
% initialize the PASCAL development kit 
tmp = pwd;
cd(VOCdevkit);
VOCdevkit
pwd
if ~isdeployed
    addpath([cd '/VOCcode']);
else
    %addpath([VOCdevkit '/VOCcode']);
end
pwd
VOCinit;
VOCopts
cd(tmp);
