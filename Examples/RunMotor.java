// This example shows how to move the DC motors.

import rxtxrobot.*;

public class RunMotor
{
	public static void main(String[] args)
	{
		RXTXRobot r = new ArduinoNano(); // Create RXTXRobot object
		r.setPort("COM3"); // Set port to COM3
		r.connect();
		
		//Run motor on channel 0 at speed 400 for 2000 milliseconds
		r.runPCAMotor(0, 400, 2000);

		//Run motor on channel 1 at speed 250 for infinite time
		r.runPCAMotor(1, 250, 0);

		//Runs a motor on channel 2 at speed 100 and a motor on channel 3 at speed -200 for 5000 milliseconds
		r.runTwoPCAMotor(2, 100, 3, -200, 5000);
		r.close();
	}
}
