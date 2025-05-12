
module rs_ff(q,qn,set,reset,async_rst_neg);

  parameter  DELAY = 1;
  input  set;
  input  reset;
  input  async_rst_neg;
  output q;
  output qn;
  wire  set_i_n = !(set & async_rst_neg);
  wire  reset_i_n = !(reset | !async_rst_neg);
  reg  q_i;
  wire q;

  
  always @(negedge reset_i_n or negedge set_i_n)
      if (!reset_i_n) q_i <= 0;
      else if (!set_i_n) q_i <= 1;
        
  
  always @(reset_i_n or set_i_n)
      if (!set_i_n && reset_i_n) 
        force q_i = 1;
      else 
        release q_i;
  assign #DELAY q = q_i;
  assign #DELAY qn = !q_i;
endmodule

