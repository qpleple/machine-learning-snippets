clear;
teapot = load('teapot');
X = teapot.X;

%% Singular values of the Gram matrix
u = mean(X, 2);
X = X - repmat(u, 1, 400);
G = X' * X;
[U,S,V] = svd(G);
sigma = diag(S);
plot(1:length(sigma), sigma, '+');

%% How many dimension to capture 95% of the variance
delta = 0.05;
d = 1;
for d = 1:length(sigma)
  if sum(sigma(1:d)) >= (1-delta) / delta * sum(sigma(d+1:end))
    break
  end 
end

disp(d);

%% Plot the 2-dim embedding
hold on
for i = 1:8:400
  x = 50 * sqrt(sigma(1)) * U(i, 1);
  y = 50 * sqrt(sigma(2)) * U(i, 2);
  w = 101;
  h = 76;
  img = reshape(X(:, i) + u, h, w, 3);
  imagesc([x-w/2 x+w/2], [y+h/2 y-h/2], img);
end

plot(50 * sqrt(sigma(1)) * U(:, 1), 50 * sqrt(sigma(2)) * U(:, 2), 'o');

hold off