module InstrMem (Mem_Addr, Dout); 
   parameter T_rd = 10; 
   parameter MemSize = 1024, WordSize = 32; 
   input  [WordSize-1:0] Mem_Addr; 
   output [WordSize-1:0] Dout; 
   reg [WordSize-1:0] Dout; 
   reg [WordSize-1:0] 	 Mem[0:MemSize-1];   
   `include "imeminit_simple_test.v" 
always
      #T_rd assign  Dout = Mem[ Mem_Addr >> 2 ];
endmodule 