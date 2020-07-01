module alu (a,b,aluc,s,z);
    input  [31:0]  a, b;
    input  [3:0]   aluc;
    output [31:0]  s;
    output         z;

    reg    [31:0]  s;
    reg            z;
    reg    [31:0]  t;

    always @ (a or b or aluc) 
        begin                                    // event
            casex (aluc)
                4'b1011:                         // hamming code
                    begin
                        t = a ^ b;
                        s =  t[0]  + t[1]  + t[2]  + t[3]  + 
                             t[4]  + t[5]  + t[6]  + t[7]  + 
                             t[8]  + t[9]  + t[10] + t[11] + 
                             t[12] + t[13] + t[14] + t[15] + 
                             t[16] + t[17] + t[18] + t[19] + 
                             t[20] + t[21] + t[22] + t[23] + 
                             t[24] + t[25] + t[26] + t[27] +
                             t[28] + t[29] + t[30] + t[31];
                    end

                4'bx000: s = a + b;              //x000 ADD
                // ** FILLED IN - START **
                4'bx100: s = a - b;              //x100 SUB
                4'bx001: s = a & b;              //x001 AND
                4'bx101: s = a | b;              //x101 OR
                4'bx010: s = a ^ b;              //x010 XOR
                4'bx110: s = b << 16;            //x110 LUI: imm << 16bit             
                4'b0011: s = b << a;             //0011 SLL: rd <- (rt << sa)
                4'b0111: s = b >> a;             //0111 SRL: rd <- (rt >> sa) (logical)
                // ** FILLED IN - END **
                4'b1111: s = $signed(b) >>> a;   //1111 SRA: rd <- (rt >> sa) (arithmetic)
                default: s = 0;
            endcase
            if (s == 0)  z = 1;
            else z = 0;
        end      
endmodule 