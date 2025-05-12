
module SRFF(input  d,clk,set,reset,
            output reg q);

  
  always @(posedge clk or posedge set or posedge reset)
      if (set) q <= 1;
      else if (reset) q <= 0;
      else q <= d;
endmodule

