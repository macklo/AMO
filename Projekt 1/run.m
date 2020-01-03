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

%% Punkty startowe
startingPoints = [
	r r r;
	0 0 0;
	1.e7*[1, 1, 1]
	1.e8*[1, 1, 1]
	1.e9*[1, 1, 1]
	];

resultTable = zeros(size(startingPoints, 1), 4);

for i = 1:size(startingPoints, 1)
	x0 = startingPoints(i, :)

	options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', ... 
		'SpecifyObjectiveGradient', true, 'Display', 'final');

	[resultTable(i, 1:3), resultTable(i, 4)] = getResult(latitude, longitude, t, x0, options)
end

%% Maksymalna liczba iteracji
maxIterations = [
	400;
	4;
	3;
	2;
	1;
	];


resultTable = zeros(size(maxIterations, 1), 4);

for i = 1:size(maxIterations, 1)
	x0 = [r r r];

	options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', ... 
		'SpecifyObjectiveGradient',true, 'MaxIterations', maxIterations(i));

	[resultTable(i, 1:3), resultTable(i, 4)] = getResult(latitude, longitude, t, x0, options)
end

%% Maksymalna liczba obliczeñ funkcji celu
maxEval = [
	400;
	20;
	17;
	10;
	5;
	];

resultTable = zeros(size(maxEval, 1), 4);

for i = 1:size(maxEval, 1)
	x0 = [r r r];

	options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', ... 
		'SpecifyObjectiveGradient',true, 'MaxFunctionEvaluations', maxEval(i));

	[resultTable(i, 1:3), resultTable(i, 4)] = getResult(latitude, longitude, t, x0, options)
end

%% Minimalna d³ugoœæ kroku
stepTolerance = [
	1e-6;
	1e-5;
	1e-4;
	1e-2;
	1e-1;
	1
	];

resultTable = zeros(size(stepTolerance, 1), 4);

for i = 1:size(stepTolerance, 1)
	x0 = [r r r];

	options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', ... 
		'SpecifyObjectiveGradient',true, 'StepTolerance', stepTolerance(i));

	[resultTable(i, 1:3), resultTable(i, 4)] = getResult(latitude, longitude, t, x0, options)
end

%% Minimalna zmiana wartoœci funkcji celu
fcnTolerance = [
	1e-6;
	1e-5;
	1e-4;
	1e-2;
	1e-1;
	1
	];

resultTable = zeros(size(fcnTolerance, 1), 4);

for i = 1:size(fcnTolerance, 1)
	x0 = [r r r];

	options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', ... 
		'SpecifyObjectiveGradient',true, 'StepTolerance', fcnTolerance(i));

	[resultTable(i, 1:3), resultTable(i, 4)] = getResult(latitude, longitude, t, x0, options)
end

%% Zaburzenie w danych
dataDisturbance = [
	1e-12;
	1e-10;
	1e-8;
	1e-6;
	1e-4;
	1e-2;
	1e-1;
	];

resultTable = zeros(size(dataDisturbance, 1), 4);

for i = 1:size(dataDisturbance, 1)
	
	x0 = [r r r];

	options = optimoptions('lsqnonlin', 'Algorithm', 'levenberg-marquardt', ... 
		'SpecifyObjectiveGradient',true, 'StepTolerance', dataDisturbance(i));

	[resultTable(i, 1:3), resultTable(i, 4)] = getResult(latitude + rand(size(latitude))*dataDisturbance(i), longitude + rand(size(longitude))*dataDisturbance(i), t + rand(size(t))*dataDisturbance(i), x0, options)
end