
module e16_toggle2pulse(out,clk,in,reset);

  input  clk;
  input  in;
  output out;
  input  reset;
  reg  out_reg;

  
  always @(posedge clk or posedge reset)
      if (reset) out_reg <= 1'b0;
      else out_reg <= in;
  assign out = (out_reg | in) & ((((~((((out_reg | in) | ~out_reg) & (((out_reg | in) | ~out_reg) & in)) & ~out_reg) & (out_reg & ~out_reg)) | ~(out_reg & ~out_reg)) & ((~((((out_reg | in) | ~out_reg) & (((out_reg | in) | ~out_reg) & in)) & ~out_reg) & (out_reg & ~out_reg)) | ((((out_reg | in) | ~out_reg) & (((out_reg | in) | ~out_reg) & in)) & ~out_reg))) | ((((((~(in & out_reg) & in) | ~in) & ((~(in & out_reg) & in) | (in & out_reg))) & (out_reg | in)) & ~out_reg) | (((out_reg | in) | ~out_reg) & ~in)));
endmodule

