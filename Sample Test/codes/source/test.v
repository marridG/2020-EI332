module test (SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9, ZHANGSAN, 
				clk, reset,
				out_port0, out_port1, out_port2, clock_out,
				HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input 			reset, clk;						// control signals
	input 			SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9;
	input 	[31:0]	ZHANGSAN;
	
	output 	[31:0] 	out_port0, out_port1, out_port2;
	output 	[6 :0] 	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

	output 			clock_out;
	wire 	[31:0] 	in_port0, in_port1, in_port2;
	wire 	[6 :0] 	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	clock_and_mem_clock inst (clk, clock_out);

	
	// Inputs: result = number_high(DEC) + number_low(DEC)
	in_port inst1(SW9,SW8,SW7,SW6,SW5, in_port0);	// the added
	in_port inst2(SW4,SW3,SW2,SW1,SW0, in_port1); 	// the addeend
	assign in_port2 = ZHANGSAN;
	
	// Single-cycle CPU instance
	sc_computer inst4(reset, clock_out, clk,
						in_port0, in_port1, in_port2,
						out_port0, out_port1, out_port2);

	// module out_port_seg(out_port, out_high, out_low);
	out_port_seg inst5(out_port0, HEX1,HEX0);
	out_port_seg inst6(out_port1, HEX3,HEX2);
	out_port_seg inst7(out_port2, HEX5,HEX4);
	
	
endmodule
	
 	