function  Merkmale = harris_detektor(Image) 
% In dieser Funktion soll der Harris-Detektor implementiert werden, der
% Merkmalspunkte aus dem Bild extrahiert
%Image = double(Image);
%figure, imshow(Image)
[x,y] = size(Image);
segment_length = 1;
k = 0.05;
%tau = 0.1;
[Gx, Gy] = sobel_xy(Image);
Gx2 = Gx.*Gx;
Gy2 = Gy.*Gy;
Gxy = Gx.*Gy;
Gaussflt = fspecial('Gauss');%[segment_length,segment_length]);
Gx2 = conv2(Gx2, Gaussflt,'same');
Gy2 = conv2(Gy2, Gaussflt,'same');
Gxy = conv2(Gxy, Gaussflt,'same');

%Merkmale = zeros(x,y);

Merkmale = (Gx2.*Gy2 - Gxy.^2) - k*(Gx2 + Gy2).^2;
sze = 2+1; 
Merkmale = ordfilt2(Merkmale,sze^2,ones(sze));
% Tempx2 = zeros(segment_length,segment_length);
% Tempy2 = zeros(segment_length,segment_length);
% Tempxy = zeros(segment_length,segment_length);
% for i = 1:x-segment_length+1
%     for j = 1:y-segment_length+1
%         for m = 1:segment_length
%             for n = 1:segment_length
%             Tempx2(m,n) = Gx2(i+m-1,j+n-1);
%             Tempy2(m,n) = Gy2(i+m-1,j+n-1);
%             Tempxy(m,n) = Gxy(i+m-1,j+n-1);
%             end
%         end
%         G = [Tempx2,Tempxy;Tempxy,Tempy2];
%         Merkmale(i,j) = det(G) - k * trace(G)*trace(G);
%     end 
% end
tau = max(max(Merkmale))*0.01;

Merkmale(Merkmale < tau) = 0;

[mx,my] = find(Merkmale ~= 0);
    
sum = length(mx);

min_dist = 10;
Height = x/2;
Width = y/2;
tile_size = [Height,Width];
N = 1000;

IOM = [mx;my]';  
for k = 1:sum
    if IOM(k)
    end
end
% IOM = ones(sum,2);
% k = 0;
% for i = 1:x
%     for j = 1:y
%         if Merkmale(i,j) == 0
%             continue
%         else
%             k = k + 1;
%             IOM(k,:) = [i,j];
%         end
%     end
% end

%if varargin ==2 
    [mx,my] = find(Merkmale ~= 0);
    
    length(mx) + length(my)
    Markedimage = Image + Merkmale;
    
    figure, imshow(Merkmale)
    hold on 
    plot(my,mx,'r+')
%end

end