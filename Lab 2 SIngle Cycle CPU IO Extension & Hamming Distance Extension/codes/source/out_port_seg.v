module out_port_seg(out_port, out_high, out_low);

	input 	[31:0] 		out_port;

	output 	[6 :0] 		out_high, out_low;


	wire 	[6 :0] 		out_high, out_low;

	// calculate the output numbers on each digit
	wire	[3 :0] 		num_high = out_port / 10;
	wire 	[3 :0] 		num_low	 = out_port - num_high * 10;


	num_2_seg num2seghigh 	(num_high, out_high);
	num_2_seg num2seglow 	(num_low,  out_low);


endmodule 



module num_2_seg(num, out);
	input 	[3:0] 		num;
	output 	[6:0] 		out;

	reg		[6:0]		out;

	initial
	begin
		out = 0;
	end


	always @ (*)
	begin
		case(num) //seven-digit-seg: gfedcba
			0: 			out[6:0] = 7'b1000000;
			1: 			out[6:0] = 7'b1111001;
			2: 			out[6:0] = 7'b0100100;
			3: 			out[6:0] = 7'b0110000;
			4: 			out[6:0] = 7'b0011001;
			5: 			out[6:0] = 7'b0010010;
			6: 			out[6:0] = 7'b0000010;
			7: 			out[6:0] = 7'b1111000;
			8: 			out[6:0] = 7'b0000000;
			9: 			out[6:0] = 7'b0010000;
			default: 	out[6:0] = 7'b1111111;
		endcase
	end

endmodule

