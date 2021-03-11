# ODESolver
Numerical Solution for Ordinary Differential Equations (IVP Problems)


  Included Methods:
- **Euler**, 
- **Ralston's Second-Order Runge-Kutta**, 
- **Fourth-Order Runge-Kutta**, 
- **Non-Self-Starting Heun**, 
- **Adams-Bashforts** as Open Predictor and **Adams-Moulton** as Closed Corrector.

# Usage
ODESolver(eqn,xInit,yInit,xMax,intervalNumb,method);
where 
 
- eqn: Differential Equation
- xInit: Initial x value
- yInit: Initial y value
- xMax: Maximum x value (for inteval)
- intervalNumb: Number of intervals
- method: Numerical method ("---")
- Example: ODESolver(f,0,1,3,50,"all") where f=@(x,y) x*y or anything

# Testing
Function is tested for f=@(x,y) x*y and output is provided below. Euler's method has much bigger values than the other methods in an expected way. 
![figure](https://user-images.githubusercontent.com/80001281/110864563-5f173980-82d3-11eb-8257-52e27345e703.png)

Thanks.
