I1{1} = rand(500, 500);
I2{1} = imrotate(I1{1}, 1, 'bicubic', 'crop');

I1{2} = imread('./resources/disparity/office2_left.png');
I2{2} = imread('./resources/disparity/office2_right.png');

I1{3} = imread('./resources/disparity/office_left.png');
I2{3} = imread('./resources/disparity/office_right.png');

I1{4} = imread('./resources/disparity/cporta_left.png');
I2{4} = imread('./resources/disparity/cporta_right.png');

I1{5} = imread('./resources/collision/00000001.jpg');
I2{5} = imread('./resources/collision/00000002.jpg');

I1{6} = imread('./resources/collision/00000100.jpg');
I2{6} = imread('./resources/collision/00000110.jpg');

I1{7} = imread('./resources/home/img-0010-1.png');
I2{7} = imread('./resources/home/img-0010-2.png');

imi = 1;

for imsi = [1:7]
    Im{imi} = I1{imsi}; imi = imi+1;
    Im{imi} = I2{imsi}; imi = imi+1;

    [U{1}, V{1}] = lucaskanade(I1{imsi}, I2{imsi}, 3);
    [U{2}, V{2}] = lucaskanade_pyramidal(I1{imsi}, I2{imsi}, 3, 4);
    [U{3}, V{3}] = lucaskanade_parallel_pyramidal(I1{imsi}, I2{imsi}, 3, 4);
    [U{4}, V{4}] = hornschunck(I1{imsi}, I2{imsi}, 0.5, 2000);
    [U{5}, V{5}] = hornschunck_pyramidal(I1{imsi}, I2{imsi}, 0.5, 2000, 4);

    Im{imi} = toDf(U{1}, V{1}); imi = imi+1;
    Im{imi} = toDf(U{2}, V{2}); imi = imi+1;
    Im{imi} = toDf(U{3}, V{3}); imi = imi+1;
    Im{imi} = toDf(U{4}, V{4}); imi = imi+1;
    Im{imi} = toDf(U{5}, V{5}); imi = imi+1;
end

montage(Im, 'Size', [7 7]);

function Dfc = toDf(U, V)
    angle = atan2(V, U) + pi;
    magnitude = sqrt(U .^ 2 + V .^ 2);
    
    Ihsv = cat(3, angle ./ (2 * pi), min(1, magnitude), ones(size(magnitude)));

    Dfc = hsv2rgb(Ihsv);
end