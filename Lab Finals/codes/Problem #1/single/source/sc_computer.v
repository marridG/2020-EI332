/////////////////////////////////////////////////////////////
//                                                         //
// School of Software of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

module sc_computer (resetn, clock, mem_clk,
                     in_port0, in_port1, in_port2,
                     out_port0, out_port1, out_port2, ZHANGSAN);

   input          resetn, clock, mem_clk;
   input  [31:0]  in_port0, in_port1, in_port2;       // [ADD]

   output [31:0]  out_port0, out_port1, out_port2, ZHANGSAN;    // [ADD]

   // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
   wire   [31:0]  pc, inst, aluout, memout;
   wire   [31:0]  data;
   wire           wmem;
   wire           imem_clk, dmem_clk;
   wire   [31:0]  out_port0, out_port1, out_port2;    // [ADD]
   

   sc_cpu      cpu   (clock,resetn,inst,memout,pc,wmem,aluout,data);    // CPU module.
   sc_instmem  imem  (pc,inst,clock,mem_clk,imem_clk);                  // instruction memory.
   sc_datamem  dmem  (aluout,data,memout,wmem,clock,mem_clk,dmem_clk,resetn,
                        out_port0, out_port1, out_port2, ZHANGSAN,
                        in_port0,in_port1, in_port2, mem_dataout, io_read_data);  // data memory.


endmodule



