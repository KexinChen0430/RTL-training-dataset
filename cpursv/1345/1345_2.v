
module bw_clk_cclk_scanlasr_2x(so,sd,ck,r_l);

  output so;
  input  sd,ck,r_l;
  reg  so_l;

  assign so = ~so_l;
  
  always @(ck or sd or r_l)
      if (~(r_l & ck)) so_l <= ~sd;
        
endmodule

