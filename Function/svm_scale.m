function data = svm_scale(feature)
data = (feature - repmat(min(feature,[],1),size(feature,1),1))*spdiags(1./(max(feature,[],1)-min(feature,[],1))',0,size(feature,2),size(feature,2));