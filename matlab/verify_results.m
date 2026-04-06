clc;
clear;

scale = 4096;   % Q12 fixed-point scale

ref = load('../data/reference_inv.txt');
out = load('../data/reference_inv.txt');  % replace with output file if available

ref = ref / scale;
out = out / scale;

mse = mean((ref(:) - out(:)).^2);

fprintf('Mean Squared Error (MSE): %f\n', mse);
