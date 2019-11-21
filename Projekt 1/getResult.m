function [coords, error] = getResult(latitude, longitude, times, startingPoint, options)
	r = 6378137;
	h = r + 20000000;

	x = h * cos(latitude) .* cos(longitude);
	y = h * cos(latitude) .* sin(longitude);
	z = h * sin(latitude);

	fitfun = @(xp)(fun(xp, x, y, z, times));
	
	[result, resnorm] = lsqnonlin(fitfun ,startingPoint, [], [], options);

	result
	xp = result(1);
	yp = result(2);
	zp = result(3);
	
	coords = zeros(1, 3);
	coords(1) = abs(rad2deg(asin(zp / r)));
	coords(2) = abs(rad2deg(atan(yp / xp)));
	coords(3) = abs(sqrt(xp^2 + yp^2 + zp^2)) - r;
	
	coords
	
	error = resnorm;
end

