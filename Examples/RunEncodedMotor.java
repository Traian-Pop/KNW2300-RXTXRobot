// This example shows how to move with encoders.

import rxtxrobot.*;

public class RunEncodedMotor
{
	public static void main(String[] args)
	{
		RXTXRobot r = new ArduinoNano(); // Create RXTXRobot object
		r.setPort("COM3"); // Set port to COM3
		r.connect();
		
		//Run motor on channel 0 at speed 300 for 1000 ticks from encoder on pin 2
		r.runPCAEncoder(0, 300, 2, 1000);

		//Prints out the number of ticks from a certain encoder connected to a motor on channel 1
		System.out.println(r.getPCAEncodedMotorsTicks(1);
		r.close();
	}
}
