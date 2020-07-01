module sc_datamem (addr,datain,dataout,we,clock,mem_clk,dmem_clk,resetn,
                     out_port0, out_port1, out_port2, ZHANGSAN,
                     in_port0,  in_port1, in_port2,
                     mem_dataout, io_read_data);
 
   input  [31:0]  addr;
   input  [31:0]  datain;
   input          we, clock,mem_clk;
      
   // === BEGIN ADD ===
   input          resetn;
   input  [31:0]  in_port0, in_port1, in_port2;
   // === END ADD ===


   output [31:0]  dataout;
   output         dmem_clk;

   // === BEGIN ADD ===
   output [31:0]  out_port0, out_port1, out_port2, ZHANGSAN;
   output [31:0]  mem_dataout;
   output [31:0]  io_read_data;
   // === END ADD ===
   

   wire           dmem_clk;    
   wire           write_enable;

   // === BEGIN ADD ===
   wire [31:0]    dataout;
   wire [31:0]    mem_dataout;
   wire           write_data_enable;
   wire           write_io_enable;
   // === END ADD ===


   assign         write_enable = we & ~clock; 
   assign         dmem_clk = mem_clk & (~ clock) ; 
   

   // === BEGIN ADD ===
   //100000 111111: I/O; 000000 011111: dataout
   assign write_data_enable = write_enable & (~addr[7]);
   assign write_io_enable = write_enable & addr[7];

   // select output data sorce: internal / IO
   mux2x32 io_data_mux(mem_dataout,io_read_data,addr[7],dataout);
   // === END ADD ===

   lpm_ram_dq_dram dram(addr[6:2], dmem_clk, datain, write_data_enable, 
                           mem_dataout);


   // === BEGIN ADD ===
   // translate IO address-space, construct data output IO<->CPU
   io_output   io_output_reg  (addr, datain, write_io_enable, dmem_clk, resetn,
                                    out_port0, out_port1, out_port2, ZHANGSAN);
   io_input    io_input_reg   (addr, dmem_clk, io_read_data, in_port0, in_port1, in_port2);
   // === END ADD ===

endmodule 