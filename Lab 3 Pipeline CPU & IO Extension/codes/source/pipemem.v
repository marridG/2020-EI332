module pipemem(mwmem,malu,mb,clock,mem_clock,mmo,resetn,
				real_in_port0,real_in_port1,
				real_out_port0,real_out_port1,real_out_port2,real_out_port3);

	input          mwmem, mem_clock, clock, resetn;
	input  [31:0]  malu, mb;
	input  [31:0]  real_in_port0,real_in_port1;

	output [31:0]  mmo;
	output [31:0]  real_out_port0,real_out_port1,real_out_port2,real_out_port3;
	
	
	wire [31:0]		mem_dataout,io_read_data;
	wire            write_io_enable, write_datamem_enable;
	assign 			write_io_enable = malu[7] & mwmem;
	assign			write_datamem_enable = ~malu[7] & mwmem;
	
	mux2x32 mem_io_dataout_mux(mem_dataout,io_read_data,malu[7],mmo);
	lpm_ram_dq_dram dram(malu[6:2],mem_clock,mb,write_datamem_enable,mem_dataout);
	io_input io_input_regx2(malu,mem_clock,io_read_data,real_in_port0,real_in_port1);
	io_output io_output_regx2(malu,mb,write_io_enable,mem_clock,resetn,real_out_port0,real_out_port1,real_out_port2,real_out_port3);

endmodule 