function X = newton_schulz_inverse(A)

n = size(A,1);

X = A'/(norm(A,1)*norm(A,inf));

I = eye(n);

for i=1:10

    X = X*(2*I - A*X);

end

end
