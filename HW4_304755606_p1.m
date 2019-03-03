%Problem 1 Pendulum
%David Curry
%ID: 304755606
clear all;
clc;
%define constants
g = 9.81;
L = 1;
%set the change in time, the time array, nd the total number of steps
delta_t = 0.005;
t_steps = 20/delta_t;
t = linspace(0,20,t_steps);
%create a 4000 slot array filled with zeros for the explicit way
w = zeros(1,t_steps);
theta = zeros(1,t_steps);
acc = zeros(1,t_steps);
%create arrays for the implicit way
w2 = zeros(1,t_steps);
theta2 = zeros(1,t_steps);
acc2 = zeros(1,t_steps);
%set initial conditions
theta(1) = pi/3;
w(1) = 0;
theta2(1) = pi/3;
w2(1) = 0;
%make a 4000 slot array filled with zeros for h and Energy
h = zeros(1,t_steps);
Energy = zeros(1,t_steps);
%make a 4000 slot array filled with zeros for the implicit h and energy
h2 = zeros(1,t_steps);
Energy2 = zeros(1,t_steps);

%loop to set all the values of each array
for k = 1:t_steps - 1
    %explicit way
    w(k+1) = -delta_t*(g/L)*sin(theta(k)) + w(k);
    theta(k+1) = delta_t*w(k) + theta(k);
    acc(k) = -(g/L)*sin(theta(k));
    h(k) = L - cos(theta(k))*L ;
    Energy(k) = g*h(k) + (.5*(L*w(k))^2);
    
    w(k) = w(k+1);
    theta(k) = theta(k+1);
    
    %implicit way
    theta2(k+1) = -delta_t^2*(g/L)*sin(theta2(k)) + delta_t*w2(k) + theta2(k);
    w2(k+1) = (theta2(k+1) - theta2(k))/delta_t;
    acc2(k) = -(g/L)*sin(theta2(k));
    h2(k) = L - cos(theta2(k))*L ;
    Energy2(k) = g*h2(k) + (.5*(L*w2(k))^2);
    
    w2(k) = w2(k+1);
    theta2(k) = theta2(k+1);
end

%plot all three curves on one graph
plot(t,theta, t, w, t, acc);
xlabel('Time (s)');
ylabel('Position (rad), Velocity (rad/s) , Acceleration (rad/s^2)');
title('Explicit Angular Position, Velocity, and Acceleration over Time');
legend('Position','Velocity', 'Acceleration');
%plot the energy vs time
figure;
plot(t,Energy);
xlabel('Time (s)');
ylabel('Energy (J)')
title('Explicit Energy over Time');
figure;
%plot the implict data on one graph
plot(t, theta2, t, w2, t, acc2);
xlabel('Time (s)');
ylabel('Position (rad), Velocity (rad/s) , Acceleration (rad/s^2)');
title('Implicit Angular Position, Velocity, and Acceleration over Time');
legend('Position','Velocity', 'Acceleration');
figure;
%plot the implicit energy vs time
plot(t,Energy2);
xlabel('Time (s)');
ylabel('Energy (J)')
title('Implicit Energy over Time');

