/* A Simple Accelerometer Example
 *
 * Values only in the x-axis are detected in the following example.
 * For your Lab1, use extend the code for Y and Z axes.
 * Finally, interface them with a button so that the sensing starts onlt after the press of a button.
 *
 */
 
//#include "UserButton.h"
#include <Timer.h>
#include <stdio.h>
#include <string.h>
#include "printf.h"


module T1C @safe()
{
  	uses interface Leds;
  	uses interface Boot;

  	/* We use millisecond timer to check the shaking of client.*/
	uses interface Timer<TMilli> as TimerTemp;

  	/*Temperature Interface*/
	uses interface Read<uint16_t> as Temperature;
}


implementation
{
    event void Boot.booted() 
    {
   		call TimerTemp.startPeriodic(1000); //Starts timer

    }

	event void TimerTemp.fired()
	{
		if(call Temperature.read() == SUCCESS) //If temperature read was successful
		{
			call Leds.led2Toggle();
		}
		else
		{
			call Leds.led0Toggle();
		}
	}

    event void Temperature.readDone(error_t result, uint16_t data)
	{
		if(result == SUCCESS)
		{
			printf("Current temp is: %d \r\n", data);
		}
		else
		{
			printf("Error reading from sensor! \r\n");
		}
		
		//printfflush();
	}
}

