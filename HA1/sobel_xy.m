function [Fx,Fy] = sobel_xy(Image)
% In dieser Funktion soll das Sobel-Filter implementiert werden, welches
% ein Graustufenbild einliest und den Bildgradienten in x- sowie in
% y-Richtung zur?ckgibt.
Image = im2double(Image);
Sobel_x = log(2)*[1, 0, -1; 2, 0, -2; 1, 0, -1]/8;
Sobel_y = log(2)*[1,2,1;0,0,0;-1,-2,-1]/8;
Fx = conv2(Image, Sobel_x, 'same');
Fy = conv2(Image, Sobel_y, 'same');

figure
imshow(Fx)
imshow(Fy)
end

