
module count4(input  wire clk,
              input  wire reset,
              input  wire enable,
              output wire out);

  reg  [1:0]  cnt = 0;

  
  always @(posedge clk)
      if (reset) cnt <= 0;
      else if ((cnt != 3) && enable) cnt <= 2'b1+cnt;
        
  assign out = cnt == 3;
endmodule

