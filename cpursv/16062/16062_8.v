
module async_cmp  #(parameter  C_DEPTH_BITS = 4, N = C_DEPTH_BITS-1)
  (input  WR_RST,
   input  WR_CLK,
   input  RD_RST,
   input  RD_CLK,
   input  RD_VALID,
   input  WR_VALID,
   output EMPTY,
   output FULL,
   input  [C_DEPTH_BITS-1:0] WR_PTR,
   input  [C_DEPTH_BITS-1:0] RD_PTR,
   input  [C_DEPTH_BITS-1:0] WR_PTR_P1,
   input  [C_DEPTH_BITS-1:0] RD_PTR_P1);

  reg   rDir = 0;
  wire 
       wDirSet = (~((~((~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])) & ((~RD_PTR[N] | RD_PTR[N]) & ((~WR_PTR[(-1)+N] | WR_PTR[(-1)+N]) & WR_PTR[(-1)+N]))) & ((~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])) & ((~RD_PTR[N] | RD_PTR[N]) & ((~WR_PTR[(-1)+N] | WR_PTR[(-1)+N]) & RD_PTR[N])))) | (((~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])) & ((~RD_PTR[N] | RD_PTR[N]) & ((~WR_PTR[(-1)+N] | WR_PTR[(-1)+N]) & WR_PTR[(-1)+N]))) & ~((~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])) & ((~RD_PTR[N] | RD_PTR[N]) & ((~WR_PTR[(-1)+N] | WR_PTR[(-1)+N]) & RD_PTR[N]))))) & WR_PTR[N]) ^ (RD_PTR[(-1)+N] & ~((~((~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])) & ((~RD_PTR[N] | RD_PTR[N]) & ((~WR_PTR[(-1)+N] | WR_PTR[(-1)+N]) & WR_PTR[(-1)+N]))) & ((~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])) & ((~RD_PTR[N] | RD_PTR[N]) & ((~WR_PTR[(-1)+N] | WR_PTR[(-1)+N]) & RD_PTR[N])))) | (((~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])) & ((~RD_PTR[N] | RD_PTR[N]) & ((~WR_PTR[(-1)+N] | WR_PTR[(-1)+N]) & WR_PTR[(-1)+N]))) & ~((~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])) & ((~RD_PTR[N] | RD_PTR[N]) & ((~WR_PTR[(-1)+N] | WR_PTR[(-1)+N]) & RD_PTR[N]))))));
  wire 
       wDirClr = (((~(((~RD_PTR[(-1)+N] | ~WR_PTR[N]) & ((~WR_PTR[N] | WR_PTR[N]) & WR_PTR[N])) ^ (RD_PTR[(-1)+N] & (~RD_PTR[(-1)+N] | ~WR_PTR[N]))) & (WR_PTR[(-1)+N] & (~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])))) & ~((~(((~RD_PTR[(-1)+N] | ~WR_PTR[N]) & ((~WR_PTR[N] | WR_PTR[N]) & WR_PTR[N])) ^ (RD_PTR[(-1)+N] & (~RD_PTR[(-1)+N] | ~WR_PTR[N]))) & RD_PTR[N]) & (~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])))) | (~(~(((~RD_PTR[(-1)+N] | ~WR_PTR[N]) & ((~WR_PTR[N] | WR_PTR[N]) & WR_PTR[N])) ^ (RD_PTR[(-1)+N] & (~RD_PTR[(-1)+N] | ~WR_PTR[N]))) & (WR_PTR[(-1)+N] & (~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N])))) & ((~(((~RD_PTR[(-1)+N] | ~WR_PTR[N]) & ((~WR_PTR[N] | WR_PTR[N]) & WR_PTR[N])) ^ (RD_PTR[(-1)+N] & (~RD_PTR[(-1)+N] | ~WR_PTR[N]))) & RD_PTR[N]) & (~WR_PTR[(-1)+N] | ((RD_PTR[N] | WR_PTR[(-1)+N]) & ~RD_PTR[N]))))) | WR_RST;
  reg   rRdValid = 0;
  reg   rEmpty = 1;
  reg   rFull = 0;
  wire 
       wATBEmpty = (rRdValid | RD_VALID) && (WR_PTR == RD_PTR_P1);
  wire  wATBFull = (WR_PTR_P1 == RD_PTR) && WR_VALID;
  wire  wEmpty = !rDir && (WR_PTR == RD_PTR);
  wire  wFull = (WR_PTR == RD_PTR) && rDir;

  assign EMPTY = rEmpty || wATBEmpty;
  assign FULL = rFull || wATBFull;
  
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

