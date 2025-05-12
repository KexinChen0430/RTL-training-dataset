module also isolates for input to lbsm.v, and drives
  (
   CLK, 
   WWADoe, 
   WWCoe, 
   WWCmdIfOE, 
   WWADHold, 
   iWWADO, 
   WWCmdI, 
   WWADI, 
   WWADB, 
   WWCmdB 
   );
   input         CLK; 
   input         WWADoe; 
   input         WWCoe; 
   input [8:0]   WWCmdIfOE; 
   input         WWADHold; 
   input [31:0]  iWWADO; 
   output [8:0]  WWCmdI; 
   output [31:0] WWADI; 
   inout [31:0]  WWADB; 
   inout [8:0]   WWCmdB; 
   reg [31:0]    WWADIfOE; 
endmodule