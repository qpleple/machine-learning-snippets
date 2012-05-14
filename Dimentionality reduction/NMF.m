%% Non negative matrix factorization

%% Initialization
clear;
load('digits');

k = 25;

% Initialize the k columns of V using the k first columns of X
V = X(:, 1:k);
% Initialize Y by setting all elements to 1/k
Y = ones(k, size(X, 2)) / k;

displayImage(V);

% Error (euclidian norm)
D = X - V * Y;
error = trace(D' * D);

%% Minimize the approximation error ||X - VY||
delta     = error;
iteration = 1;

while delta ~= 0
 
  % Multiplicative update rules for LS
  A = Y .* (V' * X);
  B = (V' * V) * Y;
  indices = (B ~= 0);
  Y(indices) = A(indices) ./ B(indices);

  A = V .* (X * Y');
  B = V * (Y * Y');
  indices = (B ~= 0);
  V(indices) = A(indices) ./ B(indices);
  
  % Compute error function
  iteration = iteration + 1;
  fprintf('Iteration = %i\n', iteration);
  if mod(iteration, 1000) == 0
    D = X - V * Y;
    olderror = error;
    error    = trace(D' * D);
    delta    = olderror - error;
    fprintf('Error     = %.1f\n', error);
    fprintf('Delta     = %.1f\n', delta);
  end
  
  displayImage(V);
end
