function d = fy1(y)
% fy1 -> BE: Below
d = (stepf(y+40)-stepf(y+13)).*...
    ((y-(-40))/(-13-(-40)).*(0-1)+1);
d = d + 1.0*(y<-40);
end

