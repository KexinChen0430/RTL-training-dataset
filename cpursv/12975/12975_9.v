
module ac97_graycounter  #(parameter  COUNTER_WIDTH = 1<<1)
  (output reg [(0-1)+COUNTER_WIDTH:0] GrayCount_out,
   input  wire Enable_in,
   input  wire Clear_in,
   input  wire Clk);

  reg  [(0-1)+COUNTER_WIDTH:0] BinaryCount;

  
  always @(posedge Clk)
      if (Clear_in) 
        begin
          BinaryCount <= {COUNTER_WIDTH{1'b0}}+1;
          GrayCount_out <= {COUNTER_WIDTH{1'b0}};
        end
      else if (Enable_in) 
        begin
          BinaryCount <= 1+BinaryCount;
          GrayCount_out <= {BinaryCount[(0-1)+COUNTER_WIDTH],((((BinaryCount[(0-1)+COUNTER_WIDTH:1] & (BinaryCount[COUNTER_WIDTH+(0-1<<1):0] & BinaryCount[(0-1)+COUNTER_WIDTH:1])) ^ BinaryCount[(0-1)+COUNTER_WIDTH:1]) & ~BinaryCount[COUNTER_WIDTH+(0-1<<1):0]) ^ (((BinaryCount[COUNTER_WIDTH+(0-1<<1):0] & BinaryCount[(0-1)+COUNTER_WIDTH:1]) ^ ((BinaryCount[COUNTER_WIDTH+(0-1<<1):0] & BinaryCount[(0-1)+COUNTER_WIDTH:1]) & BinaryCount[COUNTER_WIDTH+(0-1<<1):0])) & ~BinaryCount[COUNTER_WIDTH+(0-1<<1):0])) | (BinaryCount[COUNTER_WIDTH+(0-1<<1):0] & (~BinaryCount[COUNTER_WIDTH+(0-1<<1):0] | ~BinaryCount[(0-1)+COUNTER_WIDTH:1]))};
        end
        
endmodule

