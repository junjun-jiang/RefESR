%% This code is for the following work
%% J. Jiang, Y. Yu, Z. Wang, S. Tang, J. Ma, ¡°Ensemble Super-Resolution with 
%% A Reference Dataset,¡± IEEE Transactions on Cybernetics, DOI: 10.1109/TCYB.2018.2890149, 2018.
%% If you have problems, please contact me: jiangjunjun@hit.edu.cn, junjun0595@163.com

clc;clear;close all;
addpath('includes');

Test_file = {'baby_GT','bird_GT','butterfly_GT','head_GT','woman_GT'};
up_scale  = 4;
rho       = 0.07;
lambda    = 0.8;
scores    = [28.77,29.27,29.34,29.36,29.29]';

%% load the results of different methods
for j = 1:length(Test_file)
    im           = imread(['.\Set5\Methods_x4\' Test_file{j} '.bmp']);
    Results{1,j} = modcrop(im, up_scale);
    Results{2,j} = double(imread(['.\Set5\Set5_SR\img_' char(sprintf('%03d',j)) '_SRF' '_4' '_SelfExSR.png']));    
    Results{3,j} = double(imread(['.\' 'Set5' '\Methods_' 'x4\' Test_file{j} '[10-Our IA].bmp'])); 
    Results{4,j} = imread(['.\Set5\VDSR_' 'Set5' '_x4\' Test_file{j} '.png']);
    Results{5,j} = imread(['.\Set5\DRCN_' 'Set5' '_x4\' Test_file{j} '.png']);      
    Results{6,j} = imread(['.\Set5\DnCNN_' 'Set5' '_x4\' Test_file{j} '_x4.png']);      
end

% crop the results to the same size
for j = 1:length(Test_file)    
    allresults = [];
    for i = 1:size(Results,1)-1
        if i==2
            temp =Results{i+1,j};
            [methods_psnr(i,j)] = compute_psnr(Results{1,j}(5:end-4,5:end-4,:),temp);   
        else
            temp = Results{i+1,j}(5:end-4,5:end-4,:);
            [methods_psnr(i,j)] = compute_psnr(Results{1,j}(5:end-4,5:end-4,:),temp);
        end
        
        if size(temp, 3) == 3,
            temp = rgb2ycbcr(temp);
            temp = temp(:, :, 1);
        end
        allresults = [allresults temp(:)];
    end
    allResults{1,j} = allresults;    
end
fprintf('The PSNR (dB) results of different methods:\n');
fprintf('SelfExSR: %.2f \n',mean(methods_psnr(1,:)));
fprintf('IA:       %.2f \n',mean(methods_psnr(2,:)));
fprintf('VDSR:     %.2f \n',mean(methods_psnr(3,:)));
fprintf('DRCN:     %.2f \n',mean(methods_psnr(4,:)));
fprintf('DnCNN:    %.2f \n',mean(methods_psnr(5,:)));

%% Ensemble reconstruction
Er=exp(-1*(max(scores)-scores).^2/rho^2);
wref = Er./sum(Er);

for j = 1:length(Test_file) 
    allResults_j = double(allResults{1,j});

    [row, col, ~] = size(Results{1,j}(5:end-4,5:end-4,:));

    HR = Results{1,j}(5:end-4,5:end-4,:);
    if size(HR, 3) == 3,
        HR = rgb2ycbcr(HR);
        HR = double(HR(:, :, 1));
    end
    LR = imresize(double(HR),1/up_scale);

    weis = mysolver(LR./255,allResults_j./255,wref,lambda,up_scale);
    weis = weis./sum(weis);

    im_SR = reshape(allResults_j*weis,row,col);

    [safe_mean_psnr2(j)] = compute_psnr(Results{1,j}(5:end-4,5:end-4,:),im_SR);  
end
fprintf('Our:      %.2f \n',mean(safe_mean_psnr2));