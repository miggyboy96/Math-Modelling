global vs 
vs = input("What is the value of vs? "); 

% code to stop values other than 1.6 or 2.2
if vs ~= 1.6 && vs ~=2.2
    print("Please choose 1.6 or 2.2 for the dark and light case")
    quit
end

% Starting variables
range = 300;
X0 = zeros(3,1);
tspan = [0 range];

% Using ODE45 to solve the partial differential equations 
options = odeset('RelTol',1e-5,'AbsTol',1e-7);
[t,X] = ode45(@fun, tspan, X0); 

% Initialise the plot variables
vsplot = zeros(range,1); 
tsize = zeros(range,1); 
axisline = zeros(range,1); 

% Initialise the variables for the three functions 
M = X(:,1);
Fc = X(:,2);
Fn = X(:,3);

% Couting through every time step initialising the plot of vs
for i = 1:range
   tsize(i, 1) = i;
   vsplot(i, 1) = vs;
end
% The visual axis identify that shows if it is light or dark
for j=1:range
    tsize(j, 1) = j;
    if vs == 1.6 
        axisline(j, 1) = 0;
    elseif vs == 2.2
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
title(['Concentration of mRNA against time with v_s = ' num2str(vs)])
xlabel('time (h)')
ylabel('mRNA and vs')
legend('mRNA', 'vs')
hold off
function f = fun(~,X)

global vs n vm vd KI Km Ks Kd k1 k2

f = zeros(3,1);
f(1)= vs.*((KI .^ n)/(KI .^n + X(3).^ n))- vm .*(X(1)/(Km+X(1))); %f(1) is dMdt
 
f(2)= Ks.*X(1)-vd*(X(2)/(Kd+X(2)))-k1*X(2)+k2*X(3); %f(2) is dFcdt

f(3)= k1.*X(2)-k2.*X(3); %f(3) is dFndt
end
