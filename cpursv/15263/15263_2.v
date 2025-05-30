
module coreir_reg_arst  #(parameter 
       width        = 1,
       arst_posedge = 1,
       clk_posedge  = 1,
       init         = 1)
  (input  clk,
   input  arst,
   input  [(-1)+width:0] in,
   output [(-1)+width:0] out);

  reg  [(-1)+width:0] outReg;
  wire real_rst;

  assign real_rst = arst_posedge ? arst : ~arst;
  wire real_clk;

  assign real_clk = clk_posedge ? clk : ~clk;
  
  always @(posedge real_clk or posedge real_rst)
      begin
        if (real_rst) outReg <= init;
        else outReg <= in;
      end
  assign out = outReg;
endmodule

