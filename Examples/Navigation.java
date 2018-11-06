import java.util.*;
// Example class for solving the KNW2300 robot beacon navigation
// system. This example code takes the two measured beacon angles off of
// the command line and displays the solved x,y robot coordinates to
// standard output, but similar code instantiating the Navigation class
// could be embedded in a team's robot control code.
// John Fattaruso 10/27/18

public class Example {
  public static void main(String args[]) {
    int retval;
    double[] soln;
    Navigation nav;

// Give two doulbe objects as the angles to the Navigator object
// The variables below are just examples, you will have the measure the actual ones
    Double a = 0.0;
    Double b = 100.0;

// Create an instance of the Navigation object class
    nav = new Navigation();

// The two beacon angle differences can be set and the solver run any number of times
    nav.setThetaA(a);
    nav.setThetaB(b);

// Run solver to find unknown robot coordinates
// RETURN_RANGE, RETURN_SINGULAR, and RETURN_DIVERGENCE are error codes from our code, don't worry about them
    retval = nav.newton_raphson();
    if (retval == Navigation.RETURN_RANGE) {
      System.err.println("Angle out of range");
    }
    else if (retval == Navigation.RETURN_SINGULAR) {
      System.err.println("Singular Jacobian matrix");
    }
    else if (retval == Navigation.RETURN_DIVERGENCE) {
      System.err.println("Convergence failure in 100 iterations");
    }
    else {

// Retrieve solution of coordinates
      soln = nav.getSolution();
      System.out.println("(x,y) coordinates of robot = (" +
                         soln[0] + "," + soln[1] + ")");
    }
  }
}
