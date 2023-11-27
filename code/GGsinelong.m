% Initialise variables globally over multiple functions
global range vsmax vsmin  

val = input("Which part do you wish to solve? Part 1 , 2 or 3: ");
if val == 1
    vsmax = 5.6;
elseif val == 2
    vsmax = 10.2;
elseif val == 3
    vsmax = 19;
else 
    print("Question 4 has only three parts, please try again. Try 1 , 2 or 3 this time")
    return
end
range = 500;

% Initialise the plot variables
vsplot = zeros(range,1); 
tsize = zeros(range,1); 
axisline = zeros(range,1); 

% Starting variables
X0 = zeros(3,1);
tspan = [0 range];
% Using ODE45 to solve the partial differential equations
options = odeset('RelTol',1e-5,'AbsTol',1e-5);
[t,X] = ode45(@CircadianFun2, tspan, X0); 
% Initialise the variables for the three functions 
M = X(:,1);
Fc = X(:,2);
Fn = X(:,3);

% Sine funstion that has maximum and minimum v_s at 6 ad 18 hours
% respectively
for k=1:range
    tsize(k,1)=k;
    vsplot(k,1)=0.5*(vsmax-vsmin)*sin((tsize(k,1)*pi)/12)+(vsmax+vsmin)/2;
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
plot(t, M, 'k', 'LineWidth', 1.5)
plot(tsize, axisline, 'k', 'LineWidth', 3)
xticks( 0 :24 : 500);
xlim([0 500])

if val == 1
% Visual line to show 24 hour periodicity for v_s = 5.6  
xline(181 : 24: length(M),'b:');
annotation('textbox',[0.2 0.5 0.3 0.3],'String',"24 hour periodicity",'FitBoxToText','on');
elseif val == 2
% Visual line to show 72 hour periodicity for v_s = 10.2    
xline(225 : 72: length(M),'b:')
annotation('textbox',[0.2 0.5 0.3 0.3],'String',"72 hour periodicity",'FitBoxToText','on');
elseif val == 3
% Visual line to show 92 hour periodicity for v_s = 19.1
xline(290 : 96: length(M),'b:');
annotation('textbox',[0.2 0.5 0.3 0.3],'String',"92 hour periodicity",'FitBoxToText','on');
end


% 24 hour step itervals matching the Gonze and Goldbeter paper
title(['Concentration of mRNA against time with v_s _{max}= ' num2str(vsmax)])
xlabel('time (h)')
ylabel('mRNA and vs')
legend('mRNA')
hold off