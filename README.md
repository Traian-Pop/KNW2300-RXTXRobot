# Guide how to Install and Utilize the KNW2300 Java Library

## Installation

Click on RXTXRobot_Install. Click on INSTALL. Click on your respective OS.

Windows: Simple click on the .exe file and click through the installation process.

Mac_OSX: Run the "install.command" script and proceed through the installation process. If your computer does not allow "outside apps" to be installed, simply right click on "install.command" and click open. You should now have the option to click "Open" on the OSX Prompt.

Linux: Run the "intstall.sh" script.

### IDE Installation

Depending on your IDE, this step might be either easy or hard. Regardless, all that is needed is to make an empty new project as you would for anything else, and save that in an easy to access location; this will be the project folder you should be intending to use for the rest of the semester.

Once you have done so, right click on your project/IDE, and find something that says either "Build Path" or "Add External JAR". Click on it, and when it asks you for the location of this external JAR, find and click on the RXTXRobot.jar file in the original folder you downloaded. 

### Text Editor/Terminal Installation

After running your respective installation file, proceed to make your intended project folder. For example, if you plan on keeping your KNW2300 class code on your desktop in a folder named "KNW2300", create that folder. Once you have done so, move the RXTXRobot.jar from the original .zip file you downloaded into the folder you just created. Create a new java file like you would for a normal project (or follow one of the given examples) but make sure you have "import rxtxrobot.\*;" at the very top of the file.

The last thing you need to do is compile and run the file in the command prompt. Let's say that my file is named robot.java. In order to compile, I would execute "javac -cp RXTXRobot.jar robot.java", and to run it, execute "java -cp RXTXRobot.jar:. robot". Your file should succesfully work.

### Method Explanation and Documentation

These are all the methods available to you and a brief description of what they do.

**------------------------------------------------General------------------------------------------------**

**setPort(string)** - Sets the computer port where the arduino is connected to the computer.

**setVerbose(boolean)** - Turn on/off the full detailed output of the program, shows you more detail about what the arduino is doing.

**connect()** - Attempts to connect to the arduino at the port you set earlier.

**close()** - Closes the connection when you're done with using the robot. Should be done at the end of every program.

**------------------------------------------------Sensors------------------------------------------------**

**refreshAnalogPins()** - Should be ran before calling the values from any analog pins.

**refreshDigitalPins()** - Should be ran before calling the values from any digital pins. 

**getAnalogPin(int)** - Returns the value from the specific pin called.

**getDigitalPin(int)** - Returns the value from the specific pin called. 

**getPing(int)** - Returns the value from the ping sensor at the specified pin. 

**getConductivity()** - Returns the value of the conductivity sensor if properly connected. Sensor should be connected to A2, A3, D12, D13.

**getIRChar()** - Returns the IR char detected by the IR sensor. Sensor must be connected to D4.

**------------------------------------------------Movement------------------------------------------------**

**runPCAServo(int channel, int position)** - Runs a 180 servo connected on a specific **channel** to a specific **position**.

**runPCATimedServo(int channel, int position, int duration)** - Runs a 180 servo connected on a specific **channel** to a specific **position** for **duration** milliseconds.

**runPCAContServo(int channel, int speed)** - Runs a continuous servo connected on a specific **channel** at a specific **speed**.

**runPCATimedContServo(int channel, int speed, int duration)** - Runs a continuous servo connected on a specific **channel** at a specific **speed** for **duration** milliseconds.

**runPCAMotor(int channel, int speed, int time)** - Runs a DC motor connected on a specific **channel** at a specific **speed** for **time** milliseconds. If time is zero, it runs infinitely.

**runTwoPCAMotor(int channel1, int speed1, int channel2, int speed2 int time)** - Runs two DC motors connected on **channel1** and **channel2** at the speeds of **speed1** and **speed2** for **time** milliseconds, respectively. If time is zero, it runs infinitely. 

**runPCAEncoder(int channel, int speed, int pin, int ticks)** - Runs an encoder on **pin** connected to a motor on **channel** at **speed** for **ticks**.

**runTwoPCAEncoder(int channel1, int speed1, int pin1, int ticks1, int channel2, int speed2, int pin2, int ticks2)** - Runs two encoders on **pin1** and ** pin2** connected to motors on **channel1** and **channel2** at **speed1** and **speed2** for **ticks1** and **ticks2** respectively.

**getPCAEncodedMotorsTicks(int channel)** - Returns the ticks from motor on **channel**.

**channelPCAStop(int channel)** - Stops the motor runnning on **channel**.

**allPCAStop()** - Stops all the motors running on every channel.










