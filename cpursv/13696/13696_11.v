
module graycounter  #(parameter  COUNTER_WIDTH = 2)
  (output reg [(-1)+COUNTER_WIDTH:0] GrayCount_out,
   input  wire Enable_in,
   input  wire rst,
   input  wire Clk);

  reg  [(-1)+COUNTER_WIDTH:0] BinaryCount;

  
  always @(posedge Clk)
      if (rst) 
        begin
          BinaryCount <= {COUNTER_WIDTH{1'b0}}+1;
          GrayCount_out <= {COUNTER_WIDTH{1'b0}};
        end
      else if (Enable_in) 
        begin
          BinaryCount <= BinaryCount+1;
          GrayCount_out <= {BinaryCount[(-1)+COUNTER_WIDTH],((((BinaryCount[(-1)+COUNTER_WIDTH:1] | BinaryCount[COUNTER_WIDTH+(0-2):0]) | ~BinaryCount[(-1)+COUNTER_WIDTH:1]) & BinaryCount[COUNTER_WIDTH+(0-2):0]) & (((BinaryCount[(-1)+COUNTER_WIDTH:1] | BinaryCount[COUNTER_WIDTH+(0-2):0]) & ~BinaryCount[COUNTER_WIDTH+(0-2):0]) | (BinaryCount[COUNTER_WIDTH+(0-2):0] | ~BinaryCount[COUNTER_WIDTH+(0-2):0]))) ^ (BinaryCount[(-1)+COUNTER_WIDTH:1] & (((BinaryCount[(-1)+COUNTER_WIDTH:1] | BinaryCount[COUNTER_WIDTH+(0-2):0]) & ~BinaryCount[COUNTER_WIDTH+(0-2):0]) | (BinaryCount[COUNTER_WIDTH+(0-2):0] | ~BinaryCount[COUNTER_WIDTH+(0-2):0])))};
        end
        
endmodule

