// -----------------------------------------------------------------------------
// Copyright (c) 2014-2020 All rights reserved
// -----------------------------------------------------------------------------
// Author : 
// File   : mod_18_adder_en.v
// Create : 2020-04-24 18:15:48
// Revise : 2020-04-24 18:15:48
// Course : EI332 Computer Organization (by Prof. Fang), 2020 Spring, SJTU
// Traget : Pre-Lab 2 (Due Apr 25)
// Descpt : Mod 18 Adder
// 				- ENABLE Control (HIGH Effective)
// 				- RESET (HIGH Effective)
// 				- Init at 0
// 				- Add at Positive Edge
// Note   : For adders, sequential logic is better, thus using non-block
// 				[Reference] https://blog.csdn.net/dongdongnihao_/article/details/79589223
// 			[Reference] Mod X Adders
// 				https://blog.csdn.net/reborn_lee/article/details/81334385
// -----------------------------------------------------------------------------

module mod_18_adder_en(clk, rst, en, out, carry);

	input clk;				// CLOCK Signal
	input rst;				// RESET Signal
	input en;				// ENABLE Signal
	
	output [4:0] out;       // Mod 18 Adder => 18 status => 5 bits (max 2^5 = 32)
	output carry;			// Carry Bit (i.e. 0 -> 1 when 17 -> 0)

	reg [4:0] out;			// Register "Variable"


	always @(posedge clk or posedge rst) begin
		if (rst) begin						// reset
			out = 5'b00000;
		end

		else if (en) begin 					// CLK enabled
			if (out == 5'b10001) begin 		// 17 => 0
				out <= 5'b00000;            // non-block
			end
			
			else begin 						// otherwise
				out <= out + 1; 
			end
		end

		else begin 							// CLK not enabled
			out <= out;
		end
	end


	assign carry = out[0] & out[4];         // Carry Bit = 1 iff out = 17(5'b10001)

	
endmodule
