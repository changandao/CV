function [Fx,Fy] = sobel_xy(Image)
% In dieser Funktion soll das Sobel-Filter implementiert werden, welches
% ein Graustufenbild einliest und den Bildgradienten in x- sowie in
% y-Richtung zur?ckgibt.
Sobel_x = [1, 0, -1; 2, 0, -2; 1, 0, -1]/8;
Sobel_y = [1,2,1;0,0,0;-1,-2,-1]/8;
Fx = conv2(Image, Sobel_x, 'same');
Fy = conv2(Image, Sobel_y, 'same');

end

