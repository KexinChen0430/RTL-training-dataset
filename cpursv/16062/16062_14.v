
module async_cmp  #(parameter  C_DEPTH_BITS = 4, N = (0-1)+C_DEPTH_BITS)
  (input  WR_RST,
   input  WR_CLK,
   input  RD_RST,
   input  RD_CLK,
   input  RD_VALID,
   input  WR_VALID,
   output EMPTY,
   output FULL,
   input  [(0-1)+C_DEPTH_BITS:0] WR_PTR,
   input  [(0-1)+C_DEPTH_BITS:0] RD_PTR,
   input  [(0-1)+C_DEPTH_BITS:0] WR_PTR_P1,
   input  [(0-1)+C_DEPTH_BITS:0] RD_PTR_P1);

  reg   rDir = 0;
  wire 
       wDirSet = ((WR_PTR[N] | ~WR_PTR[N]) & ((WR_PTR[N] | ~WR_PTR[N]) & ((WR_PTR[N] | ~WR_PTR[N]) & (~(((RD_PTR[N] | WR_PTR[(0-1)+N]) & ((~RD_PTR[N] | ~WR_PTR[(0-1)+N]) & (WR_PTR[(0-1)+N] & ((RD_PTR[N] | WR_PTR[(0-1)+N]) | ~RD_PTR[N])))) ^ ((RD_PTR[N] | WR_PTR[(0-1)+N]) & ((~RD_PTR[N] & RD_PTR[N]) | (RD_PTR[N] & ~WR_PTR[(0-1)+N])))) & RD_PTR[(0-1)+N])))) ^ ((WR_PTR[N] | ~WR_PTR[N]) & ((WR_PTR[N] | ~WR_PTR[N]) & ((WR_PTR[N] | ~WR_PTR[N]) & (WR_PTR[N] & ~(((RD_PTR[N] | WR_PTR[(0-1)+N]) & ((~RD_PTR[N] | ~WR_PTR[(0-1)+N]) & (WR_PTR[(0-1)+N] & ((RD_PTR[N] | WR_PTR[(0-1)+N]) | ~RD_PTR[N])))) ^ ((RD_PTR[N] | WR_PTR[(0-1)+N]) & ((~RD_PTR[N] & RD_PTR[N]) | (RD_PTR[N] & ~WR_PTR[(0-1)+N]))))))));
  wire 
       wDirClr = ((((~((WR_PTR[N] & (~RD_PTR[(0-1)+N] | RD_PTR[(0-1)+N])) ^ RD_PTR[(0-1)+N]) | WR_RST) & ((~((WR_PTR[N] & (~RD_PTR[(0-1)+N] | RD_PTR[(0-1)+N])) ^ RD_PTR[(0-1)+N]) | (RD_PTR[N] & ~WR_PTR[(0-1)+N])) & ((~WR_PTR[(0-1)+N] | WR_PTR[(0-1)+N]) & WR_PTR[(0-1)+N]))) & ~((~((WR_PTR[N] & (~RD_PTR[(0-1)+N] | RD_PTR[(0-1)+N])) ^ RD_PTR[(0-1)+N]) | WR_RST) & ((~((WR_PTR[N] & (~RD_PTR[(0-1)+N] | RD_PTR[(0-1)+N])) ^ RD_PTR[(0-1)+N]) | (RD_PTR[N] & ~WR_PTR[(0-1)+N])) & (RD_PTR[N] & (~WR_PTR[(0-1)+N] | WR_PTR[(0-1)+N]))))) | (~((~((WR_PTR[N] & (~RD_PTR[(0-1)+N] | RD_PTR[(0-1)+N])) ^ RD_PTR[(0-1)+N]) | WR_RST) & ((~((WR_PTR[N] & (~RD_PTR[(0-1)+N] | RD_PTR[(0-1)+N])) ^ RD_PTR[(0-1)+N]) | (RD_PTR[N] & ~WR_PTR[(0-1)+N])) & ((~WR_PTR[(0-1)+N] | WR_PTR[(0-1)+N]) & WR_PTR[(0-1)+N]))) & ((~((WR_PTR[N] & (~RD_PTR[(0-1)+N] | RD_PTR[(0-1)+N])) ^ RD_PTR[(0-1)+N]) | WR_RST) & ((~((WR_PTR[N] & (~RD_PTR[(0-1)+N] | RD_PTR[(0-1)+N])) ^ RD_PTR[(0-1)+N]) | (RD_PTR[N] & ~WR_PTR[(0-1)+N])) & (RD_PTR[N] & (~WR_PTR[(0-1)+N] | WR_PTR[(0-1)+N])))))) | WR_RST;
  reg   rRdValid = 0;
  reg   rEmpty = 1;
  reg   rFull = 0;
  wire 
       wATBEmpty = (RD_VALID | rRdValid) && (WR_PTR == RD_PTR_P1);
  wire  wATBFull = WR_VALID && (WR_PTR_P1 == RD_PTR);
  wire  wEmpty = (WR_PTR == RD_PTR) && !rDir;
  wire  wFull = rDir && (WR_PTR == RD_PTR);

  assign EMPTY = rEmpty || wATBEmpty;
  assign FULL = wATBFull || rFull;
  
  always @(posedge wDirSet or posedge wDirClr)
      if (wDirClr) rDir <= 1'b0;
      else rDir <= 1'b1;
  
  always @(posedge RD_CLK)
      begin
        rEmpty <= RD_RST ? 1'd1 : wEmpty;
        rRdValid <= RD_RST ? 1'd0 : RD_VALID;
      end
  
  always @(posedge WR_CLK)
      begin
        rFull <= WR_RST ? 1'd0 : wFull;
      end
endmodule

