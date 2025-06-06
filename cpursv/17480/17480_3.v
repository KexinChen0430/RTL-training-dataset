
module macc_simple_clr(input  wire clk,
                       input  wire clr,
                       input  wire [7:0] A,
                       input  wire [7:0] B,
                       output reg [15:0] Z);

  
  always @(posedge clk)
      if (clr) Z <= B*A;
      else Z <= Z+(B*A);
endmodule

