module ps2 (input clock_key, data_key,
				input clock_fpga, 
				input reset,
				output led,
				output [7:0] data_out,
				output new_code);

wire key;
wire clock_intermediar;
wire [10: 0] dout;
wire out_xnor, out_and, ok;
wire data_in;
wire [3:0] count;

/*always @(posedge clock_fpga)
	clock_intermediar <= clock_key;*/

latch_D_ck ceas(clock_key, clock_fpga, clock_intermediar);
latch_D_ck date(data_key, clock_fpga, data_in);
/*	
SIPO unu(data_in, clock_intermediar, reset ,dout);
xnor doi(out_xnor, dout[8], dout[7], dout[6], dout[5], dout[4], dout[3], dout[2], dout[1]);
xnor prim(out_xnor_1, out_xnor, dout[9]);
and trei(out_and, out_xnor_1, ok);
verificare patru (clock_intermediar, reset, data_in, clock_fpga, dout, ok);
latch_D_ck iesire(out_and, clock_fpga, new_code);
*/
SIPO registru(data_in, clock_intermediar, reset ,dout, count);
xnor exclusiv(out_xnor, dout[8], dout[7], dout[6], dout[5], dout[4], dout[3], dout[2], dout[1]);
and si(out_and, out_xnor, dout[9], ok);
verificare ver (clock_intermediar, reset, data_in, clock_fpga, dout, ok, count);
latch_D_ck iesire(out_and, clock_fpga, new_code);


assign data_out = dout[8:1];
assign led = (new_code == 1) ? 1 : 0;

endmodule