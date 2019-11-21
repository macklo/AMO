function e = fun(xp, x, y, z, times)
	c = 299792458;
	e = sqrt((xp(1) - x).^2 + (xp(2) - y).^2 +(xp(3) - z).^2) - c * times;
end

