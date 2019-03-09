warning('off');
pkg load image;
pkg load parallel;

%I1 = rand(200, 200);
%I2 = imrotate(I1, 1, 'bicubic', 'crop');

I1 = imread('./home/img-0010-1.png');
I2 = imread('./home/img-0010-2.png');

[Ulk, Vlk] = lucaskanade(I1, I2, 3);
[Ulkp, Vlkp] = lucaskanade_parallel_pyramidal(I1, I2, 3, 4);
% [Uhs, Vhs] = hornschunck(I1, I2, 0.5, 2000);

figure(1); clf;
%set(gcf, 'visible', 'off');
set(gcf, 'name', 'Exercise 01');
hold on;
subplot(4, 2, 1); imshow(I1); title('Image 1');
subplot(4, 2, 2); imshow(I2); title('Image 2');
subplot(4, 2, 3); showflow(Ulk, Vlk, 'color'); title('Lucas-Kanade (color)');
subplot(4, 2, 4); showflow(Ulk, Vlk, 'field'); title('Lucas-Kanade (field)');
subplot(4, 2, 5); showflow(Ulkp, Vlkp, 'color'); title('Lucas-Kanade Pyramid (color)');
subplot(4, 2, 6); showflow(Ulkp, Vlkp, 'field'); title('Lucas-Kanade Pyramid (field)');
% subplot(4, 2, 7); showflow(Uhs, Vhs, 'color'); title('Horn-Schunck (color)');
% subplot(4, 2, 8); showflow(Uhs, Vhs, 'field'); title('Horn-Schunck (field)');
hold off;
%saveas(gcf, 'results/exercise01_1.png');
waitfor(gcf);