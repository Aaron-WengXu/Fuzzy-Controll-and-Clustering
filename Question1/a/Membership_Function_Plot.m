clc;
clear;

y = -100:0.01:100;
figure;
plot(y, fy1(y),'LineWidth',1.5);hold on;


plot(y, fy2(y),'LineWidth',1.5);hold on;

plot(y, fy3(y),'LineWidth',1.5);hold on;

plot(y, fy4(y),'LineWidth',1.5);hold on;

plot(y, fy5(y),'LineWidth',1.5);hold on;grid on;
legend({'BE','BC','CE','AC','AB'},'FontName','Times New Roman','FontSize',10.5);
xlabel('\ity','FontName','Times New Roman','FontSize',10.5);
ylabel('Membership Functions of {\ity}','FontName','Times New Roman','FontSize',10.5);