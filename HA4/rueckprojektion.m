function repro_error = rueckprojektion(Korrespondenzen, P1, I2, T, R, K)
% Diese Funktion berechnet die projizierten Punkte in Kamera 2 und den
% mittleren Rueckprojektionsfehler

P2 = R * P1 + T;
num = size(Korrespondenzen,2);
P2(end+1,:) = ones(1,num);
PI0 = [ones(3),zeros(3,1)];
x2_p = K * PI0 * P2;
x2_pred = x2_p(1:2,:);
x2 = [Korrespondenzen(3,:);Korrespondenzen(4,:)];
repro_error = sqrt(trace((x2-x2_pred)'*(x2-x2_pred)))/num;
end