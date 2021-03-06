function [Korrespondenzen] = punkt_korrespondenzen(I1,I2,Mpt1,Mpt2,varargin)
% In dieser Funktion sollen die extrahierten Merkmalspunkte aus einer
% Stereo-Aufnahme mittels NCC verglichen werden um Korrespondenzpunktpaare
% zu ermitteln.
P = inputParser;
P.addOptional('window_length', 15, @isnumeric)
P.addOptional('min_corr', 0.3, @isnumeric)
P.addOptional('do_plot', false, @islogical)
P.parse(varargin{:});
 
window_length = P.Results.window_length;
min_corr      = P.Results.min_corr;
do_plot       = P.Results.do_plot;

[m,n]=size(I1);
%pad_row=mod(m,window_length);
%pad_col=mod(n,window_length);
It1 = double(padarray(I1, [window_length, window_length], 'symmetric', 'both'));
It2 = double(padarray(I2, [window_length, window_length], 'symmetric', 'both'));
%window_length = uint8(window_length);
lenofM1 = length(Mpt1);
lenofM2 = length(Mpt2);

Wn = zeros(window_length^2, lenofM1);
Vn = zeros(window_length^2, lenofM2);

%Mpt1 = Mpt1';
Mpt1 = Mpt1' + window_length;%(window_length-1)/2;
Mpt2 = Mpt2' + window_length;%(window_length-1)/2;
for i = 1:lenofM1
    Wk = It1(Mpt1(i,2)-(window_length-1)/2:Mpt1(i,2)+(window_length-1)/2, Mpt1(i,1)-(window_length-1)/2:Mpt1(i,1)+(window_length-1)/2);
    meanofW = mean(Wk(:));
    stdofW = std(Wk(:));
    Wk = (Wk(:)-meanofW)/stdofW;
    Wn(:,i) = Wk;
end

for i = 1:lenofM2
    Vk = It2(Mpt2(i,2)-(window_length-1)/2:Mpt2(i,2)+(window_length-1)/2, Mpt2(i,1)-(window_length-1)/2:Mpt2(i,1)+(window_length-1)/2);
    meanofV = mean(Vk(:));
    stdofV = std(Vk(:));
    Vk = (Vk(:)-meanofV)/stdofV;
    Vn(:,i) = Vk;
end

NCC = Wn' * Vn/(window_length^2-1);

NCC(NCC < min_corr) = 0;
[M, I] = max(NCC, [], 2);

I(M == 0) = [];
Mpt1(M == 0, :) = [];
Korrespondenzen = zeros(4,length(I));
Mpt1 = Mpt1 - window_length;%(window_length-1)/2;
Mpt2 = Mpt2 - window_length;%(window_length-1)/2;
for k = 1:length(I)
    Korrespondenzen(1,k) = Mpt1(k,1);
    Korrespondenzen(2,k) = Mpt1(k,2);
    Korrespondenzen(3,k) = Mpt2(I(k),1);
    Korrespondenzen(4,k) = Mpt2(I(k),2);
end

figure
if do_plot==true
IGray=[I1,zeros(m,10),I2];
Korrespondenzen_plot=Korrespondenzen;
Korrespondenzen_plot(3,:)=Korrespondenzen(3,:)+n+10;
imshow(IGray)
hold on
for i=1:length(I)
    x=[Korrespondenzen_plot(1,i),Korrespondenzen_plot(3,i)];
    y=[Korrespondenzen_plot(2,i),Korrespondenzen_plot(4,i)];
    plot(x,y,'-');
    hold on;
end 
hold off

size(Korrespondenzen)
end


