function [H,F] = KNSC_Ncut(X, k, K, D, alpha, mu, num_iter_max)

%--------------------------------------------------------------------------------------------
% GDBNSCNCut: Random initialize two nonnegative matrices, update matrices using multiplicative
% update rules for KNSC-Ncut, output cluster indicator matrix and basis
%
% INPUT
%   X            : is the data matrix
%   k            : is the number of clusters
%   K            : is the kernel matrix
%   alpha        : trade-off parameter
%   mu           : orthogonality parameter
%   num_iter_max : number of update iterations
% 
% -------------------------------------------------------------------------------------------
% Dijana Tolic dtolic@irb.hr
% -------------------------------------------------------------------------
% ------------------

[p,n] = size(X);
H = rand(k,n); %clustering
F = rand(n,k); %basis

num_iter = 0;
while (num_iter < num_iter_max)  
    num_iter = num_iter + 1;
    
    H = H.*(alpha*F'*K*D^(-0.5) + mu*H )./(alpha*F'*K*F*H + mu*(H*H')*H );
    F = F.*(K*D^(-0.5)*H')./(K*F*H*H');   
end
