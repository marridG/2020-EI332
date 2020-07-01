module io_output(addr,datain,write_io_enable,io_clk,clrn,out_port0,out_port1,out_port2); 
//本例中没有添加reset信号，可以自行添加. if necessary,can use reset signal to reset the output to 0.

	input [31:0] addr,datain;
	input write_io_enable,io_clk;
	input clrn;
	output [31:0] out_port0,out_port1,out_port2;
	reg [31:0] out_port0;
	reg [31:0] out_port1;
	reg [31:0] out_port2;
	always @ (posedge io_clk)
	begin
		if(clrn == 0)
		begin
			out_port0 = 0;
			out_port1 = 0;
			out_port2 = 0;
		end
		else
		begin
			if (write_io_enable == 1)
				case (addr[7:2])
					6'b100000: out_port0=datain;
					6'b100001: out_port1=datain;
					6'b100010: out_port2=datain;
				endcase
		end
	end

endmodule 