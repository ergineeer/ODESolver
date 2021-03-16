# ODESolver
Numerical Solution for Ordinary Differential Equations (IVP Problems)


  Included Methods:
- **Euler**, 
- **Ralston's Second-Order Runge-Kutta**, 
- **Fourth-Order Runge-Kutta**, 
- **Non-Self-Starting Heun**, 
- **Adams-Bashforth** as Open Predictor and **Adams-Moulton** as Closed Corrector.

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

Notice that Fourth-Order Runge Kutta Method is used to numerically determine several values for NSS Heun's Method and Fourth-Order Adams (Adams-Bashforth and Adams-Moulton).

Thanks.
