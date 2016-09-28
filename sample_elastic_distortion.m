clear all;

h = 28;
w = 28;
load('mnist_all.mat')

x = reshape(reshape(train5(1,:),h,w)', 1, h*w);

subplot(1,3,1);
image(reshape(x,h,w), 'CDataMapping', 'scaled');
colormap gray;

% parameter for elastic distortion
alpha = 10.0;      % scaling factor
sigma = 30.0;     % standard deviation for gaussian kernel
filter_size = 7;  % filter size of gaussian kernel
[y, displ] = elastic_dist(x, h, w, alpha, sigma, filter_size);

subplot(1,3,2);
X = [];
Y = [];
for i = 1:h
    X = [X i*ones(1,h)];
end
for i = 1:w
    Y = [Y 1:h];
end

quiver(X', Y', displ(:,1), displ(:,2));
xlim([1 28]);
ylim([1 28]);

subplot(1,3,3);
image(reshape(y,h,w), 'CDataMapping', 'scaled')
colormap gray;