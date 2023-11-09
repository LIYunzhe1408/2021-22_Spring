data_of_confirmed_and_infected = xlsread("上海疫情数据.xlsx", "上海确诊和感染");


% 提取表中数据
date_axis                   = 1:size(data_of_confirmed_and_infected);
num_of_confirmed            = data_of_confirmed_and_infected(:,2);  % 确诊人数
num_of_symptomatic_infected = data_of_confirmed_and_infected(:, 3); % 无症状感染者
num_of_death                = data_of_confirmed_and_infected(:, 4); % 病亡
num_of_recovered            = data_of_confirmed_and_infected(:, 5); % 康复

% 数据量级差别太大->进行归一化处理
normalized_symptomatic_infected = num_of_symptomatic_infected / max(num_of_symptomatic_infected);
normalized_confirmed            = num_of_confirmed            / max(num_of_confirmed);
normalized_death                = num_of_death                / max(num_of_death);
normalized_recovered            = num_of_recovered            / max(num_of_recovered);



% show 原始数据
figure
plot(date_axis, num_of_symptomatic_infected, Color='red');
hold on
plot(date_axis, num_of_confirmed, Color='magenta');
hold on
plot(date_axis, num_of_recovered, Color='black');
legend("无症状感染者", "确诊", "出舱");

figure
plot(date_axis, num_of_death, Color='black');
legend("病亡")


% show 归一化数据
figure
plot(date_axis, normalized_symptomatic_infected, Color='red');
hold on
plot(date_axis, normalized_confirmed,            Color='magenta');
hold on
plot(date_axis, normalized_death,                Color='black');
legend("无症状感染者", "确诊", "病亡");
