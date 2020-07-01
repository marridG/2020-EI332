module in_port(in_4, in_3, in_2, in_1, in_0,
					in_port);
	// 接受按键输入，将 5bit < 32bit 输入端口转换为 32 位

	input 				in_4, in_3, in_2, in_1, in_0;


	output 	[31:0]		in_port;
	

	// 5bit (*****) ==> 32 bit (00...0000*****)
	assign in_port = {27'b0, in_4, in_3, in_2, in_1, in_0};


endmodule
