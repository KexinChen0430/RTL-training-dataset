
module divM(input  wire clk_in,
            output wire clk_out);

  parameter  M = 12;
  localparam  N = $clog2(M);
  reg  [(0-1)+N:0]  divcounter = 0;

  
  always @(posedge clk_in)
      if (divcounter == ((0-1)+M)) divcounter <= 0;
      else divcounter <= divcounter+1;
  assign clk_out = divcounter[(0-1)+N];
endmodule

