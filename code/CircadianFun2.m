function f = CircadianFun2(t,X)

f = zeros(3,1);

global n vs vm vd KI Km Ks Kd k1 k2 vsmin vsmax

%calculation of v_s for a sinusoidal wave

vs=0.5*(vsmax-vsmin)*sin((t*pi)/12)+(vsmax+vsmin)/2;

f(1)=vs*((KI^n)/(KI^n+X(3)^n))-vm*(X(1)/(Km+X(1))); %f(1) is dMdt

f(2)=Ks*X(1)-vd*(X(2)/(Kd+X(2)))-k1*X(2)+k2*X(3); %f(2) is dFcdt

f(3)=k1*X(2)-k2*X(3); %f(3) is dFndt

end