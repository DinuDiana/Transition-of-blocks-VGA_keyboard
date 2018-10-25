module random_coord(input clock, clock_movement, disp_active,
							input [10:0] xpos, ypos,
							input[10:0] h_resolution, v_resolution,
							output reg[10:0] x, y,
								output [10:0] numar
							//output [3:0] R, G, B);				
							);
							
reg [8:0] counter=0;
reg [4:0] R1, G1, B1, R2, G2, B2, R3, G3, B3;
reg [10:0] i=0, i2, i3;
wire clock_generate;

always @ (posedge clock)
	counter <= counter + 1;
	
always @ (posedge clock_generate)
	if (counter < 48) 
		begin
			x <= h_resolution - 1;
			y <= (counter * 5) + 20;
		end
	else if (counter <200 && counter>47)
		begin
			x <= h_resolution - 1;
			y <= counter * 2;
		end
		else if (counter>v_resolution)
			begin 
				x <= h_resolution - 1;
				y <= counter;
			end
			else begin
				x <= h_resolution - 1;
				y <= counter/2;
			end


always @ (posedge clock_movement)
	//begin
		if (i==h_resolution)
			i <= 0;
		else 
			i <= i + 3;
			
		/*if (i2==a)
			i2 <= 0;
		else 
			i2 <= i2 + 1;
			
		if (i3==a)
			i3 <= 0;
		else 
			i3 <= i3 + 1;
	end*/
	

assign R = (disp_active==1) ? ( ((xpos<(x-i) && xpos>(x-10-i)) && (ypos<(y) && ypos>(y-10))) ? 4'b1111 : 4'b0000) : 4'bzzzz;
assign G = (disp_active==1) ? ( ((xpos<(x-i) && xpos>(x-10-i)) && (ypos<(y) && ypos>(y-10))) ? 4'b0000 : 4'b0000) : 4'bzzzz;
assign B = (disp_active==1) ? ( ((xpos<(x-i) && xpos>(x-10-i)) && (ypos<(y) && ypos>(y-10))) ? 4'b0000 : 4'b0000) : 4'bzzzz;

divizor_simplu #(31) div (clock, clock_generate);

endmodule
