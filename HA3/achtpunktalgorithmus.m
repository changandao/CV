function [EF] = achtpunktalgorithmus(Korrespondenzen,K)
% Diese Funktion berechnet die Essentielle Matrix oder Fundamentalmatrix
% mittels 8-Punkt-Algorithmus, je nachdem, ob die Kalibrierungsmatrix 'K'
% vorliegt oder nicht

num_of_p = length(Korrespondenzen);

z = ones(1,num_of_p);
x2 = [Korrespondenzen(3:4, :);z];
x1 = [Korrespondenzen(1:2, :);z];
A = zeros(num_of_p,9);
for i = 1:num_of_p
    a = x2(:,i)*x1(:,i)';
    A(i, :) = a(:)';
end

[uA,sA,vA] = svd(A);
Gs = vA(:,9);

Gs = reshape(Gs,[3,3]);
[uG,sG,vG] = svd(Gs);
sG(3,3) = 0;
F = uG*sG*vG';

if nargin < 2
    EF = F;
else
    EF = K'*F*K;
end

end