% 数据实验3 （一） 不太确定思路，看了matlab实验手册后，按里面解法重新手打了一遍
clear all; rng default 
N=7;% 阶数，N+1 个系数 
M=20;% 数据采样点个数 
x=rand(M,1); 
alpha=0.1; 
beta=0.05; 
b=sin(pi/2*x)+randn*alpha;% 取值加入噪声 
a=zeros(N+1,1); 
A=zeros(M,N+1);

for ii=1:M 
    for jj=1:N+1 
        A(ii,jj)=x(ii)^(jj-1)+randn*beta;% 加入噪声！
    end 
end 
BltN=A(1:N-1,:); 
BeqN=A(1:N+1,:); 
BgtN=A; 
%%
%(1):方程个数等于未知数个数 
B=BeqN; 
bb=b(1:N+1); 
a=B\bb; 
%a=(B'*B+.00012*eye(1+N,1+N))\B'*bb; 
tt=0:0.01:1; 
yy=zeros(1,length(tt)); 
for ii=1:length(tt) 
    for jj=1:N+1 
        yy(ii)=yy(ii)+a(jj)*tt(ii)^(jj-1); 
    end 
end 
plot(tt,yy,'-k'); 
hold on 
%%
%(2)方程个数大于未知数个数 
B=BgtN; bb=b; 
a=(B'*B+.00012*eye(1+N,1+N))\B'*bb; 
yy=zeros(1,length(tt)); 
for ii=1:length(tt) 
    for jj=1:N+1 
        yy(ii)=yy(ii)+a(jj)*tt(ii)^(jj-1); 
    end 
end 
plot(tt,yy+0.1,'.b'); 
hold on 
%%
%(3)方程个数小于未知数个数 
B=BltN; 
bb=b(1:N-1); 
a=(B'*B+.0012*eye(1+N,1+N))\B'*bb;
yy=zeros(1,length(tt)); 
for ii=1:length(tt) 
    for jj=1:N+1 
        yy(ii)=yy(ii)+a(jj)*tt(ii)^(jj-1); 
    end 
end 
plot(tt,yy+0.2,'--r'); 
%%
%(4)方程个数小于未知数个数 
B=BltN; 
bb=b(1:N-1); 
%调整参数 gama 
gamma=.001712; 
a=(B'*B-gamma*eye(1+N,1+N))\B'*bb; 
yy=zeros(1,length(tt)); 
for ii=1:length(tt) 
    for jj=1:N+1 
        yy(ii)=yy(ii)+a(jj)*tt(ii)^(jj-1); 
    end 
end 
plot(tt,yy,'-g'); 
legend('普通最小二乘法抗干扰能力差','方程个数大于未知数个数','方程个数小于未知 数个数','TLS','Location','NorthWest'); 
text(0.5,0.2,['\alpha =' ,num2str(alpha)]);
text(0.5,0,['\beta =' ,num2str(beta)]);
text(0.5,-0.2,['\gamma =' ,num2str(gamma)]);


%% 以上部分可直接运行
% 数据实验3 （二）
% 谐波恢复函数. 
A   = []; % 第i个谐波的幅值
f   = []; % 第i个谐波的频率
phi = []; % 第i个谐波的相位

e = normrnd(0, 1);
for i = 1:n
    y = sigma(A(i) * sin(2*pi*f(i) + phi(i)) + e);
    svd(y);
end

% 后面有点没思路了。。。不知道该怎么确定特征根