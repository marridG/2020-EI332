
module decoder_2_4(Y, E, A0, A1);
	// [Reference] https://blog.csdn.net/weixin_38679924/article/details/100594310
	// 端口定义
	input E, A0, A1;    // 三个输入端，输入使能、输入 LSB & MSB
	output [3 : 0] Y;   // 输出端：0-3
	
	//数据流描述（数电：输入->输出）
	assign Y[0] = ~(~A0 & ~A1 & ~E); // 连续赋值语句 assign
	assign Y[1] = ~(A0 & ~A1 & ~E);
	assign Y[2] = ~(~A0 & A1 & ~E);
	assign Y[3] = ~(A0 & A1 & ~E);
endmodule