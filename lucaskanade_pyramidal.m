function [U, V] = lucaskanade_parallel_pyramidal(I1, I2, n, l)
% I1 - first image matrix (grayscale)
% I2 - second image matrix (grayscale)
% n - size of the neighborhood (n x n)
% l - number of pyramid levels

U = V = cell(1, l);
d = cat(2, [0 0],  fliplr(size(I1)));

% create image pyramid
Il1{1} = I1;
Il2{1} = I2;
for li = 2:l
    Il1{li} = imresize(Il1{li-1}, 0.5);
    Il2{li} = imresize(Il2{li-1}, 0.5);
endfor

% this can be parallelized
for li = 1:l

    % get the image at layer li
    Ili1 = Il1{li};
    Ili2 = Il2{li};

    % calculate LK
    [Uli, Vli] = lucaskanade(Ili1, Ili2, n);

    % resize to original size
    li2 = 2^(li-1);
    Uli = imcrop(imresize(Uli, li2), d);
    Vli = imcrop(imresize(Vli, li2), d);

    % save results
    % TODO: are this weight correct?
    U{li} = Uli ./ 2^(l-li);
    V{li} = Vli ./ 2^(l-li);
endfor

% reduce results
for li = 2:l
    U{1} = U{1} + U{li}; 
    V{1} = V{1} + V{li}; 
endfor

U = U{1};
V = V{1};