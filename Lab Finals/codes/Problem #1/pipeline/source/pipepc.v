module pipepc(npc,wpcir,clock,resetn,pc);

	input  	[31:0] 	npc;
	input 			wpcir;
	input         	clock, resetn;

    output 	[31:0] 	pc;

    reg 	[31:0] 	pc;


    always @ (posedge clock)
    	if (~resetn)
		begin
    		pc <= -4;		// reset signal <pc>
    	end
		else 
			if (wpcir)
			begin
	        	pc <= npc;  // update signal <pc> by the next instrution
	      	end

endmodule
