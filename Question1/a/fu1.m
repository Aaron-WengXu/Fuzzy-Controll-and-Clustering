function d = fu1(y)
% fu1 -> NB: Negative big
d = (stepf(y+30)-stepf(y+16.5)).*...
    ((y-(-30))/(-16.5-(-30)).*(0-1)+1);
d = d + 1.0*(y<-30);
end