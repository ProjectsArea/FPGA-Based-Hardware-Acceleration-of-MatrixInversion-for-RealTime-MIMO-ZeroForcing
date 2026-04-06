function Ainv = gauss_jordan_inverse(A)

n = size(A,1);
Aug = [A eye(n)];

for i=1:n

    Aug(i,:) = Aug(i,:)/Aug(i,i);

    for j=1:n

        if j~=i
            Aug(j,:) = Aug(j,:) - Aug(j,i)*Aug(i,:);
        end

    end
end

Ainv = Aug(:,n+1:end);

end
