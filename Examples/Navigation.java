import java.util.*;
// Example class for solving the KNW2300 robot beacon navigation
// system. This example code takes the two measured beacon angles off of
// the command line and displays the solved x,y robot coordinates to
// standard output, but similar code instantiating the Navigation class
// could be embedded in a team's robot control code.
// John Fattaruso 10/27/18

//This particular example takes the angles as input in the "main" method argument section. 

public class Example {
  public static void main(String args[]) {
    int retval;
    double[] soln;
    Navigation nav;

    if (args.length != 2) {
      System.err.println("Usage: Example <theta a in degrees> <theta b in degrees>");
      return;
    }
// Create an instance of the Navigation object class
    nav = new Navigation();
// The two beacon angle differences can be set and the solver run any number of times
    nav.setAngles(Double.parseDouble(args[0]),Double.parseDouble(args[1]));
// Run solver to find unknown robot coordinates
// RETURN_RANGE, RETURN_SUCCESS, RETURN_SINGULAR, and RETURN_DIVERGENCE are error codes from our code, don't worry about them
    retval = nav.newton_raphson();
    if (retval == Navigation.RETURN_SUCCESS) {
// Retrieve solution of coordinates
      soln = nav.getSolution();
      System.out.println("(x,y) coordinates of robot = (" +
                         soln[0] + "," + soln[1] + ")");
    }
    else if (retval == Navigation.RETURN_RANGE) {
      System.err.println("Angle out of range");
    }
    else if (retval == Navigation.RETURN_SINGULAR) {
      System.err.println("Singular Jacobian matrix");
    }
    else if (retval == Navigation.RETURN_DIVERGENCE) {
      System.err.println("Convergence failure in 100 iterations");
    }
  }
}

