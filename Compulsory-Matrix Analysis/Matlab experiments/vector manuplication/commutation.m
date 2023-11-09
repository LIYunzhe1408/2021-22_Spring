function K = commutation(n, m) % 生成交换矩阵 
% Kmn = sigma 1~n (ej' kron Im kron ej)
    In = eye(n);
    Im = eye(m);
    K = zeros(m*n);
    for j = 1:n
        temp1(:) = In(:,j);
        e_j = temp1;
        temp2 = kron(e_j', Im);
        K = K + kron(temp2, e_j);
    end
end