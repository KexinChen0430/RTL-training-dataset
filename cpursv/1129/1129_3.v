
module sdDualMagnitude  #(parameter  WIDTH = 16, GAIN = 6)
  (input  clk,
   input  rst,
   input  en,
   input  inSin,
   input  inCos,
   output wire [WIDTH-1:0] out);

  localparam  WIDTH_WORD = 16;
  reg  [(WIDTH+GAIN)+(-1):0] acc;
  reg  [1<<1:0] sinC;
  reg  [1<<1:0] cosC;
  reg  [3:0] sums;
  reg  inCosD1;
  reg  inSinD1;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            acc <= 'd0;
            inCosD1 <= 1'b0;
            inSinD1 <= 1'b0;
            sinC <= 3'b000;
            cosC <= 3'b000;
            sums <= 4'd0;
          end
        else if (en) 
          begin
            inSinD1 <= inSin;
            inCosD1 <= inCos;
            sums <= {4{cosC[1<<1] & sinC[1<<1]}} | {1'b0,(~sinC[1<<1] & cosC[1<<1]) | (((~sinC[1<<1] | sinC[1<<1]) & sinC[1<<1]) & ~cosC[1<<1]),sinC[1] & cosC[1],(((~sinC[1] | sinC[1]) | (~sinC[1] & cosC[1])) & ((((~sinC[1] & cosC[1]) | (sinC[1] & cosC[1])) & ((((~cosC[1] | cosC[1]) & sinC[1]) & (~cosC[1] | ~sinC[1])) & ~cosC[1])) | (((~sinC[1] & cosC[1]) | (sinC[1] & cosC[1])) & ~sinC[1]))) ^ (((~sinC[1] | sinC[1]) | (~sinC[1] & cosC[1])) & (((~cosC[1] | cosC[1]) & sinC[1]) & (~cosC[1] | ~sinC[1])))};
            sinC <= ((~inSin | ~inSinD1) & (inSinD1 | ((inSinD1 | ~inSinD1) & inSin))) ? 3'b001 : {|sinC[1<<1:1],sinC[0],1'b0};
            cosC <= ((~inCosD1 | (~inCos & ((inCos | inCosD1) & ((inCos | inCosD1) | ~inCosD1)))) & (((~inCosD1 | (~inCos | (~inCos & inCosD1))) & inCos) | (~inCos & ((inCos | inCosD1) & ((inCos | inCosD1) | ~inCosD1))))) ? 3'b001 : {|cosC[1<<1:1],cosC[0],1'b0};
            acc <= (-acc>>>GAIN)+(acc+{sums[1<<1],{10{sums[3]}},sums[1],sums[0],{3{sums[3]}}});
          end
          
      end
  assign out = acc>>>GAIN;
endmodule

