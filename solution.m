I1 = rand(1000, 1000);
I2 = imrotate(I1, 1, 'bicubic', 'crop');

% I1 = imread('./resources/disparity/office2_left.png');
% I2 = imread('./resources/disparity/office2_right.png');

% I1 = imread('./resources/disparity/office_left.png');
% I2 = imread('./resources/disparity/office_right.png');

% I1 = imread('./resources/disparity/cporta_left.png');
% I2 = imread('./resources/disparity/cporta_right.png');

% I1 = imread('./resources/collision/00000151.jpg');
% I2 = imread('./resources/collision/00000171.jpg');

[Ulk, Vlk] = lucaskanade(I1, I2, 3);
[Ulkp, Vlkp] = lucaskanade_pyramidal(I1, I2, 3, 4);
[Ulkpp, Vlkpp] = lucaskanade_parallel_pyramidal(I1, I2, 3, 4);
[Uhs, Vhs] = hornschunck(I1, I2, 0.5, 2000);
[Uhsp, Vhsp] = hornschunck_pyramidal(I1, I2, 0.5, 2000, 4);


figure(1); clf;
set(gcf, 'name', 'Exercise 01');
hold on;

subplot(3, 3, 1);   imshow(I1);                     title('Image 1');
subplot(3, 3, 2);   imshow(I2);                     title('Image 2');

subplot(3, 3, 4);   showflow(Ulk, Vlk, 'color');    title('Lucas-Kanade (color)');
subplot(3, 3, 5);   showflow(Ulkp, Vlkp, 'color');  title('Lucas-Kanade Pyramid (color)');
subplot(3, 3, 6);   showflow(Ulkpp, Vlkpp, 'color');  title('Lucas-Kanade Parallel Pyramid (color)');

subplot(3, 3, 7);   showflow(Uhs, Vhs, 'color');    title('Horn-Schunck (color)');
subplot(3, 3, 8);   showflow(Uhsp, Vhsp, 'color');  title('Horn-Schunck Pyramid (color)');

hold off;
waitfor(gcf);