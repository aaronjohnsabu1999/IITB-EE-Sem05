%% Developed by Aaron John Sabu for ME6102 under Prof Prasanna Gandhi

clc;
clear all;

l0  = 0.5;
l1  = 0.3;
m0  = 0.02;
m1  = 0.03;
k   = 1;
g   = 9.81;
e00 = (-90.0+40.0)*pi/180.0;
e10 = (-90.0+10.0)*pi/180.0;

time  = linspace(0,100,5000)';
IC    = [l1*cos(e00); 0; l1*sin(e00); 0; e10; 0];
[t,y] = ode45('A2_2_ODEFunction',time,IC);

%% Plot of generalised coordinates w.r.t. time

plot(t,y(:,1),'r')
hold on
plot(t,y(:,3),'b')
title('Pendulum with Non-Linear Spring');
xlabel('Time t');
ylabel('Solution y');
legend('theta','r')

%% Animation

figure
O    = [0 0];
axis(gca,'equal');
axis([-1.0 1.0 -2.0 1.0]);
grid on;
origincircle = viscircles(O,0.001);

for j = 1:5
    for i = 1:length(t)
        P1           = [y(i,1), y(i,3)];
        P2           = [y(i,1), y(i,3)]+[l1*cos(y(i,5)), l1*sin(y(i,5))];
        pendulum1    = line([O(1)  P1(1)],[O(2)  P1(2)], 'LineWidth',5);
        pendulum2    = line([P1(1) P2(1)],[P1(2) P2(2)], 'LineWidth',5);
        bob1         = line([P1(1) P1(1)],[P1(2) P1(2)], 'Marker','o','MarkerSize',13,'MarkerFaceColor','r');
        bob2         = line([P2(1) P2(1)],[P2(2) P2(2)], 'Marker','o','MarkerSize',13,'MarkerFaceColor','b');
        ball1        = viscircles(P1, 0.007);
        ball2        = viscircles(P2, 0.007);
        pause(0.0001);
        if i<length(t)
            delete(pendulum1);
            delete(bob1);
            delete(ball1);
            delete(pendulum2);
            delete(bob2);
            delete(ball2);
        end
    end
break;
end