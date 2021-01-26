% Prasanna Gandhi
% This is a code written to simulate rubber pendulum. Pendulum parameters
% are given in the function file. This program gives you animated look for
% the pendulum. 
% 
clc;
clear all;

% resolution 0 to 100s in 5000 steps
time = linspace(0,10,1000)';
% Initial Conditions  
IC = [-pi/3; 0; 0.05; 0];
% Solve using ode45
[t,y] = ode45('stringpendulum_function_1',time,IC);

%{
%%Plot of generalised coordinates w.r.t. time
plot(t,y(:,1),'r')
hold on
plot(t,y(:,3),'b')
title('Pendulum with Non-Linear Spring');
xlabel('Time t');
ylabel('Solution y');
legend('theta','r')
%}

%% animation
figure
O =[0 0];% origin or pivot point
axis(gca,'equal');% aspect ratio of the plot
axis([-0.2 0.2 -0.25 0.1]); % XY bounds
grid on;

% Loop for animation
for i = 1:length(t)
    % mass point
    P = (0.2+y(i,3))*[sin(y(i,1)), -cos(y(i,1))];
    % circle at origin or pivot point
    %origincircle = viscircles(O,0.001);
    % Pendulum String joining pivot and current solution
    pendulum = line([O(1) P(1)],[O(2) P(2)], 'LineWidth',5);
    bob = line([P(1) P(1)],[P(2) P(2)], 'Marker','o','MarkerSize',25,'MarkerFaceColor','r');
    % ball
    %ball = viscircles(P, 0.007);
    % time interval to update the plot
    pause(0.05);
    %clear screen of previous pendulum position
    if i<length(t)
        %delete(origincircle);
        delete(pendulum);
        delete(bob);
        %delete(ball);
    end
end

