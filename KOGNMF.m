function [H,F] = KOGNMF(X, k, K, alpha, mu, lambda, A, num_iter_max)

%--------------------------------------------------------------------------------------------
% GDBNSCNCut: Random initialize two nonnegative matrices, update matrices using multiplicative
% update rules for KOGNMF, output cluster indicator matrix and basis. 
%
% INPUT
%   X            : is the data matrix
%   k            : is the number of clusters
%   K            : is the kernel matrix
%   alpha        : trade-off parameter
%   mu           : orthogonality parameter 
%   lambda       : graph regularization parameter (controls the smoothnes of the new 
%                 representation)
%   A            : affinity graphs
%   num_iter_max : number of update iterations
%   
% 
% -------------------------------------------------------------------------------------------
% Dijana Tolic dtolic@irb.hr
% -------------------------------------------------------------------------
% ------------------

[p,n] = size(X);
H = rand(k,n); %clustering
F = rand(n,k); %basis

num_iter = 0;

if (exist('A','var')==0) % A is missing
    A = zeros(size(K));
end
v = sum(A,2);
D_A = diag(v); 

while (num_iter < num_iter_max) 
    num_iter = num_iter + 1;
    H = H.*(alpha*F'*K + mu*H + lambda*H*A)./(alpha*F'*K*F*H + mu*(H*H')*H + lambda*H*D_A);
    F = F.*(K*H')./(K*F*H*H');
end
