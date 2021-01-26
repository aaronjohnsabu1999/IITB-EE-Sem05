function [ dy ] = stringpendulum_function_1( t,y )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% These parameters should be actually in a different file and defined as
% global variables to be shared (since this is small simulation we can
% afford to spend time in trivially defining them every time) 
m=0.03;
rm=0.007;
l=0.2;
ko=25;
k1=150;
g=9.81;
zeta=0.002;

Btheta=2*zeta*sqrt(m^2*g*l^3);
Br=2*zeta*sqrt(m*(ko+k1*y(3)^2))*0;

dy = zeros(4,1);
dy(1) = y(2);
dy(2) = (-2*m*y(2)*y(4)*(l+y(3))-m*g*(l+y(3))*sin(y(1))-y(2)*Btheta)/(m*(l+y(3))^2+0.4*m*rm^2);
dy(3) = y(4);
dy(4) = (m*(l+y(3))*y(2)^2-ko*y(3)-k1*(y(3)^3)+m*g*cos(y(1))-y(4)*Br)/m;
 end

