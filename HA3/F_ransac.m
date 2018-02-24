function [Korrespondenzen_robust] = F_ransac(Korrespondenzen,varargin)
% Diese Funktion implementiert den RANSAC-Algorithmus zur Bestimmung von
% robusten Korrespondenzpunktpaaren

%% Input parser
P = inputParser;

% Liste der optionalen Parameter
% Fensterl?nge
P.addOptional('epsilon', 0.05, @isnumeric)
% Minimal geforderte Korrelation
P.addOptional('p', 0.95, @(x)isnumeric(x) && x > 0 && x < 1);
% Plot ein/aus
P.addOptional('tolerance', 1, @isnumeric);

% Lese den Input
P.parse(varargin{:});

% Extrahiere die Variablen aus dem Input-Parser
epsilon   = P.Results.epsilon;
p         = P.Results.p;
tolerance = P.Results.tolerance;

%% Iterationszahl s bestimmen
k = 8;
s = log(1-p)/log(1-(1-epsilon)^k);

n = length(Korrespondenzen);
e3_dach = [0,-1,0;1,0,0;0,0,0];
F = zeros(3,3);
mfinal = 0;

it = 0;
md=[];
while it < s
    it = it + 1;
    dtmp = [];
    KPtmp = [];
    %tempKP = Korrespondenzen;
    selectedinx = randperm(n,k);
    selectedKorrespondenzen = Korrespondenzen(:,selectedinx);
    %tempKP(:, selectedinx) =[];
    Ftmp = achtpunktalgorithmus(selectedKorrespondenzen);
    m = 0;
    for j = 1:length(Korrespondenzen)
        ux1 = [Korrespondenzen(1:2,j);1];
        ux2 = [Korrespondenzen(3:4,j);1];
        denominater = sum((e3_dach*Ftmp*ux1).^2)+sum((ux2'*Ftmp*e3_dach).^2);
        d = (ux2' * Ftmp * ux1)^2/denominater;
        if d < tolerance
            m = m+1;
            KPtmp = [KPtmp, Korrespondenzen(:,j)];
        end
    end
    if m > mfinal
        F = Ftmp;
        mfinal = m;
        Korrespondenzen_robust = KPtmp;
    end
end

end