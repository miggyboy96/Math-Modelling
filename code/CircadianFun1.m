function f = CircadianFun1(t,X)

% Inisialise the function for the three differential equations
f = zeros(3,1);

global n vs vm vd KI Km Ks Kd k1 k2 vsmin vsmax

%calculation of v_s for a square wave, with since MATLAB has the first
%index as 1 rather than 0

if mod(t - 1,24) > 12 
    vs=vsmin;
elseif mod(t - 1,24) <= 12
    vs=vsmax;
end

f(1)= vs.*((KI .^ n)/(KI .^n + X(3).^ n))- vm .*(X(1)/(Km+X(1))); %f(1) is dMdt
 
f(2)= Ks.*X(1)-vd*(X(2)/(Kd+X(2)))-k1*X(2)+k2*X(3); %f(2) is dFcdt

f(3)= k1.*X(2)-k2.*X(3); %f(3) is dFndt

end