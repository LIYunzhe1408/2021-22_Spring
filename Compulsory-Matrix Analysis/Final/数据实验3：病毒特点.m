% [作者]：李昀哲 20123101
% [日期]: 2022.6.7
% [描述]：本脚本用于对奥密克戎病毒特点进行分析
% [基本思路]: 1. 分析感染率，已由数据实验2给出
%            2. 分析致死率
%            3. 评判每年死亡率，观察死亡率和新冠致死关系

% [描述]：读入
data_of_confirmed_and_infected = xlsread("上海疫情数据.xlsx", "上海确诊和感染");
birth_death                    = xlsread("上海疫情数据.xlsx","出生率");

% [描述]：提取表中数据
date_axis                   = 1:size(data_of_confirmed_and_infected);
num_of_confirmed            = data_of_confirmed_and_infected(:,2);  % 确诊人数
num_of_symptomatic_infected = data_of_confirmed_and_infected(:, 3); % 无症状感染者
num_of_death                = data_of_confirmed_and_infected(:, 4); % 病亡
num_of_recovered            = data_of_confirmed_and_infected(:, 5); % 康复

% [描述]：计算病死率
death_rate_of_COV = sum(num_of_death) * 100 / (sum(num_of_symptomatic_infected) + sum(num_of_confirmed));
disp(["病亡占比：", death_rate_of_COV]);

% [描述]：准备出生、死亡、年份信息
birth_rate = birth_death(:,3)./1000; % 各年出生率
birth_rate = rot90(birth_rate);
birth_rate = rot90(birth_rate);
death_rate = birth_death(:,4)./1000; % 各年死亡率
death_rate = rot90(death_rate);
death_rate = rot90(death_rate);
year_info  = size(birth_death, 1);

% [描述]：展示近20年出生-死亡率
plot(1:year_info, birth_rate);
hold on
plot(1:year_info, death_rate);
xlabel("20xx年")
ylabel("比率")
legend("出生率", "死亡率")


