

clear;
clc;

% ---------- load and visualize data ----------------------


load synthetic_data6.mat

g = figure;
subplot(211);
hold on;
dotsize = 14;
colors = [1,0,0;
        0,0,1;
        0,0,0
        0,1,0;];
C = zeros(3,size(ground_truth,1));
for i = 1 : size(ground_truth,1)
   C(:,i) = colors(ground_truth(i),:);
end
scatter(X(1,:), X(2,:), dotsize, C', 'SizeData', dotsize); axis equal;
title('Original data');
disp('Corners');
box on


% --------------- run algorithm KNSC-Ncut -----------------

%parameters
mu = 100;
alpha = 10;
lambda = 0;

sigma = 5; %ACC = 90.0938

K = gausskernel(X,X,sigma);
v = sum(K,2);
D = diag(v); 

% call clustering algorithm with 300 iteration
[H,W] =  KNSC_Ncut(X, k, K, D, alpha, mu, 300);

% obtain cluster memberships
[val,IDX] = max(H);
     
disp('accuracy');
[ACCMAX_kernel] = accuracy(ground_truth, IDX');
disp(ACCMAX_kernel);

% plot clusterin results
subplot(212);
C = zeros(3,size(IDX,2));
for i = 1 : size(IDX,2)
   C(:,i) = colors(IDX(i),:);
end
scatter(X(1,:), X(2,:), dotsize, C'); axis equal;
title('Clustering results: KSNC-Ncut');
box on
