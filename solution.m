I1 = rand(1000, 1000);
I2 = imrotate(I1, 1, 'bicubic', 'crop');

% I1 = imread('./disparity/office2_left.png');
% I2 = imread('./disparity/office2_right.png');

% I1 = imread('./disparity/cporta_left.png');
% I2 = imread('./disparity/cporta_right.png');

% I1 = imread('./collision/00000001.jpg');
% I2 = imread('./collision/00000002.jpg');

[Ulk, Vlk] = lucaskanade(I1, I2, 3);
[Ulkp, Vlkp] = lucaskanade_pyramidal(I1, I2, 3, 4);
[Uhs, Vhs] = hornschunck(I1, I2, 0.5, 2000);
[Uhsp, Vhsp] = hornschunck_pyramidal(I1, I2, 0.5, 2000, 4);

figure(1); clf;
%set(gcf, 'visible', 'off');
set(gcf, 'name', 'Exercise 01');
hold on;
subplot(5, 2, 1);   imshow(I1);                     title('Image 1');
subplot(5, 2, 2);   imshow(I2);                     title('Image 2');
subplot(5, 2, 3);   showflow(Ulk, Vlk, 'color');    title('Lucas-Kanade (color)');
subplot(5, 2, 4);   showflow(Ulk, Vlk, 'field');    title('Lucas-Kanade (field)');
subplot(5, 2, 5);   showflow(Ulkp, Vlkp, 'color');  title('Lucas-Kanade Pyramid (color)');
subplot(5, 2, 6);   showflow(Ulkp, Vlkp, 'field');  title('Lucas-Kanade Pyramid (field)');
subplot(5, 2, 7);   showflow(Uhs, Vhs, 'color');    title('Horn-Schunck (color)');
subplot(5, 2, 8);   showflow(Uhs, Vhs, 'field');    title('Horn-Schunck (field)');
subplot(5, 2, 9);   showflow(Uhsp, Vhsp, 'color');  title('Horn-Schunck Pyramid (color)');
subplot(5, 2, 10);  showflow(Uhsp, Vhsp, 'field');  title('Horn-Schunck Pyramid (field)');
hold off;
% saveas(gcf, 'results/exercise01_2_pyramid.png');
waitfor(gcf);