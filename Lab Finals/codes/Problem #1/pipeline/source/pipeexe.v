module pipeexe(ealuc,ealuimm,ea,eb,eimm,esa,eshift,ern0,epc4,ejal,ern,ealu /*,ezero,ert,
                 wrn,wdi,malu,wwreg*/);


	input  [3:0] 	ealuc;
	input  [31:0] 	ea, eb, eimm, esa, epc4;
	input  [4:0]  	ern0;
	input  		  	ealuimm, eshift, ejal;

	output [31:0] 	ealu;
	output [4:0]  	ern;
	wire   [31:0] 	a, b, r;
	wire   [4:0]  	ern = ern0 | {5{ejal}};
	wire   [31:0] 	epc8 = epc4 + 4;
	
	mux2x32 alu_a (ea, esa, eshift, a);
	mux2x32 alu_b (eb, eimm, ealuimm, b);

	mux2x32 link (r, epc8, ejal, ealu);
	alu     alu_inst (a, b, ealuc, r);
	
	
endmodule 