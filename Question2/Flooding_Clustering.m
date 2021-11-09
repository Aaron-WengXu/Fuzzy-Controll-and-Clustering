clc;
clear;

x1  = [0.1, 0.7, 0.2, 0.0]';
x2  = [0.0, 0.5, 0.5, 0.0]';
x3  = [0.2, 0.2, 0.2, 0.4]';
x4  = [0.8, 0.1, 0.0, 0.1]';
x5  = [0.3, 0.0, 0.4, 0.3]';
x6  = [0.0, 0.4, 0.0, 0.6]';
x7  = [0.5, 0.0, 0.4, 0.1]';
x8  = [0.6, 0.3, 0.0, 0.1]';
x9  = [0.0, 0.5, 0.1, 0.4]';
x10 = [0.1, 0.6, 0.0, 0.3]';
x11 = [0.3, 0.2, 0.1, 0.4]';
x12 = [0.1, 0.5, 0.4, 0.0]';
x13 = [0.2, 0.0, 0.2, 0.6]';
x14 = [0.2, 0.6, 0.1, 0.1]';
x15 = [0.1, 0.7, 0.1, 0.1]';
x16 = [0.2, 0.4, 0.2, 0.2]';

x = [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16];
R1 = zeros(16,16);
for i = 1:16
    for j = 1:16
        R1(i,j) = abs(x(:,i)'*x(:,j))/sqrt((x(:,i)'*x(:,i))*(x(:,j)'*x(:,j)));
    end
end

file_R1 = roundn(R1,-4);
fileID = fopen('R1.txt','w');
fprintf(fileID,'%1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f \n',file_R1');
fclose(fileID);
% save('R1.txt','file_R1','-ascii');

% R1 = [1 0.8 0.4 0.5 0.2;
%       0.8 1 0.4 0.5 0.9;
%       0.4 0.4 1 0.4 0.4;
%       0.5 0.5 0.4 1 0.5;
%       0.2 0.9 0.4 0.5 1];

% R  = [1 0.8 0.4 0.5 0.8;
%       0.8 1 0.4 0.5 0.9;
%       0.4 0.4 1 0.4 0.4;
%       0.5 0.5 0.4 1 0.5;
%       0.8 0.9 0.4 0.5 1];

R = FuzzyComposition(R1, R1);

while ~isequal(R, R1)
    R1 = R;
    R = FuzzyComposition(R1, R1);
end

file_R = roundn(R,-4);
fileID = fopen('R.txt','w');
fprintf(fileID,'%1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f %1.4f \n',file_R');
fclose(fileID);

% a = 0.4;
a = 0.8;
[Ra,Classification,Number_Class] = aCutLevel(R,a);


fileID = fopen('Ra.txt','w');
fprintf(fileID,'%1d %1d %1d %1d %1d %1d %1d %1d %1d %1d %1d %1d %1d %1d %1d %1d \n',Ra');
fclose(fileID);

i = 1;
for a = 0.4:0.00001:1
    [Ra,Classification,Number_Class] = aCutLevel(R,a);
    Clustering(i,:) = [Number_Class, a];
    i = i+1;
end
a = 0.85;
[Ra,Classification,Number_Class] = aCutLevel(R,a);
