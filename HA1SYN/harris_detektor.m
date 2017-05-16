function  Merkmale = harris_detektor(Image,varargin) 
% In dieser Funktion soll der Harris-Detektor implementiert werden, der
% Merkmalspunkte aus dem Bild extrahiert
if size(size(Image),2)==2
    Gray_image=Image;
else
    R=Image(:,:,1);
    G=Image(:,:,2);
    B=Image(:,:,3);
    Gray_image=0.299*R+0.587*G+0.114*B;
end

segment_length=varargin{1};
k=varargin{2};
sigma=varargin{3};
tau=varargin{4};
min_dist=varargin{5};
tile_size=varargin{6};
N=varargin{7};
if N > tile_size^2
    fprintf('Wrong input parameter!!!\n\n\n');
end

[Fx,Fy] = sobel_xy(Gray_image);
Fx2=Fx.^2;
Fy2=Fy.^2;
Fxy=Fx.*Fy;
h=fspecial('gaussian',[segment_length,segment_length],sigma);
FX2=conv2(Fx2,h,'same');
FY2=conv2(Fy2,h,'same');
FXY=conv2(Fxy,h,'same');
[ii,jj]=size(Gray_image);
R=zeros(ii,jj);
for i=1:ii
    for j=1:jj
        M=[FX2(i,j) FXY(i,j);FXY(i,j) FY2(i,j)];
        R(i,j)=det(M)-k*(trace(M))^2;
    end
end
Merkmale=zeros(ii,jj);
for i=1:ii
    for j=1:jj
        if R(i,j)>tau
            Merkmale(i,j)=R(i,j);
        end
    end
end

[a,b]=find(Merkmale~=0);

Test1=zeros(ii,jj);
test1=zeros(min_dist,min_dist);
for i=1:ii-min_dist+1
    for j=1:jj-min_dist+1
        test1(1:min_dist,1:min_dist)=Merkmale(i:i+min_dist-1,j:j+min_dist-1);
        if sum(sum(test1))~=0
            [aa,bb]=find((test1)~=0);
            if size(aa)==1
                Test1(i+aa-1,j+bb-1)=test1(aa,bb);
            else
                m=round(mean(aa));
                n=round(mean(bb));
                Test1(i+m-1,j+n-1)=mean(mean(test1));
            end
            test1=zeros(min_dist,min_dist);
        else
            continue;
        end
    end
end

Test2=zeros(ii,jj);
test2=zeros(tile_size,tile_size);
for i=1:ii-tile_size+1
    for j=1:jj-tile_size+1
        test2(1:tile_size,1:tile_size)=Test1(i:i+tile_size-1,j:j+tile_size-1);
        if max(size(find((test2)==0)))>N
            [aaa,bbb]=sort(test2(:));
            test2(bbb(1:end-N))=0;
            Test2(i:i+tile_size-1,j:j+tile_size-1)=test2(1:tile_size,1:tile_size);
            test2=zeros(tile_size,tile_size);
        else
            continue;
        end
    end
end

[x,y]=find(Test2~=0);

num1=length(a)
figure(1);
imshow(Gray_image);
hold on;
for i=1:num1
    plot(b(i),a(i),'r+');
end
num2=length(x)
figure(2)
imshow(Gray_image);
hold on;
for i=1:num2
    plot(y(i),x(i),'r+');
end

end