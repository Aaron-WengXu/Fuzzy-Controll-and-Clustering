function d = fy5(y)
% fy5 -> AB: Above
d = (stepf(y-13)-stepf(y-40)).*...
    ((y-(13))/(40-(13)).*(1-0)+0);
d = d + 1.0*(y>=40);
end