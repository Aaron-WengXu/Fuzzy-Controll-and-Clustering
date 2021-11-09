clc;
clear;

v = 0.5; % m/s
L = 2.5; % m
T = 0.1; % s
u_range = -30:1:30;

theta = 0; % degree
theta = theta/180*pi; %rad
y = 40; % m
x = 20; % m

dy = 0; % desired y
dtheta = 0; % desired theta

ey = dy - y;
etheta = dtheta - theta;

xplot(1) = x;
yplot(1) = y;
thetaplot(1) = theta;
i = 2;

while abs(ey) > 0.01 || abs(etheta) > 0.01           
    % Calculate control action using Fuzzy Controller
    u = FuzzyController(theta,y, u_range); %degree
    u = clip(u,-30,30);
    u = u/180*pi;
   
    % Updating System  
    x = x + v*T*cos(theta);
    y = y + v*T*sin(theta);
    y = clip(y,-100,100);

    theta = theta + v*T*tan(u)/L;
    theta = mod(theta + pi,2*pi)-pi; % theta is in [-pi,pi]
    
    % Store data for plotting
    xplot(i) = x;
    yplot(i) = y;
    uplot(i-1) = u;
    thetaplot(i) = theta;
    i = i+1;
    
    % Error Updating
    ey = dy - y;
    etheta = dtheta - theta;
end

figure;
plot(yplot,'LineWidth',1.5);
xlabel("Epoch",'FontName','Times New Roman','FontSize',10.5);
ylabel("{\ity} (m)",'FontName','Times New Roman','FontSize',10.5);
grid on;

figure;
plot(thetaplot,'LineWidth',1.5);
xlabel("Epoch",'FontName','Times New Roman','FontSize',10.5);
ylabel("{\it\theta} (rad)",'FontName','Times New Roman','FontSize',10.5);
grid on;

figure;
plot(xplot);
xlabel("Epoch");
ylabel("x");
grid on;

figure;
plot(uplot,'LineWidth',1.5);
xlabel("Epoch",'FontName','Times New Roman','FontSize',10.5);
ylabel("{\itu} (rad)",'FontName','Times New Roman','FontSize',10.5);
grid on;