% Initialise variables globally over multiple functions
global range vsmax vsmin  

range = 300;
vsmin = 1.6;
vsmax = 2.2; 

% Initialise the plot variables
vsplot = zeros(range,1); 
tsize = zeros(range,1); 
axisline = zeros(range,1); 

% Starting variables
X0 = zeros(3,1);
tspan = [0 range];

% Using ODE45 to solve the partial differential equations 
options = odeset('RelTol',1e-5,'AbsTol',1e-5);
[t,X] = ode45(@CircadianFun1, tspan, X0); 

% Initialise the variables for the three functions 
M = X(:,1);
Fc = X(:,2);
Fn = X(:,3);

% Loop that varies vs in a square function every 12 hours having a full loop
% every 24 hours
for i = 1:range
   tsize(i, 1) = i;
    if mod(i - 1 , 24) > 12 
        vsplot(i, 1) = vsmin;
    elseif mod(i - 1, 24) <= 12
        vsplot(i,1) = vsmax;
    end
end

% Visual axis indicator, the -1 is due to MATLAB having the first index as
% 1 not 0
for j=1:range
    tsize(j, 1) = j;
    if mod(j - 1 ,24) > 12 
        axisline(j, 1) = 0;
    elseif mod(j - 1, 24) <= 12
        axisline(j,1) = NaN;
    end
end

% Plotting results
hold on
% Skipping 24 hours whilst the system settles to its 24 hour periodicity
% similar to how is done in Gonze and Goldbeter
plot(t - 24, M, 'k', 'LineWidth', 1.5)
plot(tsize, vsplot, 'r:', 'LineWidth', 1.5)
plot(tsize, axisline, 'k', 'LineWidth', 5)
% 24 hour step itervals matching the Gonze and Goldbeter paper
xticks( 0 :24 : 192);
xlim([0 192])
title(['Concentration of mRNA against time with v_s _{max}= ' num2str(vsmax)])
xlabel('time (h)')
ylabel('mRNA and vs')
legend('mRNA', 'vs')
hold off