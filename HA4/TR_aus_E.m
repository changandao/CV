function [T1,R1,T2,R2] = TR_aus_E(E)
% In dieser Funktion sollen die moeglichen euklidischen Transformationen
% aus der Essentiellen Matrix extrahiert werden

R_PIby2  = [0,-1,0;1,0,0;0,0,1];
R_PIbym2 = [0,1,0;-1,0,0;0,0,1];

[u,s,v] = svd(E);
temptM1 = ones(3);
temptM2 = ones(3);
tmeptM1(3,3) = round(det(u));
tmeptM2(3,3) = round(det(v));

u = u * tmeptM1;
v = v * tmeptM2;

R1 = u * R_PIby2' * v';
T_dach1 = u * R_PIby2 * s * u';
T1 = [T_dach1(3,2); -T_dach1(3,1); T_dach1(2,1)];

R2 = u * R_PIbym2' * v';
T_dach2 = u * R_PIbym2 * s * u';
T2 = [T_dach2(3,2); -T_dach2(3,1); T_dach2(2,1)];

end