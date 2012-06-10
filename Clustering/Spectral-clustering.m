clear;
rings = load('rings');
X = rings.X;
n = 1000;

sigma = 0.3;

K = zeros(n, n);
for i = 1:n
  for j = 1:n
    K(i, j) = exp(-norm(X(:, i) - X(:, j))^2 / sigma^2);
  end
end

D = diag(sum(K));
L = D - K;
[V, Delta] = eig(L);
lambda = diag(Delta);

%% Plotting
subplot(1, 2, 1);
plot(1:10, lambda(1:10), '+');

idx1 = V(:, 1) > mean(V(:, 1));
idx2 = V(:, 2) > mean(V(:, 2));

subplot(1, 2, 2);
plot(...
  X(1, idx1), X(2, idx1), 'ob',...
  X(1, idx2), X(2, idx2), 'or'...
);