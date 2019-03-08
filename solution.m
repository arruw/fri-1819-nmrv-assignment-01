pkg load image;

I1 = rand(200, 200);
I2 = imrotate(I1, 1, 'bicubic', 'crop');

%I1 = imread('disparity/cporta_left.png');
%I2 = imread('disparity/cporta_right.png');

[Ulk, Vlk] = lucaskanade(I1, I2, 3);

figure(1); clf;
hold on;
subplot(2, 2, 1); imshow(I1); title('Image 1');
subplot(2, 2, 2); imshow(I2); title('Image 2');
subplot(2, 2, 3); showflow(Ulk, Vlk, 'color'); title('Lucas-Kanade (color)');
subplot(2, 2, 4); showflow(Ulk, Vlk, 'field'); title('Lucas-Kanade (field)');

waitfor(gcf);

