% M = 3;
%  a = (1:M)'*ones(1,M);
% A = [ 2, 1, 3;
%           2, 4, 1;
%           5, 3, 6];
% [B, c] = sort(A, 2);
% 
%  [i,j]=find(c==((1:3)'*ones(1,3))); 
%  cmcCCA_NN = cumsum(hist(j, 1:3))/3;
% 
% A = [ 2, 1, 3;
%           2, 4, 1;
%           5, 3, 6]; 
%  B = [ 1, 1, 4;
%           2, 5, 6;
%           8, 9, 6]; 
% [i, j] = find(A == B);
%  
% C = ones(4,3);
%  a = size(C);
% B = [ 2, 1, 3];
% dMat = pdist2(A,B);

A = [ 2, 1, 3;
          2, 4, 1;
          5, 3, 6]; 
B = [1, 0, 0;
        0, 1, 0];
d= pdist2(A, B);
      