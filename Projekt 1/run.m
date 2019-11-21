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

t = [
	6.682150977843770e-02 
	6.687348376892789e-02 
	6.680893203665556e-02 
	6.675918647949096e-02 
	6.682973397386979e-02
	];

x = h * cos(latitude) .* cos(longitude);
y = h * cos(latitude) .* sin(longitude);
z = h * sin(latitude);

startingPoints = [
	0 0 0;
	r/2 r/2 r/2;
	h h h;
	1.e8*[1, 1, 1]
	];

resultTable = zeros(size(startingPoints, 1), 4);

for i = 1:size(startingPoints, 1)
	x0 = startingPoints(i, :)

	options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', ... 
		'Display', 'final');

	[resultTable(i, 1:3), resultTable(i, 4)] = getResult(latitude, longitude, t, x0, options)
end