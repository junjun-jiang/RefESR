function wei = mysolver(LR,allResults_j,wstar,lambda,up_scale)

allResults_j = reshape(allResults_j,[size(LR)*up_scale,size(allResults_j,2)]);

Y   = imresize(double(allResults_j),1/up_scale,'bicubic');
Y   = reshape(Y,[size(LR,1)*size(LR,2),size(Y,3)]);

LR = [LR(:);sqrt(lambda)*wstar];
Y = [Y;sqrt(lambda)*eye(size(Y,2))];

wei = solve_weights(Y,LR,size(Y,2));