function [dO] = A2_2_ODEFunction(t,O)

% Developed by Aaron John Sabu for ME6102 (Design of Mechatronic Systems) under Prof Prasanna Gandhi
% ODEFunction: This function is used to solve the ODEs related to a double pendulum 
% The double pendulum consists of a fixed pendulum which has a flexible massless rod and a mobile pendulum which has a rigid massless rod.

l0  = 0.5;
l1  = 0.3;
m0  = 0.02;
m1  = 0.03;
k   = 1;
g   = 9.81;
e00 = 40.0*pi/180.0;
e10 = 10.0*pi/180.0;

dO    = zeros(6,1);

dO(1) = O(2);
dO(2) = -(1/(m0+m1))*( (m1*l1*( (dO(6)*cos(O(5)))-(dO(5)*dO(5)*sin(O(5))) )) + k*O(1) - k*l0*O(1)/(((O(1)*O(1))+(O(3)*O(3)))^0.5) );
dO(3) = O(4);
dO(4) = -(1/(m0+m1))*( (m1*l1*( (dO(5)*dO(5)*cos(O(5)))-(dO(6)*sin(O(5))) )) + k*O(3) - k*l0*O(3)/(((O(1)*O(1))+(O(3)*O(3)))^0.5) + (m0+m1)*g );
dO(5) = O(6);
dO(6) = -(1/(l1))*( 2*dO(5)*dO(3)*cos(O(5))+dO(2)*cos(O(5))+dO(4)*sin(O(5)) + g*sin(O(5)) );

end