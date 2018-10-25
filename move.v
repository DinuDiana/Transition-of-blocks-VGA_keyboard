module move(input clk, 
				input mode,
				input rst,
				output disp_active,
				output [3:0] R, G, B,
				output hsync, vsync,
				output hsync_neg, vsync_neg,
				input clock_key, data_key,
				output [7:0] data_out,
				output new_code
					);
				
wire [7:0] key;
//wire [3:] R, G, B;
//wire clk, mode, rst, dispt_active, hsync, vsync, clock_key, data_key, led;
	
vga display (clk, mode, rst, key, new_code, xpos, ypos, disp_active, R, G, B, hsync, vsync/*, lungime*/, hsync_neg, vsync_neg);
ps2 keyboard (clock_key, data_key, clk, rst, led, key, new_code);

assign data_out = key;

endmodule	