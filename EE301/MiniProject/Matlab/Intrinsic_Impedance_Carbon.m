close all
clear all
clc

syms omega;

epsilon_0 = 8.8541878*(10^(-12));
mu_0      = 4*pi*(10^(-7));
epsilon_r = [1 7.75 12.5];
mu_r      = [1 1-(2.1*(10^(-5))) 1-(1.6*(10^(-5)))];
epsilon   = epsilon_0*epsilon_r;
mu        = mu_0*mu_r;
cond      = [0 (10^(-13)) 250000];

omega_1   = [1.0; 2.0; 5.0];
omega_2   = [10^(-10) 10^(-9) 10^(-8) 10^(-7) 10^(-6) 10^(-5) 10^(-4) 10^(-3) 10^(-2) 10^(-1) 10^(0) 10^(1) 10^(2) 10^(3) 10^(4) 10^(5) 10^(6) 10^(7) 10^(8) 10^(9) 10^(10) 10^(11) 10^(12) 10^(13) 10^(14) 10^(15) 10^(16) 10^(17) 10^(18) 10^(19) 10^(20) 10^(21) 10^(22)];
% omega_2   = [10^(-10) 10^(-9) 10^(-8) 10^(-7) 10^(-6) 10^(-5) 10^(-4) 10^(-3)];
omega = reshape(omega_1*omega_2, length(omega_1)*length(omega_2), 1);

intr_imp = zeros(size(omega));
for mat = 1:3
    for num = 1:size(omega)
        intr_imp(num,mat) = abs(((1j*omega(num)*mu(mat))/(cond(mat)+(1j*omega(num)*epsilon(mat))))^0.5);
    end
end

% plot(log(omega), log(intr_imp));
plot(log(omega), log(intr_imp(:,2)));