function [U, V] = lucaskanade(I1, I2, n)

[I1x, I1y] = gaussderiv(I1, 1);
[I2x, I2y] = gaussderiv(I2, 1);
Ix = 1/2 .* (I1x + I2x);
Iy = 1/2 .* (I1y + I2y);
It = gausssmooth(I2 - I1, 1.0);

Ixt = Ix.*It;
Iyt = Iy.*It;
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;

u = ones(3);
D = conv2(Ix2, u, 'same') .* \
    conv2(Iy2, u, 'same') .- \
    conv2(Ixy, u, 'same').^2;

U = (((conv2(Iy2, u, 'same') .* \
    conv2(Ixt, u, 'same')) .- \
    (conv2(Ixy, u, 'same') .* \
    conv2(Iyt, u, 'same'))) ./ D) .* -1;

V = (((conv2(Ix2, u, 'same') .* \
    conv2(Iyt, u, 'same')) .- \
    (conv2(Ixy, u, 'same') .* \
    conv2(Ixt, u, 'same'))) ./ D) .* -1;