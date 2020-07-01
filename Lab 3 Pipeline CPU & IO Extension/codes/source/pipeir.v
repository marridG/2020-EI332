module pipeir (pc4,ins,wpcir,clock,resetn,dpc4,inst);

	input  				clock,resetn;
	input 	[31:0]		pc4, ins;
	input  				wpcir;

	output 	[31:0] 		dpc4, inst;


	wire				clock,resetn,wpcir;
	wire	[31:0]		pc4, ins;

	reg		[31:0]		dpc4,inst;


	always @ (posedge clock)
	begin
		if(~resetn)			// reset all signals
		begin
			inst <= 0;
			dpc4 <= 0;
		end

		else 
		begin
			if(wpcir)	// IF -> ID: latched in IF/ID REG
			begin
				inst <= ins;
				dpc4 <= pc4;
			end
		end

	end


endmodule