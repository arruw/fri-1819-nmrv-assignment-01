function [U, V] = lucaskanade_pyramidal(I1, I2, n, Lm)
% I1 - first image matrix (grayscale)
% I2 - second image matrix (grayscale)
% n - size of the neighborhood (n x n)
% l - number of pyramid levels

U{1} = zeros(size(I1));
V{1} = U{1};
d = cat(2, [0 0],  fliplr(size(I1)));

% create image pyramid
IL1{1} = I1;
IL2{1} = I2;
for L = 2:Lm
    IL1{L} = imresize(IL1{L-1}, 0.5);
    IL2{L} = imresize(IL2{L-1}, 0.5);
end

% this can be parallelized
for L = Lm:-1:1

    % perform lucaskanade
    [UL, VL] = lucaskanade(IL1{L}, IL2{L}, n);

    % resize optical flow to original size
    UL = imcrop(imresize(UL, 2^(L-1)), d);
    VL = imcrop(imresize(VL, 2^(L-1)), d);

    % save results
    U{L} = UL ./ 2^(Lm - L + 1);
    V{L} = VL ./ 2^(Lm - L + 1);
end

% reduce results
for L = 2:Lm
    U{1} = U{1} + U{L}; 
    V{1} = V{1} + V{L}; 
end

U = U{1};
V = V{1};