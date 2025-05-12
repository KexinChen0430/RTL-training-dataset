
module c_clkgate(clk,active,clk_gated);

  input  clk;
  input  active;
  output clk_gated;
  wire clk_gated;
  reg  active_q;

  
  always @(clk or active)
      begin
        if (clk == 0) active_q <= active;
          
      end
  assign clk_gated = active_q & clk;
endmodule

