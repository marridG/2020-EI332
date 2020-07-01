module pipeif (pcsource, pc, bpc, da, jpc, npc, pc4, ins, mem_clock);

	input 				mem_clock;

	input 	[1:0]		pcsource;
	input 	[31:0]		pc, bpc, da, jpc;

	output 	[31:0]		pc4, ins, npc;
	

	wire 	[31:0]		next_instruction;


	// point to the next instruction
	assign pc4 = pc + 32'h4;

	// leave time for transmission
	assign ins = pcsource[0]? 32'h0:next_instruction;	
	

	lpm_rom_irom irom(pc[7:2], mem_clock, next_instruction);
	mux4x32	nextpc(pc4, bpc, da, jpc, pcsource, npc);


endmodule
