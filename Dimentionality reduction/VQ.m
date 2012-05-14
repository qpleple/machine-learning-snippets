%% Vector quantization

%% Initialization
clear;
load('digits');

k = 25;

% Initialize the k columns of V using the first k columns of X 
V = X(:, 1:k);
Y = zeros(k, size(X, 2));
D = X - V * Y;
error = trace(D' * D)

%% Minimize the approximation error ||X - VY||
delta = error;

while delta ~= 0
  olderror = error;
  
  % Assign each column of X to the nearest prototype
  for i = 1:size(X, 2)
    diff = zeros(size(V, 2), 1);
    for j = 1:size(V, 2)
      U = X(:, i) - V(:, j);
      diff(j) = U' * U;
    end
 
    [~, imin] = min(diff);
    Y(:, i) = (1:k == imin);
  end

  % Recompute prototype
  V = (X * Y') ./ repmat(sum(Y, 2)', size(U, 1), 1);
 
  % Compute error function
  D = X - V * Y;
  error = trace(D' * D);
  delta = olderror - error;
  fprintf('Error = %.1f\n', error);
  fprintf('Delta = %.1f\n', delta);
end

%% Display columns of V as images
displayImage(V);