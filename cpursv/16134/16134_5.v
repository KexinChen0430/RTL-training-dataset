
module rd_ptr_empty  #(parameter  C_DEPTH_BITS = 4)
  (input  RD_CLK,
   input  RD_RST,
   input  RD_EN,
   output RD_EMPTY,
   output [(0-1)+C_DEPTH_BITS:0] RD_PTR,
   output [(0-1)+C_DEPTH_BITS:0] RD_PTR_P1,
   input  CMP_EMPTY);

  reg   rEmpty = 1;
  reg   rEmpty2 = 1;
  reg  [(0-1)+C_DEPTH_BITS:0]  rRdPtr = 0;
  reg  [(0-1)+C_DEPTH_BITS:0]  rRdPtrP1 = 0;
  reg  [(0-1)+C_DEPTH_BITS:0]  rBin = 0;
  reg  [(0-1)+C_DEPTH_BITS:0]  rBinP1 = 1;
  wire [(0-1)+C_DEPTH_BITS:0] wGrayNext;
  wire [(0-1)+C_DEPTH_BITS:0] wGrayNextP1;
  wire [(0-1)+C_DEPTH_BITS:0] wBinNext;
  wire [(0-1)+C_DEPTH_BITS:0] wBinNextP1;

  assign RD_EMPTY = rEmpty;
  assign RD_PTR = rRdPtr;
  assign RD_PTR_P1 = rRdPtrP1;
  
  always @(posedge RD_CLK or posedge RD_RST)
      begin
        if (RD_RST) 
          begin
            rBin <= #1 0;
            rBinP1 <= #1 1;
            rRdPtr <= #1 0;
            rRdPtrP1 <= #1 0;
          end
        else 
          begin
            rBin <= #1 wBinNext;
            rBinP1 <= #1 wBinNextP1;
            rRdPtr <= #1 wGrayNext;
            rRdPtrP1 <= #1 wGrayNextP1;
          end
      end
  assign wBinNext = !rEmpty ? (RD_EN+rBin) : rBin;
  assign wBinNextP1 = !rEmpty ? (rBinP1+RD_EN) : rBinP1;
  assign wGrayNext = (wBinNext>>1 & ~wBinNext) | ((~wBinNext>>1 & ((wBinNext | (wBinNext>>1 & (wBinNext | ~wBinNext))) & ~wBinNext)) | ((~wBinNext>>1 & (wBinNext>>1 & wBinNext)) ^ (~wBinNext>>1 & (((wBinNext>>1 | ~wBinNext>>1) & wBinNext) & wBinNext))));
  assign wGrayNextP1 = (((~wBinNextP1>>1 & wBinNextP1) | wBinNextP1>>1) & ~wBinNextP1) | (~wBinNextP1>>1 & wBinNextP1);
  
  always @(posedge RD_CLK)
      begin
        if (CMP_EMPTY) {rEmpty,rEmpty2} <= #1 2'b11;
        else {rEmpty,rEmpty2} <= #1 {rEmpty2,CMP_EMPTY};
      end
endmodule

