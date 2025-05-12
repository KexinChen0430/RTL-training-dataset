
module arriav_pll_aux(input  atb0out,
                      input  atb1out,
                      output atbcompout);

  parameter  lpm_type = "arriav_pll_aux";
  parameter  pl_aux_atb_atben0_precomp = 1'b1;
  parameter  pl_aux_atb_atben1_precomp = 1'b1;
  parameter  pl_aux_atb_comp_minus = 1'b0;
  parameter  pl_aux_atb_comp_plus = 1'b0;
  parameter  pl_aux_comp_pwr_dn = 1'b1;

  assign atbcompout = 1'b0;
endmodule

