function [U, V] = lucaskanade_parallel_pyramidal(I1, I2, n, l)
% I1 - first image matrix (grayscale)
% I2 - second image matrix (grayscale)
% n - size of the neighborhood (n x n)
% l - number of pyramid levels

% create image pyramid
Il1{1} = I1;
Il2{1} = I2;
nc{1} = n;
lc{1} = l;
lic{1} = 1;
dc{1} = cat(2, [0 0], fliplr(size(I1)));
for li = 2:l
    Il1{li} = imresize(Il1{li-1}, 0.5);
    Il2{li} = imresize(Il2{li-1}, 0.5);
    nc{li} = nc{li-1};
    lc{li} = lc{li-1};
    lic{li} = li;
    dc{li} = dc{li-1};
endfor

[U, V] = parcellfun(nproc, @lk_layer, Il1, Il2, nc, lc, lic, dc);

% reduce results
for li = 2:l
    U{1} = U{1} + U{li}; 
    V{1} = V{1} + V{li}; 
endfor

U = U{1};
V = V{1};