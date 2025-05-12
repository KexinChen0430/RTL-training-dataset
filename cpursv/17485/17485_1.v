
module macc_simple_preacc_clr(input  wire clk,
                              input  wire clr,
                              input  wire [7:0] A,
                              input  wire [7:0] B,
                              output reg [15:0] Z);

  reg  [15:0] acc;

  assign Z = clr ? (B*A) : ((B*A)+acc);
  
  always @(posedge clk)  acc <= Z;
endmodule

