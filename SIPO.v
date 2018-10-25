/*module SIPO ( din ,clk ,reset ,dout );

output [10:0] dout ;

input din ;
input clk ;
input reset ;
reg [10:0]s;

always @ (negedge clk)
 if (reset == 0)
  s <= 11'b111_1111_1111;
 else begin
  s[10] <= din;
  s[9] <= s[10];
  s[8] <= s[9];
  s[7] <= s[8];
  s[6] <= s[7];
  s[5] <= s[6];
  s[4] <= s[5];
  s[3] <= s[4];
  s[2] <= s[3];
  s[1] <= s[2];
  s[0] <= s[1];
 end

assign dout = s;
 

endmodule*/

module SIPO (din, clk, reset, dout, num);

output [10:0] dout ;
reg [10:0] data_out;
input din;
input clk;
input reset;
reg [10:0]s;
reg [3:0] count = 0;
output [3:0] num;

always @ (negedge clk)
	if (reset == 0) begin
		s <= 11'b111_1111_1111;
		count <= 0;
		end
	else
		begin
		s[10] <= din;
		s[9] <= s[10];
		s[8] <= s[9];
		s[7] <= s[8];
		s[6] <= s[7];
		s[5] <= s[6];
		s[4] <= s[5];
		s[3] <= s[4];
		s[2] <= s[3];
		s[1] <= s[2];
		s[0] <= s[1];
		if (count < 11)
			count <= count + 1;
		else 
			count = 0;
		end

/*always @ (*)
	if (count == 11)
		dout = data_out;

always @ (*)
data_out = s;*/
assign dout = s;
assign num = count;

endmodule