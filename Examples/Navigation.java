// Example file for running a servo and printing out the IR charcater your receiver should read.
// IR Receiver has to be connecte to pin 4 on the arduino for this to work.
import rxtxrobot.*;

public class Navigation
{
	public static void main(String[] args)
	{
		RXTXRobot r = new ArduinoNano(); //Create RXTXRobot object
		r.setPort("COM3"); // Set the port to COM3
		r.setVerbose(true); //Turn on debugging messages
		r.connect();

		// goes through a for loop to turn the servo by 10 degrees, 0 to 180
		for (int count = 0; count <= 180; count += 10)
		{
			//turns servo on channel 0 to the current angle
			r.runPCAServo(0, count);
			//Prints out the IR Charcater it reads from the Receiver
			System.out.println(r.getIRChar());
		}
		r.close();
	}
}
