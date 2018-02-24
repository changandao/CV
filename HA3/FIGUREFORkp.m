figure('name', 'Punkt-Korrespondenzen');
imshow(uint8(IGray1))
hold on
plot(Korrespondenzen_robust(1,:),Korrespondenzen_robust(2,:),'r*')
imshow(uint8(IGray2))
alpha(0.5);
hold on
plot(Korrespondenzen_robust(3,:),Korrespondenzen_robust(4,:),'g*')
for i=1:size(Korrespondenzen_robust,2)
    hold on
    x_1 = [Korrespondenzen_robust(1,i), Korrespondenzen_robust(3,i)];
    x_2 = [Korrespondenzen_robust(2,i), Korrespondenzen_robust(4,i)];
    line(x_1,x_2);
end
hold off