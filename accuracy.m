function score = accuracy(true_labels, cluster_labels)
% ACCURACY Compute clustering accuracy using the true and cluster labels and
%   return the value in 'score'.
%
%   Input  : true_labels    : N-by-1 vector containing true labels
%            cluster_labels : N-by-1 vector containing cluster labels
%
%   Output : score          : clustering accuracy

% Compute the confusion matrix 'cmat', where
%   col index is for true label (CAT),
%   row index is for cluster label (CLS).
n = length(true_labels);
% true_labels'
% cluster_labels

 %whos true_labels
 %whos cluster_labels
cat = spconvert([(1:n)' true_labels ones(n,1)]);
cls = spconvert([(1:n)' cluster_labels ones(n,1)]);
cls = cls';
cmat = full(cls * cat);

%fix - if cmat is not rectangal -> some labels are missing
if ( size(cmat,1) ~= size(cmat,2) )
    if (size(cmat,1)>size(cmat,2))
        cmat = [cmat zeros(size(cmat,1), size(cmat,1)- size(cmat,2)) ]; %add empty columns
    else
        cmat = [cmat; zeros(size(cmat,2)- size(cmat,1), size(cmat,2) ) ]; %add empty columns
    end
end

%
% Calculate accuracy
%
[match, cost] = hungarian(-cmat);
score = 100*(-cost/n);

