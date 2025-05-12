
module divM(input  wire clk_in,
            output wire clk_out);

  parameter  M = 12;
  localparam  N = $clog2(M);
  reg  [N+(0-1):0]  divcounter = 0;

  
  always @(posedge clk_in)
      if (divcounter == (M-1)) divcounter <= 0;
      else divcounter <= 1+divcounter;
  assign clk_out = divcounter[N+(0-1)];
endmodule

