% 第一题
A = normrnd(0,1,10000,1);
[coeff,score,latent,tsquared,explained,mu] = pca(A);


% 第二题
%读原图像 
X=imread('test.png'); 
Y=rgb2gray(X); 
figure(1);imshow(Y); 
%奇异值分解 
[U,D,V]=svd(double(Y)); 
SS=size(D); 
M=zeros(SS(1),SS(2)); 
H=min(SS(1),SS(2)); 
dd=fix(H/9); 
d=fix(sqrt(dd)); 
for L=1:d*d 
    MM=M; 
    for ii=1:(L)*9 
        MM(ii,ii)=1; 
    end 
    rho=SS(1)*SS(2)/((SS(1)+SS(2)+1)*L)
    %基于特征值分解进行图像重建（还原） 
    GG=U*(MM.*D)*V'; 
    figure(3),subplot(d,d,L), imshow(uint8(abs(GG))); 
    title(['L=',num2str(L*9),', rho=',num2str(rho)]); 
end 
ZZ=zeros(d,d); 
flag=1; 
for ii=1:d 
    for jj=1:d 
        ZZ(ii,jj)=abs(D(flag,flag)); 
        flag=flag+1; 
    end 
end 
disp(ZZ);
[coeff,score,latent,tsquared,explained,mu] = pca(ZZ);