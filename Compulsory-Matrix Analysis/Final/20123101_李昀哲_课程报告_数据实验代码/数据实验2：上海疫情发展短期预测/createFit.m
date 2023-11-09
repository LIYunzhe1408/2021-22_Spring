% [作者]：李昀哲 20123101
% [日期]: 2022.6.2
% [描述]：本函数用于拟合曲线
% [基本思路]: 使用非线性最小二乘法拟合高斯函数
function [fitresult, goodness] = createFit(date_sampled, num_of_infected_sampled)
[xData, yData] = prepareCurveData( date_sampled, num_of_infected_sampled );

% 确定拟合方式和上下限等
fit_type = fittype( 'gauss1');
options = fitoptions( 'Method', 'NonlinearLeastSquares' );
options.Lower = [-Inf -Inf 0];
options.StartPoint = [25173 14 8.91227016419074];

% 使用Fit函数进行拟合
[fitresult, goodness] = fit( xData, yData, fit_type, options );

% 展示拟合
%figure( 'Name', 'new_positive_infected_curve' );
%h = plot( fitresult, xData, yData, 'predobs', 0.99 );
%legend( h, 'num_of_symptomatic_infected vs. x', 'new_positive_infected_curve', 'Lower bounds (new_positive_infected_curve)', 'Upper bounds (new_positive_infected_curve)', 'Location', 'NorthEast', 'Interpreter', 'none' );
% 坐标轴
%xlabel( 'x', 'Interpreter', 'none' );
%ylabel( 'num_of_symptomatic_infected', 'Interpreter', 'none' );
%grid on


