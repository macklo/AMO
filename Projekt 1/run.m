close all
clear
clc

r = 6378137;
h = r + 20000000;
latitude  = deg2rad([
	52.885907 
	50.312052 
	47.796902 
	50.619584 
	55.488272
	]);

longitude = deg2rad([
	13.395837 
	12.373351 
	19.381854 
	26.244260 
	28.787526
	]);

times = [
	6.682150977843770e-02 
	6.687348376892789e-02 
	6.680893203665556e-02 
	6.675918647949096e-02 
	6.682973397386979e-02
	];

x = h * cos(latitude) .* cos(longitude);
y = h * cos(latitude) .* sin(longitude);
z = h * sin(latitude);

fitfun = @(xp)(fun(xp, x, y, z, times));

x0 = [r, r, r];

options = optimoptions('lsqnonlin','Algorithm', 'levenberg-marquardt', ... 
	'Display', 'iter-detailed');

[result, resnorm, residual, exitflag, output] = lsqnonlin(fitfun ,x0, [], [], options);

xp = result(1);
yp = result(2);	
zp = result(3);

xH         = sqrt(xp^2 + yp^2 + zp^2) - r
xLatitude  = rad2deg(asin(zp / r)) 
xLongitude = rad2deg(atan(yp / xp))