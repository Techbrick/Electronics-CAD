# Welcome!
This is a simple directory containing sources and STL files for 3D Printable parts.  Mostly, the files in this directory are aimed at helping the Electronics team.

## License
Files are licensed CC-BY-NC.  Basically, feel free to remix, just make sure to properly mark where you got them, and don't use them for commercial purposes.

# Lifecam HD-3000 Mount
These files are for rigidly mounting a Microsoft Lifecam HD-3000 USB camera to your robot frame.  

## Heatsink for high power LEDs:
The current plan is to try a 1" long section of [Heatsink USA's 1.813" heatsink](http://www.heatsinkusa.com/1-813/) for the LED star.  
Drill and Tap four #8-32 screw holes, centered on the corners of a 23/16" x 1/2" rectangle, on the face of the heatsink. 

Secure the LED star to the heatsink with thermal tape.

Mount standard 20mm optics over the LEDs. 

## Wiring for high power LEDs:
Currently planning to use [Meanwell Constant Current](http://www.ledsupply.com/led-drivers/mean-well-ldb-l-series-cc-buck-boost-mode) regulators.  Power in will be connected to the PDP, and the enable signal will be tied into a Rio DIO, so that we can control the LEDs being on or off.

(Note:  For any high power LED, please make sure you can turn it off if you are not using it.  Your teammates, opponents, field staff, and spectators will all appreciate it.)