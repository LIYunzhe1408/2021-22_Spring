load hald; %用 Matlab 函数 pca( )进行主成分分析 
[coeff,score,latent,tsquared,explained] = pca(ingredients,'Algorithm','svd','Centered',true) 
disp('--用 Matlab 函数 pca( )进行主成分分析---结束'); 
%自编程序验证 pca() 
S=size(ingredients);%求数据维数 
EX=zeros(1,S(2)); %用于存放数据期望值 
%（1）求期望值 
for II=1:S(1) 
EX=EX+ingredients(II,:); 
end 
EX=EX/S(1); 
%（2）求协方差矩阵 
DX=zeros(S(2),S(2)); 
for II=1:S(1)
 DX=DX+(ingredients(II,:)-EX)'*(ingredients(II,:)-EX); 
end 
DX=DX/(S(1)-1); 
disp(EX);
disp('以上是数学期望---------------'); 
disp(DX); 
disp('以上是协方差矩阵-------------'); 
%（3）特征值分解或奇异值分解 
[U,SS,V]=svd(DX); %[U,SS]=eig(DX) 
Y=U'*(ingredients'-EX'*ones(1,S(1)));
%Hotelling 变换 
%coeff 
disp('Coeff='); 
disp(U); 
%latent 
disp('Latent='); 
disp(diag(SS)); 
%score 
disp('Score='); 
disp(Y'); 
Explained=diag(SS); 
Explained=100*Explained/sum(Explained);
 %explained 
disp('Explained='); 
disp(Explained); 
S1=DX; 
n=S(2); 
for II=1:S(1) 
X(II,:)=ingredients(II,:)-EX; 
end 
Tsquared=X*pinv(S1)*X';
%Matlab 如此计算 Tsquared!!! 
T2=diag(Tsquared); 
%tsquared 
disp('Tsquared='); 
disp(T2); 
disp('---自编程序验证 pca()结束----');