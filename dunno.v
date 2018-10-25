module vga (	input clk, 
					input mode,
					input rst, 
					output [10:0] xpos, ypos,
					output disp_active,
					//input [7:0] R_in, G_in, B_in,
					output [3:0] R, G, B,
					output hsync, vsync,
					output [10:0] lungime,
					output hsync_neg, vsync_neg
					);

reg [10:0] h_resolution, v_resolution;

wire clock;

always @ (posedge clock)
	case (mode)
		0: begin h_resolution <= 640; v_resolution <= 480; end
		1: begin h_resolution <= 800; v_resolution <= 600; end
		default: begin h_resolution <= 800; v_resolution <= 600; end
	endcase	


reg [3:0] R_in_1 = 4'b1111;
reg [3:0] G_in_1 = 4'b0111;
reg [3:0] B_in_1 = 4'b0110;

assign R = (disp_active==1) ? ( ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j))) ? R_in_1 : 8'b0000) : 8'bzzzz;
assign G = (disp_active==1) ? ( ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j))) ? G_in_1 : 8'b0000) : 8'bzzzz;
assign B = (disp_active==1) ? ( ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j))) ? B_in_1 : 8'b0000) : 8'bzzzz;

assign hsync_neg = ~hsync;
assign vsync_neg = ~vsync;
	
ceas c (clk, mode, clock);
divizor_simplu #(17) d1 (clk, clock_movement);
choose_sync sincr(clock, rst, mode, xpos, ypos, vsync, hsync, disp_active);

endmodule
