while 1
  % Recompute prototype
  u1 = mean(X(:, cl1), 2);
  u2 = mean(X(:, cl2), 2);
  
  % Assign each datapoint to the nearest prototype
  for i = 1:n
    d1 = sum((X - repmat(u1, 1, n)) .^ 2);
    d2 = sum((X - repmat(u2, 1, n)) .^ 2);
    
    cl1 = d1 <= d2;
    cl2 = ~cl1;
  end
  
  plot(...
    X(1, cl1), X(2, cl1), 'ob',...
    X(1, cl2), X(2, cl2), 'or'...
  );

  drawnow();
end