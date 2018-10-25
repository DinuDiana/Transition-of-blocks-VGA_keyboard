module latch_D_ck (D, ck, Q);

input D;
input ck;
output Q;

/*always @ (*) 
	if (ck == 1) 
		Q = D;
	else Q = Q;*/

	assign Q = (ck==1) ? D : Q;
	
endmodule