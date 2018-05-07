function K = gausskernel(X, Y, sig)
% 
% Calculate Gaussian kernel for matrices with parameter sigma.
% 
%   K(i,j) = exp( ||X1(:,i) - X2(:,j)||^2 / (2*sig^2) )
% 
% INPUT
%   X1      : DxN1 matrix, each column is a sample
%   X2      : DxN2 matrix, each column is a sample
%   sig     : parameter sigma for Gaussian kernel
% 
% OUTPUT
%   K       : N1xN2 kernel matrix
%
%


% *************************************************************************
%   CHECK INPUTS
% *************************************************************************

% Check number of rows for X and Y.
RowX = size(X,1);
RowY = size(Y,1);

if(RowX~=RowY)
    error('Input matrices X and Y must have same number of rows!');
end

% Check sigma
if(sig<=0)
    error('Parameter C must be positive (not zero or negative).')
end

% *************************************************************************
%   CALCULATIONS
% *************************************************************************

normX = sum(X.^2,1);
normY = sum(Y.^2,1);

K = bsxfun( @minus, normX', 2*(X'*Y) );
K = bsxfun( @plus, normY, K );
K = exp( -K / (2*sig^2) );




