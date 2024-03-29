function [U, V] = hornschunck(I1, I2, lambda, iterations)
% I1 - first image matrix (grayscale)
% I2 - second image matrix (grayscale)
% lambda - parameter
% iterations - number of iterations (try several hundred)

% Laplacian kernel
Ld = [0 .25 0; .25 0 .25; 0 .25 0];

[I1x, I1y] = gaussderiv(I1, 1);
[I2x, I2y] = gaussderiv(I2, 1);
Ix = 1/2 .* (I1x + I2x);
Iy = 1/2 .* (I1y + I2y);
It = gausssmooth(I2 - I1, 1.0);

Ix2 = Ix.^2;
Iy2 = Iy.^2;

U = zeros(size(I1));
V = U;

D = lambda + Ix2 + Iy2;

for i = 1:iterations
    ua = conv2(U, Ld, 'same');
    va = conv2(V, Ld, 'same');

    P = Ix .* ua + Iy .* va + It;

    U = ua - Ix .* (P ./ D);
    V = va - Iy .* (P ./ D);
end

U(isinf(U)|isnan(U)) = 0;
V(isinf(V)|isnan(V)) = 0;