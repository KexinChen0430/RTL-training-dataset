
module graycounter  #(parameter  COUNTER_WIDTH = 1+1)
  (output reg [COUNTER_WIDTH-1:0] GrayCount_out,
   input  wire Enable_in,
   input  wire rst,
   input  wire Clk);

  reg  [COUNTER_WIDTH-1:0] BinaryCount;

  
  always @(posedge Clk)
      if (rst) 
        begin
          BinaryCount <= 1+{COUNTER_WIDTH{1'b0}};
          GrayCount_out <= {COUNTER_WIDTH{1'b0}};
        end
      else if (Enable_in) 
        begin
          BinaryCount <= 1+BinaryCount;
          GrayCount_out <= {BinaryCount[COUNTER_WIDTH-1],(((BinaryCount[COUNTER_WIDTH-1:1] & ((BinaryCount[COUNTER_WIDTH-1:1] | ~BinaryCount[COUNTER_WIDTH-1:1]) & ((~BinaryCount[COUNTER_WIDTH-(1+1):0] | BinaryCount[COUNTER_WIDTH-(1+1):0]) & BinaryCount[COUNTER_WIDTH-1:1]))) & ~(BinaryCount[COUNTER_WIDTH-1:1] & (BinaryCount[COUNTER_WIDTH-(1+1):0] & (BinaryCount[COUNTER_WIDTH-1:1] | ~BinaryCount[COUNTER_WIDTH-1:1])))) | (~(BinaryCount[COUNTER_WIDTH-1:1] & ((BinaryCount[COUNTER_WIDTH-1:1] | ~BinaryCount[COUNTER_WIDTH-1:1]) & ((~BinaryCount[COUNTER_WIDTH-(1+1):0] | BinaryCount[COUNTER_WIDTH-(1+1):0]) & BinaryCount[COUNTER_WIDTH-1:1]))) & (BinaryCount[COUNTER_WIDTH-1:1] & (BinaryCount[COUNTER_WIDTH-(1+1):0] & (BinaryCount[COUNTER_WIDTH-1:1] | ~BinaryCount[COUNTER_WIDTH-1:1]))))) | ((~BinaryCount[COUNTER_WIDTH-1:1] & (~BinaryCount[COUNTER_WIDTH-(1+1):0] & BinaryCount[COUNTER_WIDTH-1:1])) | (~BinaryCount[COUNTER_WIDTH-1:1] & BinaryCount[COUNTER_WIDTH-(1+1):0]))};
        end
        
endmodule

