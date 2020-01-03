function [e, J]= fun(xp, x, y, z, times)
	c = 299792458;
	e = sqrt((xp(1) - x).^2 + (xp(2) - y).^2 + (xp(3) - z).^2) - c * times;
	J = zeros(5, 3);
	m = sqrt((xp(1) - x).^2 + (xp(2) - y).^2 + (xp(3) - z).^2);
	J(:, 1) = (2*(xp(1) - x))./m;
	J(:, 2) = (2*(xp(2) - x))./m;
	J(:, 3) = (2*(xp(3) - x))./m;
end

