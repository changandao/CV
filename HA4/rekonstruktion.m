function [T,R, lambdas, P1] = rekonstruktion(T1,T2,R1,R2, Korrespondenzen, K)
% Funktion zur Bestimmung der korrekten euklidischen Transformation, der
% Tiefeninformation und der 3D Punkte der Merkmalspunkte in Bild 1

d = size(T1, 1);
num = size(Korrespondenzen,2);

X1 = zeros(num,3);
X2 = zeros(num,3);

X1(:,1) = Korrespondenzen(1,:)';
X1(:,2) = Korrespondenzen(2,:)';
X1(:,3) = ones(num,1);

X2(:,1) = Korrespondenzen(3,:)';
X2(:,2) = Korrespondenzen(4,:)';
X2(:,3) = ones(num,1);

fM1 = cross(X2', R1*X1');
fM2 = cross(X2', R2*X1');



M11 = zeros(d*num, num+1);
M12 = zeros(d*num, num+1);
for i = 1:num
    i
    M11(d*(i-1)+1:d*i,i) = fM1(:,i);
    M11(d*(i-1)+1:d*i,end) = cross(X2(i,:)',T1);
    M12(d*(i-1)+1:d*i,i) = fM2(:,i);
    M12(d*(i-1)+1:d*i,end) = cross(X2(i,:)',T2);
end

[u11,s11,v11] = svd(M11);
[u12,s12,v12] = svd(M12);
solution11 = v11(:,end);
solution12 = v12(:,end);

lambdas11 = solution11(1:end-1);
lambdas12 = solution12(1:end-1);

bM1 = cross(X1', R1'*X2');
bM2 = cross(X1', R2'*X2');

gXRT1 = solution11(end) * cross(X1', R1'*T1*ones(1,num));
gXRT2 = solution12(end) * cross(X1', R2'*T2*ones(1,num));


M21 = zeros(d*num, num+1);
M22 = zeros(d*num, num+1);
for i = 1:num
    i
    M21(d*(i-1)+1:d*i,i) = bM1(:,i);
    M21(d*(i-1)+1:d*i,end) = gXRT1(:,i);%cross(X2(i,:)',T1);
    M22(d*(i-1)+1:d*i,i) = bM2(:,i);
    M22(d*(i-1)+1:d*i,end) = gXRT2(:,i);%cross(X2(i,:)',T2);
end

[u21,s21,v21] = svd(M21);
[u22,s22,v22] = svd(M22);
solution21 = v21(:,end);
solution22 = v22(:,end);

lambdas21 = solution21(1:end-1);
lambdas22 = solution22(1:end-1);

positive1 = sum(lambdas11.*lambdas21>0);
positive2 = sum(lambdas12.*lambdas22>0);

% positive21 = sum(lanmbdas21>0);
% positive22 = sum(lanmbdas22>0);

if positive1 > positive2
    T = T1;
    R = R1;
    lambdas = lambdas11;
    P1 = X1*pinv(K').*(solution11(1:end-1)*ones(1,d));
else
    T = T2;
    R = R2;
    lambdas = lambdas12;
    P1 = X1*pinv(K').*(solution12(1:end-1)*ones(1,d));
end

gamba = solution12(end);

P1 = P1';

end