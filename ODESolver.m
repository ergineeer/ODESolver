%
% Works But Not Complete Yet
% 12/03/2021
%
% % % % % % % 
  
function [] = ODESolver(eqn,xInit,yInit,xMax,intervalNumb,method);
    xVals = transpose(linspace(xInit,xMax,intervalNumb));
    yVals = zeros(size(xVals));
    yVals(1) = yInit;
    colorMatrix = (jet(5));
    if contains(method,["Euler","Ralston","FourthRK","Heun","Adams","All"],"IgnoreCase", true)==0
        fprintf('\nInvalid Method Selection.\n')
        return
    end
%% Euler (First Order Runge-Kutta)
    if contains(method,["Euler","All"],"IgnoreCase", true)==1
        for i=2:length(xVals)
            stepSize = xVals(i,1)-xVals(i-1,1);
            k1 = eqn(xVals(i-1,1),yVals(i-1,1));
            yVals(i,1) = yVals(i-1,1) + stepSize*k1;
        end
        plot(xVals,yVals,'Color',colorMatrix(1,:)); 
        hold all; grid on;
    end
%% Ralston's Second Order Runge-Kutta (A = 2/3)
    if contains(method,["Ralston","All"],"IgnoreCase", true)==1
        for i=2:length(xVals)
            stepSize = xVals(i,1)-xVals(i-1,1);
            k1 = eqn(xVals(i-1,1),yVals(i-1,1));
            k2 =  eqn(xVals(i-1,1)+3*stepSize/4,yVals(i-1,1)+3*stepSize*k1/4);
            yVals(i,1) = yVals(i-1,1)+stepSize*(k1/3+2*k2/3);
        end
        plot(xVals,yVals,'Color',colorMatrix(2,:));
        hold all; grid on;
    end
%% Classical Fourth Order Runge-Kutta
    if contains(method,["FourthRK","All"],"IgnoreCase", true)==1
        yVals = zeros(size(xVals));
        yVals(1) = yInit;
        for i=2:length(xVals)
            stepSize = xVals(i,1)-xVals(i-1,1);
            k1 = eqn(xVals(i-1,1) , yVals(i-1,1));
            k2 =  eqn(xVals(i-1,1)+stepSize/2 , yVals(i-1,1)+stepSize*k1/2);
            k3 =  eqn(xVals(i-1,1)+stepSize/2 , yVals(i-1,1)+stepSize*k2/2);
            k4 =  eqn(xVals(i-1,1)+stepSize , yVals(i-1,1)+stepSize*k3);
            yVals(i,1) = yVals(i-1,1) + stepSize*(k1 + 2*k2 + 2*k3 + k4)/6;
        end
        plot(xVals,yVals,'Color',colorMatrix(3,:))
        hold all; grid on;
    end
    %% Non-Self-Starting Heun's Method
    if contains(method,["Heun","All"],"IgnoreCase", true)==1
        yCorrector = zeros(size(xVals));
        yCorrector(1) = yInit;
        for i=2:4
            stepSize = xVals(i,1)-xVals(i-1,1);
            k1 = eqn(xVals(i-1,1) , yCorrector(i-1,1));
            k2 =  eqn(xVals(i-1,1)+stepSize/2 , yCorrector(i-1,1)+stepSize*k1/2);
            k3 =  eqn(xVals(i-1,1)+stepSize/2 , yCorrector(i-1,1)+stepSize*k2/2);
            k4 =  eqn(xVals(i-1,1)+stepSize , yCorrector(i-1,1)+stepSize*k3);
            yCorrector(i,1) = yCorrector(i-1,1) + stepSize*(k1 + 2*k2 + 2*k3 + k4)/6;
        end
        yPredictor = yCorrector;
        for i=4:length(xVals)  
            yPredictor(i,1) = yCorrector(i-2,1) + 2*stepSize*eqn(xVals(i-1,1),yCorrector(i-1,1));
            yCorrector(i,1) = yCorrector(i-1,1) + stepSize*(eqn(xVals(i-1,1),yCorrector(i-1,1)) + eqn(xVals(i,1),yPredictor(i,1)))/2;
        end
        plot(xVals,yCorrector,'Color',colorMatrix(4,:),'DisplayName','NSS Heun')
        hold all; grid on;
    end
%% Predictor-Corrector Multi-Step Method for ODE's
    if contains(method,["Adams","All"],"IgnoreCase", true)==1
        yCorrector = zeros(size(xVals));
        yCorrector(1) = yInit;
        for i=2:4
            stepSize = xVals(i,1)-xVals(i-1,1);
            k1 = eqn(xVals(i-1,1) , yCorrector(i-1,1));
            k2 =  eqn(xVals(i-1,1)+stepSize/2 , yCorrector(i-1,1)+stepSize*k1/2);
            k3 =  eqn(xVals(i-1,1)+stepSize/2 , yCorrector(i-1,1)+stepSize*k2/2);
            k4 =  eqn(xVals(i-1,1)+stepSize , yCorrector(i-1,1)+stepSize*k3);
            yCorrector(i,1) = yCorrector(i-1,1) + stepSize*(k1 + 2*k2 + 2*k3 + k4)/6;
        end
        yPredictor = yCorrector;
        for i=5:length(xVals)  
            stepSize = xVals(i,1)-xVals(i-1,1);
            yPredictor(i,1) = yCorrector(i-1,1) + stepSize*(55*eqn(xVals(i-1,1),yCorrector(i-1,1))/24 - ...
                59*eqn(xVals(i-2,1),yCorrector(i-2,1))/24 + 37*eqn(xVals(i-3,1),yCorrector(i-3,1))/24 - 9*eqn(xVals(i-4,1),yCorrector(i-4,1))/24 );
            yCorrector(i,1) = yCorrector(i-1,1) + stepSize*(9*eqn(xVals(i,1),yPredictor(i,1))/24  + ...
                19*eqn(xVals(i-1,1),yCorrector(i-1,1))/24 - 5*eqn(xVals(i-2,1),yCorrector(i-2,1))/24 + eqn(xVals(i-3,1),yCorrector(i-3,1))/24);

        end
        plot(xVals,yCorrector,'Color',colorMatrix(5,:))
        hold all; grid on;
    end
    
    legendIDX = zeros(1,5);
    if contains(method,"Euler","IgnoreCase", true)==1
        legendIDX(1,1) = 1;
    elseif contains(method,"Ralston","IgnoreCase", true)==1
        legendIDX(1,2) = 1;
    elseif contains(method,"FourthRK","IgnoreCase", true)==1
        legendIDX(1,3) = 1;
    elseif contains(method,"Heun","IgnoreCase", true)==1
        legendIDX(1,4) = 1;
    elseif contains(method,"Adams","IgnoreCase", true)==1
        legendIDX(1,5) = 1;
    elseif contains(method,"All","IgnoreCase", true)==1
        legendIDX(1,1:5) = 1;
    end
    legendStrs = ["Euler","Ralstons Second-Order RK","Fourth-Order RK","NSS Heun","Fourth-Order Adams"];
    legendStrs = legendStrs(logical(legendIDX));
    legend(legendStrs,'Location','northwest');
    title('Numerical Solution for Input Ordinary Differential Equation');
end

