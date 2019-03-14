function [U, V] = lucaskanade_parallel_pyramidal(I1, I2, n, Lm)
% I1 - first image matrix (grayscale)
% I2 - second image matrix (grayscale)
% n - size of the neighborhood (n x n)
% Lm - number of pyramid levels

crop = cat(2, [0 0],  fliplr(size(I1)));

% create image pyramid
IL1 = cell(1, Lm);
IL2 = cell(1, Lm);
IL1{1} = I1;
IL2{1} = I2;
for L = 2:Lm
    IL1{L} = imresize(IL1{L-1}, 0.5);
    IL2{L} = imresize(IL2{L-1}, 0.5);
end

% go up the pyramid & calculate LK optical flow on each leavel
parfor L = 1:Lm
       
    % perform lucaskanade
    [U{L}, V{L}] = lucaskanade(IL1{L}, IL2{L}, n);
    
    % resize to original size
    U{L} = imcrop(imresize(U{L} ./ 2^(Lm-L), 2^(L-1)), crop);
    V{L} = imcrop(imresize(V{L} ./ 2^(Lm-L), 2^(L-1)), crop);

end

% aggregate OP of each layer
for L = 2:Lm

    U{1} = U{1} + U{L};
    V{1} = V{1} + V{L};
end 

% return OF vectors
U = U{1};
V = V{1};