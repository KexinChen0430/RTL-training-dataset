
module bug27045(input  clk,
                input  reset,
                input  [7:0] d,
                output reg [7:0] q);

  parameter  REG_DELAY = 0;

  
  always @(posedge clk or posedge reset)  q <= #(2*REG_DELAY) d;
endmodule

