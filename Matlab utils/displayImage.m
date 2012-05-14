function displayImage( V )
  imageLine = reshape(V, 28, []);
  image     = zeros(5 * 28);

  for i = 0:24
    x = floor(i / 5) * 28;
    y = mod(i, 5) * 28;
    k = i * 28;
    image(x+1:x+28, y+1:y+28) = imageLine(1:28, k+1:k+28);
  end

  imagesc(image);
  drawnow;
end