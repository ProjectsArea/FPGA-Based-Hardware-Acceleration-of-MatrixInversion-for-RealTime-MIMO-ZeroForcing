function Ainv = qr_inverse(A)

[Q,R] = qr(A);

Ainv = inv(R)*Q';

end
