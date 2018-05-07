function [H,F] = KNSC_Rcut(X, k, K, alpha, mu, num_iter_max )

%--------------------------------------------------------------------------------------------
% Random initialize two nonnegative matrices, update matrices using multiplicative
% update rules for KNSC-Rcut, output cluster indicator matrix and basis.
%
% INPUT
%   X            : is the data matrix
%   k            : is the number of clusters
%   K            : is the kernel matrix
%   alpha        : trade-off parameter
%   mu           : orthogonality parameter 
%   num_iter_max : number of update iterations
%   
% 
% -------------------------------------------------------------------------------------------
% Dijana Tolic dtolic@irb.hr 
% -------------------------------------------------------------------------------------------

[p,n] = size(X);
H = rand(k,n);
F = rand(n,k);

num_iter = 0;
while (num_iter < num_iter_max) 
    num_iter = num_iter + 1;
   
    H = H.*(alpha*F'*K + mu*H )./(alpha*F'*K*F*H +  mu*(H*H')*H );
    F = F.*(K*H')./(K*F*H*(H'));
end
