pkg load image;

I1 = rand(200, 200);
I2 = imrotate(I1, 1, 'bicubic', 'crop');

%I1 = imread('disparity/cporta_left.png');
%I2 = imread('disparity/cporta_right.png');

[Ulk, Vlk] = lucaskanade(I1, I2, 3);
[Uhs, Vhs] = hornschunck(I1, I2, 0.5, 2000);

figure(1); clf;
%set(gcf, 'visible', 'off');
set(gcf, 'name', 'Exercise 01');
hold on;
subplot(3, 2, 1); imshow(I1); title('Image 1');
subplot(3, 2, 2); imshow(I2); title('Image 2');
subplot(3, 2, 3); showflow(Ulk, Vlk, 'color'); title('Lucas-Kanade (color)');
subplot(3, 2, 4); showflow(Ulk, Vlk, 'field'); title('Lucas-Kanade (field)');
subplot(3, 2, 5); showflow(Uhs, Vhs, 'color'); title('Horn-Schunck (color)');
subplot(3, 2, 6); showflow(Uhs, Vhs, 'field'); title('Horn-Schunck (field)');
hold off;
%saveas(gcf, 'results/exercise01_1.png');
waitfor(gcf);