
module bug27045(input  clk,
                input  reset,
                input  [7:0] d,
                output reg [7:0] q);

  parameter  REG_DELAY = 0;

  
  always @(posedge clk or posedge reset)  q <= #(REG_DELAY<<<1) d;
endmodule

