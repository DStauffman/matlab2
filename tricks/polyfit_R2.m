x = 1:10;
y = cos(x) + 0.1*randn(size(x));
% y = x + 0.1*randn(size(x));

p = polyfit(x,y,3);

y2 = polyval(p,x);

temp = corrcoef(y,y2);
R2 = temp(1,2) .^2