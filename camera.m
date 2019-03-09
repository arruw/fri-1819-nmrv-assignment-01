warning('off');
pkg load image;
pkg load parallel;
pkg load image-acquisition;

function I = rgb2gray(I)
    I = 0.32.*I(:,:,3) + 0.32.*I(:,:,2) + 0.32.*I(:,:,1);
endfunction

delete('results/camera/*')
seq = 1

obj = videoinput('v4l2', '/dev/video0');
set(obj, 'VideoFormat', 'RGB3');
set(obj, 'VideoResolution', [320 240]);

figure(1); clf; hold on;
start(obj, 2)
while true
    I1 = rgb2gray(getsnapshot(obj));
    I2 = rgb2gray(getsnapshot(obj));

    [U, V] = lucaskanade_parallel_pyramidal(I1, I2, 3, 4);
    
    subplot(1, 3, 1); imshow(I1); title('Image 1');
    subplot(1, 3, 2); imshow(I2); title('Image 2');
    subplot(1, 3, 3); showflow(U, V, 'color'); title('Lucas-Kanade (color)');

    imwrite(I1, strcat('results/camera/img-', num2str(seq, '%04d'), '-1.png'));
    imwrite(I2, strcat('results/camera/img-', num2str(seq, '%04d'), '-2.png'));
    saveas(gcf, strcat('results/camera/figure-', num2str(seq, '%04d'), '.png'));

    seq = seq + 1;
    pause(0.1);    
endwhile