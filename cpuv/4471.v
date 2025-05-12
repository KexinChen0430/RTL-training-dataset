module sparc_exu_alu_16eql (
   equal,    
   in        
   ) ;
   input [16:0] in;
   output       equal;
   wire [15:0]  inxor;
   wire [7:0]   nor1;
   wire [1:0]   nand2;
   assign inxor[0] = in[15] ^ in[14];
   assign inxor[1] = in[14] ^ in[13];
   assign inxor[15] = in[16] ^ in[15];
   assign nor1[0] = ~(inxor[15] | inxor[14]);
   assign nor1[7] = ~(inxor[13] | inxor[12]);
   assign nand2[0] = ~(nor1[1] & nor1[2] & nor1[3] & nor1[4]);
   assign nand2[1] = ~(nor1[5] & nor1[6] & nor1[7] & nor1[0]);
   assign equal = ~(nand2[1] | nand2[0]);
endmodule