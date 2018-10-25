module vga (	input clk, 
					input mode,
					input rst, 
					input [7:0] key,
					input new_code,
					output [10:0] xpos, ypos,
					output disp_active,
					//input [7:0] R_in, G_in, B_in,
					output [3:0] R, G, B,
					output hsync, vsync,
					//output [10:0] lungime,
					output hsync_neg, vsync_neg
					);

reg [10:0] i=0, j=0;
localparam [10:0] x0=50, y0=50, x1=100, y1=100;
reg [10:0] h_resolution, v_resolution;
//reg [10:0] body_stack []
reg [3:0] R1, G1, B1, R2, G2, B2, R3, G3, B3;
//wire R3, G3, B3;
reg [3:0] direction;

wire clock;


always @ (posedge clock)
	case (mode)
		0: begin h_resolution <= 640; v_resolution <= 480; end
		1: begin h_resolution <= 800; v_resolution <= 600; end
		default: begin h_resolution <= 800; v_resolution <= 600; end
	endcase	

/*always @ (posedge clock_movement)
	begin
		body_stack[5] = body_stack[4];
		body_stack[4] = body_stack[3];
		body_stack[3] = body_stack[2];
		body_stack[2] = body_stack[1];
		body_stack[1] = body_stack[0];
		body_stack[0] = body_stack[0] + 25;
	end */
	
always @ (*)
	//if (new_code == 1)
	case (key)
		8'b0010_0011: direction = 4'b0001;		//dreapta
		8'b0001_1100: direction = 4'b0010;		//stanga
		8'b0001_1011: direction = 4'b0100;		//jos
		8'b0001_1101: direction = 4'b1000;		//sus
		default: direction = 4'b1111;
	endcase

always @ (posedge clock_movement)
	case (direction)
		4'b1111: begin i <= i; j <= j; end
		4'b0001:if (i==(h_resolution-x1))	
						i <= 0;		//aici era a??; mergea si asa
					else
						i <= i + 1;
		4'b0010:if (i==0)
						i <= h_resolution; 
					else
						i <= i - 1;
		4'b0100:if (j==(v_resolution + y1))			//aici era y0
						j <= 0;
					else
						j <= j + 1;
		4'b1000:if (j==0)
						j <= v_resolution - y1; 
					else
						j <= j - 1;
		default: begin i <= i; j <= j; end
	endcase 
	
/*always @ (posedge clock_movement)
	//	if (key == 8'b1110_0000)
			if (key == 8'b0111_0101)
				if (i==(h_resolution-x1))
					i <= 0;		//aici era a??; mergea si asa
				else
					i <= i + 1;
			else if (key == 8'b0111_0010)
					if (i==0)
						i <= h_resolution; 
					else
						i <= i - 1;
		else 
			i <= i;

always @ (posedge clock_movement)
//	if (key==8'b1110_0000)
		if (key==8'b0111_0100) 
			if (j==(v_resolution + y1))			//aici era y0
				j <= 0;
			else
				j <= j + 1;
		else if (key==8'b0110_1011)
				if (j==0)
					j <= v_resolution - y1; 
				else
					j <= j - 1;
		else 
			j <= j;*/
	

reg [3:0] R_in_1 = 4'b1111;
reg [3:0] G_in_1 = 4'b1111;
reg [3:0] B_in_1 = 4'b1111;


//assign lungime = 10;
		
/*assign R = (disp_active==i) ? ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j)) ? R_in_1 : 4'b0000) : 4'bzzzz;
assign G = (disp_active==i) ? ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j)) ? G_in_1 : 4'b0000) : 4'bzzzz;
assign B = (disp_active==i) ? ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j)) ? B_in_1 : 4'b0000) : 4'bzzzz;*/

always @ (posedge clock) 
begin
 R1 = (disp_active==1) ? ( ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j))) ? R_in_1 : 4'b0000) : 4'bzzzz;
 G1 = (disp_active==1) ? ( ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j))) ? G_in_1 : 4'b0000) : 4'bzzzz;
 B1 = (disp_active==1) ? ( ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j))) ? B_in_1 : 4'b0000) : 4'bzzzz;

 R2 = (disp_active==1) ? ( ((xpos<350 && xpos>300) && (ypos<350 && ypos>300)) ? 4'b1111 : 4'b0000) : 4'bzzzz;
 G2 = (disp_active==1) ? ( ((xpos<375 && xpos>325) && (ypos<375 && ypos>325)) ? 4'b1111 : 4'b0000) : 4'bzzzz;
 B2 = (disp_active==1) ? ( ((xpos<400 && xpos>350) && (ypos<400 && ypos>350)) ? 4'b1111 : 4'b0000) : 4'bzzzz;
end


//de aici
/*
reg [8:0] counter=9'b000000000;
reg [10:0] i0=0, i2, i3;
reg [10:0] x, y;
wire clock_generate;

always @ (negedge clock)
	counter <= counter + 1;
	
always @ (posedge clock_generate)
	if (counter < 48) 
		begin
			x <= h_resolution - 10;
			y <= (counter * 5) + 20;
		end
	else if (counter <200)
		begin
			x <= h_resolution - 10;
			y <= counter * 2;
		end
		else if (counter>v_resolution)
			begin 
				x <= h_resolution - 10;
				y <= counter;
			end
			else begin
				x <= h_resolution - 10;
				y <= counter/2;
			end


always @ (posedge clock)
	//begin
		if (i0==h_resolution)
			i0 <= 0;
		else if (i0==0)
			i0=h_resolution;
		else
			i0 <= i0 + 3;
			
		/*if (i2==a)
			i2 <= 0;
		else 
			i2 <= i2 + 1;
			
		if (i3==a)
			i3 <= 0;
		else 
			i3 <= i3 + 1;
	end
	
divizor_simplu #(28) div (clock, clock_generate);

//pana aici

always @ (posedge clock_movement) begin
 R3 = (disp_active==1) ? ( ((xpos>(x-i0) && xpos<(x-10-i0)) && (ypos>(y) && ypos<(y-10))) ? 4'b1111 : 4'b0000) : 4'bzzzz;
 G3 = (disp_active==1) ? ( ((xpos>(x-i0) && xpos<(x-10-i0)) && (ypos>(y) && ypos<(y-10))) ? 4'b0000 : 4'b0000) : 4'bzzzz;
 B3 = (disp_active==1) ? ( ((xpos>(x-i0) && xpos<(x-10-i0)) && (ypos>(y) && ypos<(y-10))) ? 4'b0000 : 4'b0000) : 4'bzzzz;
 end
 //pana aici -ish
 */
assign R = R1 ^ R2;
assign G = G1 ^ G2;
assign B = B1 ^ B2;

assign hsync_neg = ~hsync;
assign vsync_neg = ~vsync;
	
//ps2 keyboard (clock_key, data_key, clk, reset, led, key, new_code);
ceas c (clk, mode, clock);
divizor_simplu #(17) d1 (clk, clock_movement);
choose_sync sincr(clock, rst, mode, xpos, ypos, vsync, hsync, disp_active);

//random_coord r1(clock, clock_movement, disp_active, xpos, ypos, h_resolution, v_resolution, x, y, i0/*, R3, G3, B3*/);	

endmodule
