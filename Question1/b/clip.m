function y = clip(x, lowb, upb)

if x >= upb
    y = upb;
elseif x<=lowb
    y = lowb;
else
    y = x;

end