seed = 32
n = 10000
U = runif(n)
V = runif(n)

X = sqrt(- 2 * log(U)) * cos(2 * pi * V)
Y = sqrt(- 2 * log(U)) * sin(2 * pi * V)

hist(X, breaks = 50)
hist(Y, breaks = 50)

