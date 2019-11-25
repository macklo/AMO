function [coords, error] = getResult(latitude, longitude, t, startingPoint, options)
	r = 6378137;
	h = r + 20000000;

	x = h * cos(latitude) .* cos(longitude);
	y = h * cos(latitude) .* sin(longitude);
	z = h * sin(latitude);

	fitfun = @(xp)(fun(xp, x, y, z, t));
	
	[result, resnorm] = lsqnonlin(fitfun ,startingPoint, [], [], options);

	result
	xp = result(1);
	yp = result(2);
	zp = result(3);
	
	coords = zeros(1, 3);
	d = sqrt(xp^2 + yp^2 + zp^2); 
	coords(1) = rad2deg(asin(zp / d));
	coords(2) = rad2deg(atan(yp / xp));
	coords(3) = d - r;
	
	coords = round(coords, 4)
	
	error = resnorm;
end

