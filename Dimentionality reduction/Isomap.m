clear;
teapot = load('teapot');
X = teapot.X;

%% Center images
u = mean(X, 2);
X = X - repmat(u, 1, 400);

%% Run Isomap
% (using package from http://isomap.stanford.edu)
D = L2_distance(X, X, 1);
options.dims = 1:10;
[Y, R, E] = Isomap(D, 'k', 7, options);

%% Plotting
w = 101;
h = 76;

hold on

for i = 1:20:400
  x = Y.coords{2}(1,i);
  y = Y.coords{2}(2,i);
  img = reshape(X(:, i) + u, h, w, 3);
  imagesc([x-w/2 x+w/2], [y+h/2 y-h/2], img);
end
plot(Y.coords{2}(1,:), Y.coords{2}(2,:), 'o');

hold off