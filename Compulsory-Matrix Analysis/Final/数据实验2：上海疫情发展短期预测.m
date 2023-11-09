% [作者]：李昀哲 20123101
% [日期]: 2022.6.2
% [描述]：本脚本用于对上海疫情进行短期（三天）预测
% [基本思路]: 1. 采集自3月28日以来14天的每日新增感染者数据；
%            2. 进行最小二乘拟合，拟合Gauss函数；预测之后三天数据
%            3. 随后的每一天都将当天数据加入历史数据集用于更正曲线的拟合，同时展示后三天的预测数据。
% [参数]:
%       date_want_to show: 可选择查看某一天的预测情况。(可在后续修改）
% [注记]: 程序可直接复制于命令行运行，将会展示初始预测结果（14天时预测15-17天）以及想要查看的某一天的预测结果。
%         同时在最后展示用所有数据拟合结果。
date_want_to_know = 40;



% [描述]: 读取自2020年3月28日以来，60天的每日感染数据
data_of_confirmed_and_infected = xlsread("上海疫情数据.xlsx", "上海确诊和感染");

% [描述]: 定义数据：日期、每日新增感染者人数、初始拟合采样个数（14）
date_axis       = 1:size(data_of_confirmed_and_infected); % 日期
num_of_infected = data_of_confirmed_and_infected(:, 3);   % 无症状感染者
sample_infected = num_of_infected(1:14);                  % 采样当天的感染者人数
sample_date     = 1:14;                                   % 采样日期

% [描述]: 最小二乘拟合，
%         猜测为Gaussian函数：y =  a1*exp(-((i-b1)/c1)^2);
[result, goodness] = createFit(sample_date, sample_infected); % 得到拟合结果参数和评判参数（方差等）
short_term_param = [result.a1, result.b1, result.c1];


% [描述]: 参数代入，进行短期预测
short_term_y = short_term_param(1)*exp(-((date_axis(:, 1:17)-short_term_param(2))/short_term_param(3)).^2);
syms x y;
y = short_term_param(1)*exp(-((x-short_term_param(2))/short_term_param(3)).^2);
point = solve(diff(y));

% [描述]: 计算短期预测和实际值的方差
varience_first14 = 0;
fit_y = short_term_param(1)*exp(-((date_axis-short_term_param(2))/short_term_param(3)).^2);
for cnt = 1:60
      varience_first14 = varience_first14 + (fit_y(cnt)- num_of_infected(cnt))^2;
end
varience_first14 = sqrt(varience_first14 / 60);

% [描述]: 展示拟合曲线，和未来三天预测结果和实际结果。
% [注记]: 预测结果为红线，离散点为实际结果。
figure ('Name', 'day 14');
plot(date_axis(:, 15:17), num_of_infected(15:17), 'o');   % 实际感染人数，离散点
hold on
plot(date_axis(:, 1:17), short_term_y(:, 1:17), 'blue')   % 拟合之曲线
hold on
plot(date_axis(:, 15:17), short_term_y(:, 15:17), 'red'); % 预测之感染人数
xlabel('Days after 3.28');
ylabel('Infected Amount');
legend("当天实际感染人数","拟合曲线","预测当天感染人数")


% [描述]: 对之后的每一天数据，加入历史数据集进行更正拟合；
%         每一天都会生成新的，对后三天的预测；
% [注记]: 代码内容和上述类似部分省略注释。
% [参数]:
%        date_want_to show: 可选择查看某一天的预测情况。
%date_want_to_know = 30;

for date = 14:57
    sample_date = [sample_date date];
    sample_infected = [sample_infected; num_of_infected(date)];
    [result, goodness] = createFit(sample_date, sample_infected);
    short_term_param = [result.a1, result.b1, result.c1];
    % y =  a1*exp(-((i-b1)/c1)^2);
    short_term_y = short_term_param(1)*exp(-((date_axis(:, 1:date+3)-short_term_param(2))/short_term_param(3)).^2);
    if date == date_want_to_know
        varience = 0;
        fit_y = short_term_param(1)*exp(-((date_axis-short_term_param(2))/short_term_param(3)).^2);
        for cnt = 1:60
            varience = varience + (fit_y(cnt)- num_of_infected(cnt))^2;
        end
        varience = sqrt(varience / 60);
        figure ('Name', ['day',num2str(date)]);
        plot(date_axis(:, date+1:date+3), num_of_infected(date+1:date+3), 'o');
        hold on
        plot(date_axis(:, 1:date+3), short_term_y(:, 1:date+3), 'blue')
        hold on
        plot(date_axis(:, date+1:date+3), short_term_y(:, date+1:date+3), 'red');
        xlabel('Days after 3.28');
        ylabel('Infected Amount');
        legend("当天实际感染人数","拟合曲线","预测当天感染人数")
    end
end


disp(["14天拟合方差：", varience_first14]);
disp([date_want_to_know,"天拟合方差：",double(varience)]);
disp(["预测拐点日期：3月28日后的",double(point), "天"]);
disp(["实际拐点日期：3月28日后的",17           , "天"]);
%x = 1:1:60;
%y =  a1*exp(-((x-b1)/c1)^2);
%plot(x, num_of_infected)
%hold on
%plot(x, y2, 'black')
%legend("实际", "预测", "全部数据拟合")



