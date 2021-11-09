function R = FuzzyComposition(R1, R2)

% R1 is X*Y
% R2 is Y*Z
% R is X*Z

[X,Y1] = size(R1);
[Y2,Z] = size(R2);
if Y1 ~= Y2
    error('The second dimension of R1 does not equal to the first dimension of R2');
end
Y = Y1;
R = zeros(X,Z);
r = zeros(Y,1);
for i = 1:X
    for k = 1:Z
        for j = 1:Y
            r(j) = min([R1(i,j),R2(j,k)]);
        end        
        R(i,k) = max(r);        
    end
end

end