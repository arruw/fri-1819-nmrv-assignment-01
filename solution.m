pkg load image;

I1 = rand(200, 200);
I2 = imrotate(I1, 1, 'bicubic', 'crop');

figure(1); clf;
hold on;
subplot(3, 2, 1); imshow(I1); title('Image 1');
subplot(3, 2, 2); imshow(I2); title('Image 2');

waitfor(gcf);

