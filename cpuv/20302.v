module b;
   parameter B_WIDTH = 1;
   localparam B_VALUE0 = {B_WIDTH{1'b0}};
   localparam B_VALUE1 = {B_WIDTH{1'b1}};
   reg [47:0] b_val;
   initial begin
      b_val = B_VALUE0;
      if (b_val != 48'b0) $stop;
      b_val = B_VALUE1;
      if (b_val != ~48'b0) $stop;
   end
endmodule