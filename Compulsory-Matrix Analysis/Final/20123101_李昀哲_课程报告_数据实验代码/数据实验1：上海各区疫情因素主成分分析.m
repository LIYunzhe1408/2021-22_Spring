% [作者]：李昀哲 20123101
% [日期]: 2022.6.2
% [描述]：本脚本用于对上海各区疫情影响因素进行主成分分析
% [基本思路]: 算法使用svd分解，使用pca函数进行主成分分析
% [注记]: 程序可直接复制于命令行运行，将会展示主成分分析结果
data_of_Shanghai_district = xlsread("上海疫情数据.xlsx", "各区信息");
S =size(data_of_Shanghai_district); 

% [描述]：提取信息
num_of_district = S(1);    % 上海区县个数 
population      = data_of_Shanghai_district(:, 1); % 人口
district_area   = data_of_Shanghai_district(:, 2); % 区域面积
porpotion_up_60 = data_of_Shanghai_district(:, 3); % 60以上人口
x_axis          = 1:S;     % x轴

% [描述]：PCA分析
[svd_coeff,svd_score,svd_latent,svd_tsquared,svd_explained] = pca(data_of_Shanghai_district,'Algorithm','svd','Centered',true) ;
figure() 
names = {'population', 'area', 'up60', 'GDP'};
pareto(svd_explained, names, 1);
xlabel('Principal Component');
ylabel('Variance Explained (%)');










% 以下为分步骤尝试内容，可忽略
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 计算均值
population_mean = mean(population);         % 155.3188
district_area_mean = mean(district_area);   % 413.75
porpotion_up_60_mean = mean(porpotion_up_60); %

% 降维：计算方差
% 不是独立的，计算协方差，得到协方差矩阵
% cov(x,y) = A*A' / n-1
scatter(porpotion_up_60 - porpotion_up_60_mean, district_area - district_area_mean);


% 归一化，使数据在同一个数量级
population_normalize    = population / max(population);
district_area_normalize = district_area / max(district_area);

% show图像
scatter(x_axis, district_area);
hold on
scatter(x_axis, population);
legend("区县面积", "人口")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%