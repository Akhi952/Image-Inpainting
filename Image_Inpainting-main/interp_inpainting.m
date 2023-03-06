function [Irestored_linear, Irestored_nearest] = interp_inpainting(I,mask)

[i, j] = find(mask == 1);
coord = cat(2,i,j);

[i2, j2] = find(mask == 0);
coordScat = cat(2, i2, j2);

ind = sub2ind(size(I), i, j);
indScat = sub2ind(size(I), i2, j2);

v = I(ind);


F_linear = scatteredInterpolant(coord, v, 'linear');
F_nearest = scatteredInterpolant(coord, v, 'nearest');

reconstructedImage_linear = I;
reconstructedImage_nearest = I;

newV = F_linear(coordScat);
reconstructedImage_linear(indScat) = newV;

newV = F_nearest(coordScat);
reconstructedImage_nearest(indScat) = newV;

Irestored_linear = reconstructedImage_linear;
Irestored_nearest = reconstructedImage_nearest;

end