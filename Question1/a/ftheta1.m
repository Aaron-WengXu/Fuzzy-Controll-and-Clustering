function d = ftheta1(y)
% ftheta1 -> BO: Below much
d = (stepf(y+117.5)-stepf(y+82.5)).*...
    ((y-(-117.5))/(-82.5-(-117.5)).*(0-1)+1);
d = d + 1.0*(y<-117.5);
end