function Ainv = lu_inverse(A)

[L,U,P] = lu(A);
n = size(A,1);

Ainv = zeros(n);

for i=1:n

    e = zeros(n,1);
    e(i)=1;

    y = L\(P*e);
    x = U\y;

    Ainv(:,i)=x;

end

end
