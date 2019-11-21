param x {1..5};
param y {1..5};
param z {1..5};
param t {1..5};
param c;

var xp {1..3};
minimize objective:
sum {i in 1..5} (sqrt((xp[1] - x[i])^2 + (xp[2] - y[i])^2 +(xp[3] - z[i])^2) - c*t[i])^2