# Transition-of-blocks-VGA_keyboard
Displays colored blocks that can be moved from keyboard - for the Altera DE1 FPGA Board - Verilog


This module combines the VGA Controller module and the PS2-Keyboard module so that an user can move the shapes displayed using the keyboard.


module move(  
input clk, //50MHz clock from the FPGA board  
				input mode,  //selects the resolution  
				input rst,  //reset input  
				output disp_active,   //synchronization signal that indicates if the displayed pixel is in the  
        //active area of the display or in the back or front porch   
				output [3:0] R, G, B,  //4 bit output for the red, green and blue pixel which dictates the color  
        //of the displayed object  
				output hsync, vsync,  //horizontal (and vertical) sync – it activates after the active and the front porch areas  
        //of pixels were displayed horizontally (and vertically) and stays active until it reaches  
        //the back porch area  
				output hsync_neg, vsync_neg,  //direct logic  
				input clock_key, data_key,  //clock signal from the keyboard, input data from the keyboard  
				output [7:0] data_out,    //data output from keyboard  
				output new_code  //indicates that the data received from the keyboard is good  
        //after the integrity of the signal is checked  
					);
