
module wr_ptr_full  #(parameter  C_DEPTH_BITS = 4)
  (input  WR_CLK,
   input  WR_RST,
   input  WR_EN,
   output WR_FULL,
   output [(0-1)+C_DEPTH_BITS:0] WR_PTR,
   output [(0-1)+C_DEPTH_BITS:0] WR_PTR_P1,
   input  CMP_FULL);

  reg   rFull = 0;
  reg   rFull2 = 0;
  reg  [(0-1)+C_DEPTH_BITS:0]  rPtr = 0;
  reg  [(0-1)+C_DEPTH_BITS:0]  rPtrP1 = 0;
  reg  [(0-1)+C_DEPTH_BITS:0]  rBin = 0;
  reg  [(0-1)+C_DEPTH_BITS:0]  rBinP1 = 1;
  wire [(0-1)+C_DEPTH_BITS:0] wGrayNext;
  wire [(0-1)+C_DEPTH_BITS:0] wGrayNextP1;
  wire [(0-1)+C_DEPTH_BITS:0] wBinNext;
  wire [(0-1)+C_DEPTH_BITS:0] wBinNextP1;

  assign WR_FULL = rFull;
  assign WR_PTR = rPtr;
  assign WR_PTR_P1 = rPtrP1;
  
  always @(posedge WR_CLK or posedge WR_RST)
      begin
        if (WR_RST) 
          begin
            rBin <= #1 0;
            rBinP1 <= #1 1;
            rPtr <= #1 0;
            rPtrP1 <= #1 0;
          end
        else 
          begin
            rBin <= #1 wBinNext;
            rBinP1 <= #1 wBinNextP1;
            rPtr <= #1 wGrayNext;
            rPtrP1 <= #1 wGrayNextP1;
          end
      end
  assign wBinNext = !rFull ? (rBin+WR_EN) : rBin;
  assign wBinNextP1 = !rFull ? (WR_EN+rBinP1) : rBinP1;
  assign wGrayNext = wBinNext ^ (wBinNext>>1 & (wBinNext | ~wBinNext));
  assign wGrayNextP1 = ((((wBinNextP1>>1 & (wBinNextP1 & ((~wBinNextP1 | wBinNextP1) & wBinNextP1>>1))) ^ (wBinNextP1 & wBinNextP1>>1)) & ~wBinNextP1>>1) ^ (~wBinNextP1>>1 & (wBinNextP1 ^ (wBinNextP1 & (wBinNextP1 & wBinNextP1>>1))))) | (wBinNextP1>>1 & (((~wBinNextP1 | wBinNextP1) & ~wBinNextP1>>1) | ~wBinNextP1));
  
  always @(posedge WR_CLK)
      begin
        if (WR_RST) {rFull,rFull2} <= #1 2'b00;
        else if (CMP_FULL) {rFull,rFull2} <= #1 2'b11;
        else {rFull,rFull2} <= #1 {rFull2,CMP_FULL};
      end
endmodule

