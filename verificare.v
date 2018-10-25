/*module verificare (input clock_intermediar, reset, data_in, clock_fpga, output reg ok);

reg[3:0] count=0;
localparam [2:0] q0=0, q1=1, q2=2, q3=3, q4=4, q5=5 ;
reg [2:0] state, next_state;
reg do_count = 0;

always @ (clock_fpga)
if (reset==1)
	state <= next_state;
else 
  state <= q0;

always @ (*)
	case (state)
		q0: next_state = (clock_intermediar == 0) ? q1 : q0;
		q1: next_state = (data_in == 0) ? q2 : q0;
		q2: begin
				do_count = 1;
				next_state = (count == 4'b1001) ? q3 : q2;
			end
		q3: begin
				do_count = 0;
				next_state = (data_in == 1) ? q4 : q0;
			end
		q4: next_state = (clock_intermediar == 1) ? q5: q0;
		q5: next_state = q0;
		default: next_state = q0;
	endcase
	
always @ (negedge clock_intermediar)
	if (do_count == 1)
		count <= count + 1;
	else 
		count <= 0;
	
always @ (clock_fpga)
	case (state)
		q0: ok = 0;
		q1: ok = 0;
		q2: ok = 0;
		q3: ok = 0;
		q4: ok = 0;
		q5: ok = 1;
		default: ok = 0;
	endcase*/
	/*
module verificare(input clock_intermediar, reset, data_in, clock_fpga, input [10:0] data_in_parallel, output reg ok);

reg [3:0] count=0;
reg sum;
wire par_check;

always @ (data_in_parallel) begin
	if (data_in_parallel[0] == 1 && data_in_parallel[10] == 0)
		if (count < 9)begin
			sum = sum + data_in_parallel[count];
			count = count + 1;
			end
		else 
			count = 0;
	else
		count = 0;
	if (data_in_parallel[0] == 1 && data_in_parallel[10] == 0 && par_check == data_in_parallel[9])
		ok = 1;
	else
		ok = 0;
end

assign par_check = ~sum;


endmodule */
module verificare(input clock_intermediar, 
						reset, 
						data_in, 
						clock_fpga, 
						input [10:0] data_in_parallel, 
						output reg ok, 
						input [3:0] count);

reg sum;
wire par_check;


always @ (count)
		if (count < 11)
			sum = sum + data_in_parallel[count-1];
		else if (count == 11)
			if (data_in_parallel[0] == 1 && data_in_parallel[10] == 0 && par_check == data_in_parallel[9])
				ok = 1;
			else 
				ok = 0;
		

assign par_check = ~sum;


endmodule 
