function  Merkmale = harris_detektor(Image) 
% In dieser Funktion soll der Harris-Detektor implementiert werden, der
% Merkmalspunkte aus dem Bild extrahiert
Image = double(Image);
[x,y] = size(Image);
segment_length = 1;
k = 0.05;
tau = 255;
[Gx, Gy] = sobel_xy(Image);
Gx2 = Gx.*Gx;
Gy2 = Gy.*Gy;
Gxy = Gx.*Gy;
Gaussflt = fspecial('Gauss');
Gx2 = conv2(Gx2, Gaussflt,'same');
Gy2 = conv2(Gy2, Gaussflt,'same');
Gxy = conv2(Gxy, Gaussflt,'same');

Merkmale = zeros(x,y);
Tempx2 = zeros(segment_length,segment_length);
Tempy2 = zeros(segment_length,segment_length);
Tempxy = zeros(segment_length,segment_length);
for i = 1:x-segment_length+1
    for j = 1:y-segment_length+1
        for m = 1:segment_length
            for n = 1:segment_length
            Tempx2(m,n) = Gx2(i+m-1,j+n-1);
            Tempy2(m,n) = Gy2(i+m-1,j+n-1);
            Tempxy(m,n) = Gxy(i+m-1,j+n-1);
            end
        end
        G = [Tempx2,Tempxy;Tempxy,Tempy2];
        Merkmale(i,j) = det(G) - k * trace(G)*trace(G);
    end
end

Merkmale(Merkmale < tau) = 0;


min_dist = 10;

%if varargin ==2 
    [mx,my] = find(Merkmale ~= 0);
    length(mx) + length(my)
    figure, imshow(Merkmale)
    hold on 
    plot(my,mx,'r+')
%end

end