function uCentroid = FuzzyController(theta, y, u)

% ftheta is a vector including the handles of membership functions of theta
% ftheta = [ftheta1,ftheta2,ftheta3,ftheta4,ftheta5,ftheta6,ftheta7];
% ftheta1 -> BO: Below much
% ftheta2 -> BR: Below
% ftheta3 -> BH: Below horizontal
% ftheta4 -> HZ: Horizontal
% ftheta5 -> AH: Above horizontal
% ftheta6 -> AR: Above
% ftheta7 -> AO: Above much

% fy is a vector including the handles of membership functions of y
% fy = [fy1,fy2,fy3,fy4,fy5];
% fy1 -> BE: Below
% fy2 -> BC: Below center
% fy3 -> CE: Center
% fy4 -> AC: Above center
% fy5 -> AB: Above

% fu is a vector including the handles of membership functions of u
% fu = [fu1,fu2,fu3,fu4,fu5,fu6,fu7];
% fu1 -> NB: Negative big
% fu2 -> NM: Negative medium
% fu3 -> NS: Negative small
% fu4 -> ZE: Zero
% fu5 -> PS: Positive small
% fu6 -> PM: Positive medium
% fu7 -> PB: Positive big

% Rule Base
%    | BE | BC | CE | AC | AB
% BO | PB   PB   PM   PM   PS
% BR | PB   PB   PM   PS   NS
% BH | PB   PM   PS   NS   NM 
% HZ | PM   PM   ZE   NM   NM
% AH | PM   PS   NS   NM   NB
% AR | PS   NS   NM   NB   NB
% AO | NS   NM   NM   NB   NB

% Rule Base
%    | 1 | 2 | 3 | 4 | 5
% 1 |  7   7   6   6   5
% 2 |  7   7   6   5   3
% 3 |  7   6   5   3   2 
% 4 |  6   6   4   2   2
% 5 |  6   5   3   2   1
% 6 |  5   3   2   1   1
% 7 |  3   2   2   1   1

NB = 1; NM = 2; NS = 3; ZE = 4; PS = 5; PM = 6; PB = 7;
% Rule Base
R = ...
    [PB   PB   PM   PM   PS;
    PB   PB   PM   PS   NS;
    PB   PM   PS   NS   NM;
    PM   PM   ZE   NM   NM;
    PM   PS   NS   NM   NB;
    PS   NS   NM   NB   NB;
    NS   NM   NM   NB   NB];
% figure;
% y = -40:0.1:40;
% plot(y,fu7(y));

% Initial Conditions
theta = theta/pi*180;%from rad to degree
fu = zeros(size(u));


%% Input Fuzzification
% for y
% fy = [fy1,fy2,fy3,fy4,fy5];
fy = zeros(1,5);
for i = 1:5
    fuzzification = sprintf('fy(%d) = fy%d(y)',i,i);
    eval(fuzzification); 
end
Index_y = find(fy);

% for theta
% ftheta = [ftheta1,ftheta2,ftheta3,ftheta4,ftheta5,ftheta6,ftheta7];
ftheta = zeros(1,7);
for j = 1:7
    fuzzification = sprintf('ftheta(%d) = ftheta%d(theta)',j,j);
    eval(fuzzification); 
end
Index_theta = find(ftheta);

%% Fuzzy Aggregation
w = zeros(length(Index_y),length(Index_theta));
foutput = zeros(size(u));
for i = 1:length(Index_theta)
    for j = 1:length(Index_y)
        w(i,j) = min([ftheta(Index_theta(i)),fy(Index_y(j))]);
        
        % using rules
        ConsequentU = sprintf('fu = fu%d(u)',R(Index_theta(i),Index_y(j)));
        eval(ConsequentU);
        % Aggregation
        foutput = max(foutput, min(fu, ones(size(u))*w(i,j)));
    end
end

%% COG defuzzification
uCentroid = defuzz(u,foutput,'centroid');

end










