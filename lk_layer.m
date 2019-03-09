function [U, V] = lk_layer(I1, I2, n, l, li, d)
% I1 - first image matrix (grayscale)
% I2 - second image matrix (grayscale)
% n - size of the neighborhood (n x n)
% l - number of layers
% li - layer number
% d - crop dimensions

% disp(strcat(
%     ' li=', num2str(li),
%     ' I1=', mat2str(size(I1)),
%     ' I2=', mat2str(size(I2)),
%     ' d=', mat2str(d),
%     ' n=', num2str(n),
%     ' l=', num2str(l)
% ))

U{1} = V{1} = zeros(d(3:4));

% calculate LK
[Uli, Vli] = lucaskanade(I1, I2, n);

% resize to original size
li2 = 2^(li-1);
Uli = imcrop(imresize(Uli, li2), d);
Vli = imcrop(imresize(Vli, li2), d);

% save results
% TODO: are this weight correct?
U{1} = Uli ./ 2^(l-li);
V{1} = Vli ./ 2^(l-li);
    