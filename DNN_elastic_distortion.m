clear all;
tic
h = 28; w = 28;
a=10.0; b=30; c=7;
load('mnist_all.mat')
Xa=zeros(10,784);

Xa(1,:) = reshape(reshape(train0(1,:),h,w)', 1, h*w);
Xa(2,:) = reshape(reshape(train1(1,:),h,w)', 1, h*w);
Xa(3,:) = reshape(reshape(train2(1,:),h,w)', 1, h*w);
Xa(4,:) = reshape(reshape(train3(1,:),h,w)', 1, h*w);
Xa(5,:) = reshape(reshape(train4(1,:),h,w)', 1, h*w);
Xa(6,:) = reshape(reshape(train5(1,:),h,w)', 1, h*w);
Xa(7,:) = reshape(reshape(train6(1,:),h,w)', 1, h*w);
Xa(8,:) = reshape(reshape(train7(1,:),h,w)', 1, h*w);
Xa(9,:) = reshape(reshape(train8(1,:),h,w)', 1, h*w);
Xa(10,:) = reshape(reshape(train9(1,:),h,w)', 1, h*w);

% x = reshape(reshape(train5(1,:),h,w)', 1, h*w);
% subplot(1,3,1);
% image(reshape(x,h,w), 'CDataMapping', 'scaled');
% colormap gray;

% parameter for elastic distortion
alpha = a;      % scaling factor
sigma = b;     % standard deviation for gaussian kernel
filter_size = c;  % filter size of gaussian kernel

j=10;     %quantity of added sample
a=zeros(h*w,j*10);
x1=zeros(h*w,j*10);
y1=zeros(h*w,j*10);
label=zeros(j*10);

for s=1:10
    for i=1:j
        [y, displ] = elastic_dist(Xa(s,:), h, w, alpha, sigma, filter_size);
        a(:,i+(s-1)*10)=y;
        x1(:,i+(s-1)*1)=displ(:,1);
        y1(:,i+(s-1)*1)=displ(:,1);
    end
end
for s=1:10
label1(1+j*(s-1):j*s,1)=s;
end


% subplot(1,3,2);
% X = [];
% Y = [];
% for i = 1:h
%     X = [X i*ones(1,h)];
% end
% for i = 1:w
%     Y = [Y 1:h];
% end
% 
% quiver(X', Y', x1(:,i), y1(:,i));
% xlim([1 28]);
% ylim([1 28]);



% subplot(1,3,3);
% image(reshape(y,h,w), 'CDataMapping', 'scaled')
% colormap gray;
% 
 a=uint8(a');

DNNtrain0=[train0;a(1:j,:)];
DNNtrain1=[train1;a(1+j:2*j,:)];
DNNtrain2=[train2;a(1+2*j:3*j,:)];
DNNtrain3=[train3;a(1+3*j:4*j,:)];
DNNtrain4=[train4;a(1+4*j:5*j,:)];
DNNtrain5=[train5;a(1+5*j:6*j,:)];
DNNtrain6=[train6;a(1+6*j:7*j,:)];
DNNtrain7=[train7;a(1+7*j:8*j,:)];
DNNtrain8=[train8;a(1+8*j:9*j,:)];
DNNtrain9=[train9;a(1+9*j:10*j,:)];
toc
% for k=1:j
% label2(1,1)='DNNtrain0';
% label2(k+j,1)='DNNtrain1';
% label2(k+2*j,1)='DNNtrain2';
% label2(k+3*j,1)='DNNtrain3';
% label2(k+4*j,1)='DNNtrain4';
% label2(k+5*j,1)='DNNtrain5';
% label2(k+6*j,1)='DNNtrain6';
% label2(k+7*j,1)='DNNtrain7';
% label2(k+8*j,1)='DNNtrain8';
% label2(k+9*j,1)='DNNtrain9';
% end
