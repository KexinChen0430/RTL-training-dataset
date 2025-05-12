
module divM(input  wire clk_in,
            output wire clk_out);

  parameter  M = 12;
  localparam  N = $clog2(M);
  reg  [(-1)+N:0]  divcounter = 0;

  
  always @(posedge clk_in)
      if (divcounter == ((-1)+M)) divcounter <= 0;
      else divcounter <= 1+divcounter;
  assign clk_out = divcounter[(-1)+N];
endmodule

